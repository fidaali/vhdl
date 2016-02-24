----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:05 02/17/2016 
-- Design Name: 
-- Module Name:    - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:  simple vga timing signals for display
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

entity vga640rate is
    Port ( 
	pi_clk32mhz : in  STD_LOGIC;
        po_hpix : out STD_LOGIC_VECTOR (10 downto 0); -- current line number for display
	po_vpix : out STD_LOGIC_VECTOR (10 downto 0); -- current column number for display
	po_pixon : out STD_LOGIC; -- when 1 display is on time to choose the colors when 0 black pixel only
	po_h_sync : out STD_LOGIC; -- horizontal retrace signal :: 1 when tracing back to left 
	po_v_sync : out STD_LOGIC -- vertical retrace signal :: 1 when tracing back top 
			  
			  );
end vga640rate;

architecture Behavioral of vga640rate is
	signal divt : unsigned (8 downto 0) := (others => '0');
	signal h : unsigned (10 downto 0) := (others => '0');
	signal v : unsigned (10 downto 0) := (others => '0');
	signal pixclk : STD_LOGIC;
	signal endh : STD_LOGIC;
	signal endv : STD_LOGIC;

begin
	calcpixclk : process ( pi_clk32mhz, divt)
		begin
			if rising_edge(pi_clk32mhz) then
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
				po_v_sync <= '0';
			else
				po_v_sync <= '1';
			end if;
			
			if(h>= 656 and h < 752) then
				po_h_sync <= '0';
			else
				po_h_sync <= '1';
			end if;
			
			if(h < 640 and v <480) then
				po_pixon <= '1';
			else
				po_pixon <= '0';
			end if;
		end process;

	po_hpix <= std_logic_vector (h);
	po_vpix <= std_logic_vector (v);

end Behavioral;

