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

entity main is
    Port (
		I_CLK : in STD_LOGIC ;
		I_SW : in  STD_LOGIC_VECTOR (7 downto 0);
		O_LED : out  STD_LOGIC_VECTOR (7 downto 0);
	--	O_VGA : out  STD_LOGIC_VECTOR (0 downto 0);
		O_HEX : out  STD_LOGIC_VECTOR (10 downto 0)
	);
end main;




architecture Behavioral of main is
	signal prog : unsigned (7 downto 0)  := "00000000"; 
	
component MainLcdTest
    Port ( 
	 	pi_clk : in STD_LOGIC ;
		pi_sw : in  STD_LOGIC_VECTOR (7 downto 0);
		po_hex : out  STD_LOGIC_VECTOR (10 downto 0) -- 6 bit segments then 4 bit quadrant
	 );
end component;	

component MainDispVgaRate
    Port ( 
	 	pi_clk : in STD_LOGIC ;
		pi_sw : in  STD_LOGIC_VECTOR (7 downto 0);
		po_hex : out  STD_LOGIC_VECTOR (10 downto 0) -- 6 bit segments then 4 bit quadrant
	 );
end component;

	signal po_01_hex :  STD_LOGIC_VECTOR (10 downto 0);
	signal po_02_hex :  STD_LOGIC_VECTOR (10 downto 0);
	
	signal sw6 : std_logic;
	signal sw7 : std_logic;
	
	signal osw6 : std_logic;
	signal osw7 : std_logic;	

begin
	sw6<= I_SW(6);
	sw7<= I_SW(7);

			call1 : MainLcdTest 
			port map (
				pi_clk => I_CLK,
				pi_sw => I_SW,
				po_hex => po_01_hex
			);

			call2 : MainDispVgaRate
			port map (
				pi_clk => I_CLK,
				pi_sw => I_SW,
				po_hex => po_02_hex
			);
	process (sw6,sw7,osw6,osw7) begin
		if sw7 ='1' and osw7 = '0' then
			prog<= prog+1;	
			osw7<='1';
		end if;
		if sw7 = '1' and osw6 = '0' then
			prog<= prog-1;	
			osw6<='1';
		end if;
		
		osw6<=sw6;
		osw7<=sw7;

	end process;
	
	process(I_CLK,I_SW, prog, po_01_hex,po_02_hex) begin
		case (prog) is
			when "00000001" => O_HEX <= po_01_hex;

			when "00000010" => O_HEX <= po_02_hex;

 
			when others=> O_HEX <= "11111111111";
		end case;
	end process;
	O_LED <= std_logic_vector (prog);
end Behavioral;

