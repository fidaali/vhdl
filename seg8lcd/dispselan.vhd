----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:15 02/17/2016 
-- Design Name: 
-- Module Name:    dispselan - Behavioral 
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dispselan is
    Port ( 
				clk : in  STD_LOGIC;
				iv : in  STD_LOGIC_VECTOR (15 downto 0);	
				swcommand : in STD_LOGIC_VECTOR (7 downto 0);	
				an : out  STD_LOGIC_VECTOR (3 downto 0);
				ov :out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end dispselan;

architecture Behavioral of dispselan is
	signal s : unsigned (1 downto 0)  := (others => '0');
	signal cc : unsigned (31 downto 0)  := (others => '0');

begin


	process (clk, swcommand)
	begin
		if rising_edge(clk) then
			cc <= cc+1;
			if(cc(31)='1') then cc <= "00000000000000000000000000000000"; end if;
			
			case swcommand is
				when "00000000" => s <= cc (27 downto 26);
				when "10000000" => s <= cc (25 downto 24);
				when "01000000" => s <= cc (23 downto 22);
				when "11000000" => s <= cc (21 downto 20);
				
				when "00100000" => s <= cc (19 downto 18);
				when "10100000" => s <= cc (17 downto 16);
				when "01100000" => s <= cc (15 downto 14);
				when "11100000" => s <= cc (13 downto 12);
				when others => s <= cc (15 downto 14);
			end case;
		end if;
	end process;
	
	process (iv,s)
	begin	
		case s is
			when "00" => 
				an <= "1110";
				ov <= iv (3 downto 0);
			when "01" => 
				an <= "1101";
				ov <= iv (7 downto 4);
			when "10" => 
				an <= "1011";
				ov <= iv (11 downto 8);
			when "11" => 
				an <= "0111";
				ov <= iv (15 downto 12);		
			when others => 
				an <="1111";
				ov <= "0000";
		end case;

	end process;
	
	

end Behavioral;

