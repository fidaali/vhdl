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

entity ModVga3Neigh is
    Port ( 
    	pi_clk : in STD_LOGIC;
		pi_sw : in  STD_LOGIC_VECTOR (7 downto 0);
		pi_hsync : in STD_LOGIC;
		pi_vsync : in STD_LOGIC;
		pi_on : in STD_LOGIC;
		pi_pixh : unsigned (10 downto 0);
		po_vga : out  STD_LOGIC_VECTOR (7 downto 0)
	 );
end ModVga3Neigh;

architecture Behavioral of ModVga3Neigh is

signal hsync : std_logic := '0';
signal vsync : std_logic := '0';
signal outp : unsigned (7 downto 0);

begin
	process (pi_clk, pi_vsync, pi_hsync) begin
	if rising_edge(pi_clk) then
		if(pi_vsync = '0') then
			vsync <= '1';
		else
			if(vsync = '1' ) then
				outp <= "00000000";
				vsync<='0';
			else

			end if;

			if(pi_hsync = '0') then
				hsync <= '1';
			else
				if(pi_on = '1' and hsync='1' ) then
					outp <= outp +1;
					hsync<='0';
					
				end if;

			end if;		

		end if;

	end if;
	end process;

	po_vga <= std_logic_vector (outp);
		

end Behavioral;

