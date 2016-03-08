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
signal ligne : unsigned (7 downto 0);


signal model : std_logic_vector (639 downto 0) := (others => '0');
signal curr : std_logic_vector (639 downto 0) := (others => '0');
signal n : std_logic_vector (639 downto 0) := (others => '0');



begin
	process (pi_clk, pi_vsync, pi_hsync) begin
	if rising_edge(pi_clk) then
		if(pi_vsync = '0') then
			vsync <= '1';
		else
			if(vsync = '1' ) then
				model<= model xor model;
				model(320 downto 320) <= "1";
				model(400 downto 400) <= "1";
				model(100 downto 100) <= "1";
			
				outp <= "00000000";
				ligne <= "00000000";
				vsync<='0';
				curr<=model;
			else

			end if;

			if(pi_hsync = '0') then
				hsync <= '1';
				n<=curr;
			else
				if(pi_on = '1') then
					if( hsync='1' ) then
						
						ligne <= ligne +1;
						
						
						curr<= 
							(( n (638 downto 0) & "0" )
							or
								n)
							xor
							( "0" & n (639 downto 1) )
							;	

						curr (7 downto 0) <= std_logic_vector (ligne);
						
						hsync<='0';
								
					end if;

					if(curr (to_integer( pi_pixh )) = '1') then
						outp <= ligne;-- "11100111";
					else
						outp <= "00000000";
					end if;					
					
				end if;

			end if;		

		end if;

	end if;
	end process;

	po_vga <= std_logic_vector (outp);
		

end Behavioral;

