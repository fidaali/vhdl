----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:06:17 02/21/2016 
-- Design Name: 
-- Module Name:    - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vgacursor is
    Port ( 
	 	pi_clk : in STD_LOGIC ;
		pi_joyx : in  unsigned (10 downto 0);
		pi_joyy : in  unsigned (10 downto 0);
		pi_joyon : in STD_LOGIC;
		po_vga : out  STD_LOGIC_VECTOR (9 downto 0)
	 );
end vgacursor;

architecture Behavioral of vgacursor is

component vga640rate 
    Port ( 
	pi_clk32mhz : in  STD_LOGIC;
   po_hpix : out unsigned (10 downto 0); -- current line number for display
	po_vpix : out unsigned (10 downto 0); -- current column number for display
	po_pixon : out STD_LOGIC; -- when 1 display is on time to choose the colors when 0 black pixel only
	po_h_sync : out STD_LOGIC; -- horizontal retrace signal :: 1 when tracing back to left 
	po_v_sync : out STD_LOGIC -- vertical retrace signal :: 1 when tracing back top 
			  );
end component;

component ModVga3Neigh 
    Port ( 
    	pi_clk : in STD_LOGIC;
		pi_sw : in  STD_LOGIC_VECTOR (7 downto 0);
		pi_hsync : in STD_LOGIC;
		pi_vsync : in STD_LOGIC;
		pi_on : in STD_LOGIC;
		pi_pixh : unsigned (10 downto 0);
		po_vga : out  STD_LOGIC_VECTOR (7 downto 0)
	 );
end component;


signal	hpix : unsigned (10 downto 0); -- current line number for display
signal	vpix : unsigned (10 downto 0); -- current column number for display
signal	pixon : STD_LOGIC; -- when 1 display is on time to choose the colors when 0 black pixel only
signal	h_sync : STD_LOGIC; -- horizontal retrace signal :: 1 when tracing back to left 
signal	v_sync : STD_LOGIC; -- vertical retrace signal :: 1 when tracing back top 

	signal couleur  :std_logic_vector (7 downto 0);

begin

		calc : vga640rate 
		port map (
			pi_clk32mhz => pi_clk,
			po_hpix=> hpix,
			po_vpix => vpix, 
			po_pixon => pixon,
			po_h_sync => h_sync,
			po_v_sync => v_sync
			);

	po_vga(0) <= v_sync;
	po_vga(1) <= h_sync;
	
	call3 : ModVga3Neigh 
    Port map ( 
    	pi_clk => pi_clk,
		pi_sw => "00000000",
		pi_hsync => h_sync,
		pi_vsync => v_sync,
		pi_on => pixon,
		pi_pixh => hpix,
		po_vga => couleur
	);
	
	process(	pixon, hpix, vpix, pi_joyx, pi_joyy) begin
		if(pixon='1' )  then
		--couleur <= std_logic_vector(hpix (7 downto 0)) xor std_logic_vector(vpix (7 downto 0));
			if(pi_joyx /= hpix or pi_joyy /= vpix) then
				if(pi_joyx=hpix and pi_joyy /= vpix) then
					po_vga( 9 downto 2)  <= "00000000";
				else 
					if(pi_joyy=vpix and pi_joyx /= hpix ) then
							po_vga( 9 downto 2)  <= "11111111";
						else
							po_vga( 9 downto 2) <= couleur;
					end if;
				end if;
			end if;
		else
			po_vga( 9 downto 2) <= "00000000";
		end if;
	end process;
	

		

end Behavioral;

