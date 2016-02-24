----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:15 02/17/2016 
-- Design Name: 
-- Module Name:    m8seg_refresh_hex - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: choose one of the 4 display, depending on clock and refresh rate. 
-- each display 4 bits of the 16 bits input as an Hex value 
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
use IEEE.numeric_std.ALL;

entity m8seg_refresh_hex is
    Port ( 
				pi_clk : in  STD_LOGIC;
				pi_value : in  unsigned (15 downto 0);	
				pi_refresh : in unsigned (2 downto 0);	
				po_q_num : out  STD_LOGIC_VECTOR (3 downto 0);
				po_hex_val :out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end m8seg_refresh_hex;

architecture Behavioral of m8seg_refresh_hex is
	signal s : unsigned (1 downto 0)  := (others => '0');
	signal cc : unsigned (31 downto 0)  := (others => '0');

begin


	process (clk, swcommand)
	begin
		if rising_edge(clk) then
			cc <= cc+1;
			if(cc(31)='1') then cc <= "00000000000000000000000000000000"; end if;
			
			case swcommand is
				when "000" => s <= cc (27 downto 26);
				when "100" => s <= cc (25 downto 24);
				when "010" => s <= cc (23 downto 22);
				when "110" => s <= cc (21 downto 20);
				
				when "001" => s <= cc (19 downto 18);
				when "101" => s <= cc (17 downto 16);
				when "011" => s <= cc (15 downto 14);
				when "111" => s <= cc (13 downto 12);
				when others => s <= cc (15 downto 14);
			end case;
		end if;
	end process;
	
	process (iv,s)
	begin	
		case s is
			when "00" => 
				po_q_num<= "1110";
				po_hex_val<= iv (3 downto 0);
			when "01" => 
				po_q_num<= "1101";
				po_hex_val <= iv (7 downto 4);
			when "10" => 
				po_q_num<= "1011";
				po_hex_val <= iv (11 downto 8);
			when "11" => 
				po_q_num<= "0111";
				po_hex_val <= iv (15 downto 12);		
			when others => 
				po_q_num<="1111";
				po_hex_val <= "0000";
		end case;

	end process;
	
	

end Behavioral;

