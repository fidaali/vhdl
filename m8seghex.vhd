----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:15:52 02/17/2016 
-- Design Name: 
-- Module Name:    disphalfw - Behavioral 
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

entity disphalfw is
    Port ( v : in  STD_LOGIC_VECTOR (3 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0));
end disphalfw;

architecture Behavioral of disphalfw is


begin

process(v)
begin
	case v  is
		when "0000" =>
			seg(0) <= '0';
			seg(1) <= '0';
			seg(2) <= '0';
			seg(3) <= '0';
			seg(4) <= '0';
			seg(5) <= '0';
			seg(6) <= '1';
		when "0001" =>
			seg(0) <= '1';
			seg(1) <= '0';
			seg(2) <= '0';
			seg(3) <= '1';
			seg(4) <= '1';
			seg(5) <= '1';
			seg(6) <= '1';	
		when "0010" =>
			seg(0) <= '0';
			seg(1) <= '0';
			seg(2) <= '1';
			seg(3) <= '0';
			seg(4) <= '0';
			seg(5) <= '1';
			seg(6) <= '0';
		when "0011" =>
			seg(0) <= '0';
			seg(1) <= '0';
			seg(2) <= '0';
			seg(3) <= '0';
			seg(4) <= '1';
			seg(5) <= '1';
			seg(6) <= '0';
		when "0100" =>
			seg(0) <= '1';
			seg(1) <= '0';
			seg(2) <= '0';
			seg(3) <= '1';
			seg(4) <= '1';
			seg(5) <= '0';
			seg(6) <= '0';		
		when "0101" =>
			seg(0) <= '0';
			seg(1) <= '1';
			seg(2) <= '0';
			seg(3) <= '0';
			seg(4) <= '1';
			seg(5) <= '0';
			seg(6) <= '0';		
		when "0110" =>
			seg(0) <= '0';
			seg(1) <= '1';
			seg(2) <= '0';
			seg(3) <= '0';
			seg(4) <= '0';
			seg(5) <= '0';
			seg(6) <= '0';		
		when "0111" =>
			seg(0) <= '0';
			seg(1) <= '0';
			seg(2) <= '0';
			seg(3) <= '1';
			seg(4) <= '1';
			seg(5) <= '1';
			seg(6) <= '1';		
		when "1000" =>
			seg(0) <= '0';
			seg(1) <= '0';
			seg(2) <= '0';
			seg(3) <= '0';
			seg(4) <= '0';
			seg(5) <= '0';
			seg(6) <= '0';		
		when "1001" =>
			seg(0) <= '0';
			seg(1) <= '0';
			seg(2) <= '0';
			seg(3) <= '0';
			seg(4) <= '1';
			seg(5) <= '0';
			seg(6) <= '0';		
		when "1010" =>
			seg(0) <= '0';
			seg(1) <= '0';
			seg(2) <= '0';
			seg(3) <= '1';
			seg(4) <= '0';
			seg(5) <= '0';
			seg(6) <= '0';
		when "1011" =>
			seg(0) <= '1';
			seg(1) <= '1';
			seg(2) <= '0';
			seg(3) <= '0';
			seg(4) <= '0';
			seg(5) <= '0';
			seg(6) <= '0';
		when "1100" =>
			seg(0) <= '0';
			seg(1) <= '1';
			seg(2) <= '1';
			seg(3) <= '0';
			seg(4) <= '0';
			seg(5) <= '0';
			seg(6) <= '1';
		when "1101" =>
			seg(0) <= '1';
			seg(1) <= '0';
			seg(2) <= '0';
			seg(3) <= '0';
			seg(4) <= '0';
			seg(5) <= '1';
			seg(6) <= '0';
		when "1110" =>
			seg(0) <= '0';
			seg(1) <= '1';
			seg(2) <= '1';
			seg(3) <= '0';
			seg(4) <= '0';
			seg(5) <= '0';
			seg(6) <= '0';
		when "1111" =>
			seg(0) <= '0';
			seg(1) <= '1';
			seg(2) <= '1';
			seg(3) <= '1';
			seg(4) <= '0';
			seg(5) <= '0';
			seg(6) <= '0';			
		when others =>
			seg(0) <= '1';
			seg(1) <= '1';
			seg(2) <= '1';
			seg(3) <= '1';
			seg(4) <= '1';
			seg(5) <= '1';
			seg(6) <= '1';			
	end case;
end process;

end Behavioral;

