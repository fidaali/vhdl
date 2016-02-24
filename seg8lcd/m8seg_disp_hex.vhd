----------------------------------------------------------------------------------
-- Company: 
-- Engineer: fidaali 
-- 
-- Create Date:    15:12:58 02/23/2016 
-- Design Name: 
-- Module Name:    m8seg_disp_hex - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:  display a 16 bit value to the 8 seg display pins, given 32 mzh clock
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

entity m8seg_disp_hex is
   Port ( 
	 	pi_clk : in STD_LOGIC ; -- clock 32 mhz
		pi_value : in  unsigned (15 downto 0); -- value to display
		po_hex : out  STD_LOGIC_VECTOR (9 downto 0); -- segment pin (6) and quadrant pin (4)
	 );
end AffLcd16;

architecture Behavioral of m8seg_disp_hex is
component m8seg_refresh_hex 
PORT (
				pi_clk : in  STD_LOGIC;
				pi_value : in  unsigned (15 downto 0);	
				pi_refresh : in unsigned (2 downto 0);
				po_q_num : out  STD_LOGIC_VECTOR (3 downto 0);
				po_hex_val :out  STD_LOGIC_VECTOR (3 downto 0)
);
end component;

signal hv : STD_LOGIC_VECTOR (3 downto 0);

component disphalfw
PORT (
			v : in  STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           seg : out  STD_LOGIC_VECTOR (6 downto 0)
);
end component;	

begin
	refresh : m8seg_refresh_hex 
		port map (
			pi_clk => pi_clk,
			pi_value => pi_value,
			pi_refresh => "111",
			po_q_num => v, 
			po_hex_val=> hv
			);
	-- O_HEX_A <= "0000";
			
	disp1digit : m8seg_disp1digit_hex 
		port map (
	   		pi_value => hv,
			po_seg => po_hex (9 downto 4)
			);	
	po_hex_val (3 downto 0) <= v;
end Behavioral;

