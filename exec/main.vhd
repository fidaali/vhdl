----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:36:06 02/17/2016 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
    Port (
		I_CLK : in STD_LOGIC ;
		I_SW : in  STD_LOGIC_VECTOR (7 downto 0);
		O_LED : out  STD_LOGIC_VECTOR (7 downto 0);
	--	O_VGA : out  STD_LOGIC_VECTOR (0 downto 0);
		O_HEX : out  STD_LOGIC_VECTOR (9 downto 0);
	);
end main;




architecture Behavioral of main is
	signal vv : STD_LOGIC_VECTOR (15 downto 0)  := (others => '0');
	signal hv : STD_LOGIC_VECTOR (3 downto 0);
	
component MainLcdTest
PORT (
	 	pi_clk : in STD_LOGIC ;
		pi_sw : in  STD_LOGIC_VECTOR (7 downto 0);
		po_led : out  STD_LOGIC_VECTOR (7 downto 0);
	--	po_vga : out  STD_LOGIC_VECTOR (0 downto 0);
		po_hex : out  STD_LOGIC_VECTOR (6 downto 0);
);
end component;	


begin

	call0 : _MainLcdTest -- MainLcdTest 
		port map (
			pi_clk => I_CLK,
			pi_sw => I_SW,
			po_hex => O_HEX,
			);
	O_LED <= I_CLK;
end Behavioral;

