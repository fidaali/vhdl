----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:12:58 02/23/2016 
-- Design Name: 
-- Module Name:    AffLcd16 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AffLcd16 is
   Port ( 
	 	pi_clk : in STD_LOGIC ;
		pi_val : in  STD_LOGIC_VECTOR (15 downto 0);
		po_hex : out  STD_LOGIC_VECTOR (6 downto 0);
		po_hex_a : out  STD_LOGIC_VECTOR (3 downto 0)
	 );
end AffLcd16;

architecture Behavioral of AffLcd16 is
component dispselan
PORT (
				clk : in  STD_LOGIC;
				iv : in  STD_LOGIC_VECTOR (15 downto 0);	
				swcommand : in STD_LOGIC_VECTOR (7 downto 0);
				an : out  STD_LOGIC_VECTOR (3 downto 0);
				ov :out  STD_LOGIC_VECTOR (3 downto 0)
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
	uelan : dispselan 
		port map (
			clk => pi_clk,
			iv => pi_val,
		   an => po_hex_a,
			swcommand => "00000000",
			ov => hv
			);
	-- O_HEX_A <= "0000";
			
	uhalfw : disphalfw 
		port map (
		   v => hv,
			-- v => vv (3 downto 0),
			seg => po_hex
			);	
end Behavioral;

