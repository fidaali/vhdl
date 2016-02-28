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
use IEEE.NUMERIC_STD.ALL;

entity main2 is
    Port (
		I_CLK : in STD_LOGIC ;
		I_SW : in  STD_LOGIC_VECTOR (7 downto 0);
		O_LED : out  STD_LOGIC_VECTOR (7 downto 0);
		O_VGA : out  STD_LOGIC_VECTOR (9 downto 0);
		O_HEX : out  STD_LOGIC_VECTOR (10 downto 0)
	);
end main2;




architecture Behavioral of main2 is

	COMPONENT clock25mhz
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKFX_OUT : OUT std_logic;
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		LOCKED_OUT : OUT std_logic
		);
	END COMPONENT;

component MainVgaTest
			port (
				pi_clk : in STD_LOGIC ;
				pi_sw: in  STD_LOGIC_VECTOR (7 downto 0);
				po_vga : out STD_LOGIC_VECTOR (9 downto 0)
			);	
end component;
	signal pi_clock25mhz : STD_LOGIC;

begin

	Inst_clock25mhz: clock25mhz PORT MAP(
		CLKIN_IN => I_CLK,
		RST_IN => '0',
		CLKFX_OUT => pi_clock25mhz,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT => open,
		LOCKED_OUT => open
	);

			
	call3 : MainVgaTest
	port map (
		pi_clk => pi_clock25mhz,
		pi_sw => "00000111",
		po_vga => O_VGA
	);			
	
	O_LED <= I_SW;
	O_HEX <= "11111111111";
	
end Behavioral;

