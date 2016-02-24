----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:05 02/17/2016 
-- Design Name: 
-- Module Name:    vgasign - Behavioral 
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

entity vgasign is
    Port ( clk32mhz : in  STD_LOGIC;
           hpix : out STD_LOGIC_VECTOR (10 downto 0);
			  vpix : out STD_LOGIC_VECTOR (10 downto 0);
			  pixon : out STD_LOGIC;
			  h_sync : out STD_LOGIC;
			  v_sync : out STD_LOGIC
			  
			  );
end vgasign;

architecture Behavioral of vgasign is
	signal divt : unsigned (8 downto 0) := (others => '0');
	signal h : unsigned (10 downto 0) := (others => '0');
	signal v : unsigned (10 downto 0) := (others => '0');
	signal pixclk : STD_LOGIC;
	signal endh : STD_LOGIC;
	signal endv : STD_LOGIC;

begin
	calcpixclk : process ( clk32mhz)
		begin
			if rising_edge(clk32mhz) then
				divt <= divt+1;
			end if;
			
			if(divt = "011111111" ) then
				pixclk<='1';
			else
				pixclk<='0';
			end if;
		end process;
		
	calch : process (pixclk)
		begin 
			if rising_edge(pixclk) then
				if h=799 then
					h <= "00000000000";
					endh <= '1';
				else
					h <= h+1;
					endh <= '0';
				end if;
			end if;
		end process;
	calcv : process (endh)
		begin
			if rising_edge(endh) then
				if v=524 then
					v <= "00000000000";
					endv <= '1';
				else
					v <= v+1;
					endv <='0';
				end if;
			end if;
		end process;
		
	calcsync : process (h,v)
		begin
			if (v=490 or v=491) then
				v_sync <= '0';
			else
				v_sync <= '1';
			end if;
			
			if(h>= 656 and h < 752) then
				h_sync <= '0';
			else
				h_sync <= '1';
			end if;
			
			if(h < 640 and v <480) then
				pixon <= '1';
			else
				pixon <= '0';
			end if;
		end process;

	hpix <= std_logic_vector (h);
	vpix <= std_logic_vector (v);

end Behavioral;

