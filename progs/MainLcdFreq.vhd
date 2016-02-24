----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:06:17 02/21/2016 
-- Design Name: 
-- Module Name:    MainLcdTest - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: double the 8 switch bit into an 16 bit value and display it 
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

entity MainLcdTest is
    Port ( 
	 	pi_clk : in STD_LOGIC ;
		pi_sw : in  STD_LOGIC_VECTOR (7 downto 0);
		po_hex : out  STD_LOGIC_VECTOR (10 downto 0) -- 6 bit segments then 4 bit quadrant
	 );
end MainLcdTest;

architecture Behavioral of MainLcdTest is
	signal vv : unsigned (15 downto 0)  := (others => '0');
	signal hv : STD_LOGIC_VECTOR (3 downto 0);
	
component m8seg_disp_hex   Port ( 
	 	pi_clk : in STD_LOGIC ; -- clock 32 mhz
		pi_value : in  unsigned (15 downto 0); -- value to display
		po_hex : out  STD_LOGIC_VECTOR (10 downto 0) -- segment pin (6) and quadrant pin (4)
	 );
end component;

begin
	process(pi_sw) begin
			vv (7 downto 0) <= unsigned (pi_sw);
			vv (15 downto 8) <= unsigned (pi_sw);
	end process;
	disp : m8seg_disp_hex 
		port map (
			pi_clk => pi_clk,
			pi_value => vv,
			po_hex => po_hex 
			);
			

end Behavioral;

