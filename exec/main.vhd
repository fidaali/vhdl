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
	
	signal sw6 : std_logic := '0';
	signal sw7 : std_logic := '0';
	
	signal osw6 : std_logic := '0';
	signal osw7 : std_logic := '0';	
	
	signal clock : unsigned (31 downto 0) := "00000000000000000000000000000000";

begin


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
	process (I_CLK,sw6,sw7,osw6,osw7) begin
	
	if rising_edge(I_CLK) then

	end if;
	end process;
	
	process (I_CLK,clock) begin
		if rising_edge(I_CLK) then
			clock<=clock+1;
		end if;
		
		if(clock=320000000) then clock<="00000000000000000000000000000000"; end if;
	end process;
	
	process (clock,sw6,sw7,osw6,osw7,I_CLK) begin
		if clock(16)='1' and rising_edge(I_CLK) then	
		
			if sw7 ='1' and osw7 = '0' then
				prog<= prog+1;	
			end if;
			if sw6 = '1' and osw6 = '0' then
				prog<= prog-1;	
			end if;				
		
			osw6<=sw6;
			osw7<=sw7;
		end if;
			
		if clock(16)='0' and rising_edge(I_CLK) then
	
		
			sw6<= I_SW(6);
			sw7<= I_SW(7);			
		end if;
	end process;
	
	process(I_CLK,I_SW, prog, po_01_hex,po_02_hex) begin
		if rising_edge (I_CLK) then
			case (prog) is
				when "00000001" => O_HEX <= po_01_hex;

				when "00000010" => O_HEX <= po_02_hex;

	 
				when others=> O_HEX <= "11111111111";
			end case;
			O_LED <= std_logic_vector (prog);
		end if;
	end process;
	
end Behavioral;

