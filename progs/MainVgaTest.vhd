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

entity MainVgaTest is
    Port ( 
	 	pi_clk : in STD_LOGIC ;
		pi_sw : in  STD_LOGIC_VECTOR (7 downto 0);
		--po_hex : out  STD_LOGIC_VECTOR (10 downto 0) -- 6 bit segments then 4 bit quadrant
		po_vga : out  STD_LOGIC_VECTOR (9 downto 0)
	 );
end MainVgaTest;

architecture Behavioral of MainVgaTest is

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


signal	hpix : unsigned (10 downto 0); -- current line number for display
signal	vpix : unsigned (10 downto 0); -- current column number for display
signal	pixon : STD_LOGIC; -- when 1 display is on time to choose the colors when 0 black pixel only
signal	h_sync : STD_LOGIC; -- horizontal retrace signal :: 1 when tracing back to left 
signal	v_sync : STD_LOGIC; -- vertical retrace signal :: 1 when tracing back top 

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
	
	process(	pixon, hpix, vpix, pi_sw) begin
		if(pixon='1' ) and ( 
		( (hpix /= 1) and (hpix /= 5) and (hpix /= 320) and (hpix /= 638) )
		and
		( (vpix /= 1) and  (vpix /= 478) )
		
		)  then
		
			case (pi_sw) is
				when "00000001" => po_vga( 9 downto 2) <= "11100000";
				when "00000010" => po_vga( 9 downto 2) <= "00011100";
				when "00000100" => po_vga( 9 downto 2) <= "00000011";
				when others => po_vga( 9 downto 2)  <= 
				(std_logic_vector (hpix (7 downto 0)) xor std_logic_vector(vpix (7 downto 0)));
			end case;
			-- po_vga( 9 downto 2) <= pi_sw;
		else
			po_vga( 9 downto 2) <= "00000000";
		end if;
			
	end process;
	

		

end Behavioral;

