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
		I_JOY : in  STD_LOGIC_VECTOR (4 downto 0);
		O_LED : out  STD_LOGIC_VECTOR (7 downto 0);
		O_VGA : out  STD_LOGIC_VECTOR (9 downto 0);
		O_AUDIO : out  std_logic ;

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
	
component virtcursor
			port (
			pi_clk32mhz : in  STD_LOGIC;
   		pi_hardpin : in STD_LOGIC_VECTOR ( 4 downto 0 );

   		po_xpos : out unsigned ( 10 downto 0);
   		po_ypos : out unsigned ( 10 downto 0)
			);	
end component;

component vgacursor
			port (
				pi_clk : in STD_LOGIC ;
				pi_joyx : in  unsigned (10 downto 0);
				pi_joyy : in  unsigned (10 downto 0);
				pi_joyon : in STD_LOGIC;
				po_vga : out STD_LOGIC_VECTOR (9 downto 0)
			);	
end component;
	signal pi_clock25mhz : STD_LOGIC;
	
	signal const_jx : unsigned (10 downto 0) := "00000100000";
	signal const_jy : unsigned (10 downto 0) := "00001000000";



begin

	Inst_clock25mhz: clock25mhz PORT MAP(
		CLKIN_IN => I_CLK,
		RST_IN => '0',
		CLKFX_OUT => pi_clock25mhz,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT => open,
		LOCKED_OUT => open
	);
	
	Inst_virtcursor: virtcursor PORT MAP(
			pi_clk32mhz => pi_clock25mhz,
   		pi_hardpin => (not I_JOY),

   		po_xpos => const_jx,
   		po_ypos => const_jy
	);	

			
	call3 : vgacursor
	port map (
		pi_clk => pi_clock25mhz,
		pi_joyx => const_jx,
		pi_joyy => const_jy,
		pi_joyon => '1',
		po_vga => O_VGA
	);			
	
	O_LED <= I_SW or ("000" & not I_JOY);
	O_HEX <= "11111111111";
	O_AUDIO <= '0';
	
end Behavioral;

