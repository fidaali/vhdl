----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:06:17 02/21/2016 
-- Design Name: 
-- Module Name:    MainLcdFreq - Behavioral 
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

entity MainLcdFreq is
    Port ( 
	 	pi_clk : in STD_LOGIC ;
		pi_sw : in  STD_LOGIC_VECTOR (7 downto 0);
		po_led : out  STD_LOGIC_VECTOR (7 downto 0);
	--	po_vga : out  STD_LOGIC_VECTOR (0 downto 0);
		po_hex : out  STD_LOGIC_VECTOR (6 downto 0);
		po_hex_a : out  STD_LOGIC_VECTOR (3 downto 0)
	 );
end MainLcdFreq;

architecture Behavioral of MainLcdFreq is
	signal vv : STD_LOGIC_VECTOR (15 downto 0)  := (others => '0');
	signal hv : STD_LOGIC_VECTOR (3 downto 0);
	
component dispselan
PORT (
				clk : in  STD_LOGIC;
				iv : in  STD_LOGIC_VECTOR (15 downto 0);	
				swcommand : in STD_LOGIC_VECTOR (7 downto 0);
				an : out  STD_LOGIC_VECTOR (3 downto 0);
				ov :out  STD_LOGIC_VECTOR (3 downto 0)
);
end component;

component disphalfw
PORT (
			v : in  STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           seg : out  STD_LOGIC_VECTOR (6 downto 0)
);
end component;	

begin
	process(pi_sw) begin
			vv (7 downto 0) <= pi_sw;
			vv (15 downto 8) <= pi_sw;
	end process;
	uelan : dispselan 
		port map (
			clk => pi_clk,
			iv => vv,
		   an => po_hex_a,
			swcommand => pi_sw,
			ov => hv
			);
	-- O_HEX_A <= "0000";
			
	uhalfw : disphalfw 
		port map (
		   v => hv,
			-- v => vv (3 downto 0),
			seg => po_hex
			);	

	po_led <= vv (7 downto 0);
			

end Behavioral;

