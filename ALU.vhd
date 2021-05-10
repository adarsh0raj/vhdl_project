library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity ALU is 
	port( A,B : in std_logic_vector(15 downto 0);
		optype : in std_logic ;
		result : out std_logic_vector(15 downto 0);
		outc, outz: out std_logic);
		
end entity;

architecture arch of ALU is
	signal resA, resN: std_logic_vector(15 downto 0);
	signal carryA, carryN : std_logic;
	
	component Adder_16bit is
		port (A, B : in std_logic_vector(15 downto 0);
		cin : in std_logic;
		sum : out std_logic_vector(15 downto 0);
		cout : out std_logic);
	end component;
	component Nand_16bit is
		port(A,B: in std_logic_vector(15 downto 0);
				nandAB: out std_logic_vector(15 downto 0));
	end component;
	
begin
	type0: Adder_16bit port map (A, B, '0', resA, carryA);
	type1: Nand_16bit port map (A, B, resN);
	
	
	
	process(optype, resA, resN, carryA, carryN)
	begin
		
		if(optype = '0') then
			result <= resA;
			outc <= carryA;
			if (resA = "0000000000000000") then
				outz <= '1';
			else
				outz <= '0';
			end if;
		else
			result <= resN;
			outc <= carryN;
			if (resN = "0000000000000000") then
				outz <= '1';
			else
				outz <= '0';
			end if;
		end if;
	end process;
end arch;