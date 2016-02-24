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

entity MainDispVgaRate is
    Port ( 
	 	pi_clk : in STD_LOGIC ;
		pi_sw : in  STD_LOGIC_VECTOR (7 downto 0);
		po_hex : out  STD_LOGIC_VECTOR (10 downto 0) -- 6 bit segments then 4 bit quadrant
	 );
end MainDispVgaRate;

architecture Behavioral of MainDispVgaRate is
	signal vv : unsigned (15 downto 0)  := (others => '0');
	signal hv : STD_LOGIC_VECTOR (3 downto 0);

component vga640rate 
    Port ( 
	pi_clk32mhz : in  STD_LOGIC;
   po_hpix : out STD_LOGIC_VECTOR (10 downto 0); -- current line number for display
	po_vpix : out STD_LOGIC_VECTOR (10 downto 0); -- current column number for display
	po_pixon : out STD_LOGIC; -- when 1 display is on time to choose the colors when 0 black pixel only
	po_h_sync : out STD_LOGIC; -- horizontal retrace signal :: 1 when tracing back to left 
	po_v_sync : out STD_LOGIC -- vertical retrace signal :: 1 when tracing back top 
			  
			  );
end component;

component m8seg_disp_hex   Port ( 
	 	pi_clk : in STD_LOGIC ; -- clock 32 mhz
		pi_value : in  unsigned (15 downto 0); -- value to display
		po_hex : out  STD_LOGIC_VECTOR (10 downto 0) -- segment pin (6) and quadrant pin (4)
	 );
end component;


signal  hpix : STD_LOGIC_VECTOR (10 downto 0); -- current line number for display
signal	vpix : STD_LOGIC_VECTOR (10 downto 0); -- current column number for display
signal	pixon : STD_LOGIC; -- when 1 display is on time to choose the colors when 0 black pixel only
signal	h_sync : STD_LOGIC; -- horizontal retrace signal :: 1 when tracing back to left 
signal	v_sync : STD_LOGIC; -- vertical retrace signal :: 1 when tracing back top 
	
signal c_pixon : unsigned (31 downto 0) := (others => '0');
signal c_h_sync: unsigned (31 downto 0) := (others => '0');
signal c_v_sync : unsigned (31 downto 0) := (others => '0');
signal c_clk : unsigned (31 downto 0) := (others => '0');

signal v_pixon : unsigned (31 downto 0) := (others => '0');
signal v_h_sync: unsigned (31 downto 0) := (others => '0');
signal v_v_sync : unsigned (31 downto 0) := (others => '0');



signal aff : unsigned (31 downto 0) := (others => '0');
signal o_aff : unsigned (15 downto 0) := (others => '0');

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
			
			disp : m8seg_disp_hex
				port map (
					pi_clk=>pi_clk,
					pi_value=> o_aff ,
					po_hex => po_hex
				);			

	process(pi_sw,pi_clk,h_sync,v_sync,
	 c_clk, c_pixon, c_h_sync, c_v_sync,
	 v_pixon, v_h_sync, v_v_sync
	) begin


		if rising_edge(pi_clk) then
			c_clk<=c_clk+1;
		end if;
		if( rising_edge(pi_clk) and pixon = '1') then
			c_pixon<=c_pixon+1;
		end if;
		if rising_edge(h_sync) then
			c_h_sync<=c_h_sync+1;	
		end if;
		if rising_edge(v_sync) then
			c_v_sync<=c_v_sync+1;	
		end if;
		
		if(c_clk=32000000 and rising_edge(pi_clk)) then
			v_pixon<=c_pixon;
			v_h_sync<=c_h_sync;
			v_v_sync<=c_v_sync;
		end if;				
		
		if(c_clk=32000000) then
			c_clk<="00000000000000000000000000000000";
		end if;

		case (pi_sw) is
			when "00000101"=> aff<=c_clk;
			when "00000001"=> aff<=v_pixon;
			when "00000011"=> aff<=v_h_sync;
			when "00000111"=> aff<=v_v_sync;

			when "00001101"=> aff<=c_clk;
			when "00001001"=> aff<=v_pixon;
			when "00001011"=> aff<=v_h_sync;
			when "00001111"=> aff<=v_v_sync;
			when others => aff <= "00000000000000000000000000000000"  ;
		end case;	

		if(pi_sw(3) = '0') then
			o_aff<= aff(15 downto 0);
		else
			o_aff<= aff(31 downto 16);
		end if;

	end process;
		

end Behavioral;

