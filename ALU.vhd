-- Sub entity Arithmetic Logic Unit

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

-- entity declaration
entity ALU is 
	port( A,B : in std_logic_vector(15 downto 0);
		optype : in std_logic ;
		result : out std_logic_vector(15 downto 0);
		outc, outz: out std_logic);
		
end entity;

-- architecture
architecture arch of ALU is
	-- signals for port mapping
	signal resA, resN: std_logic_vector(15 downto 0);
	signal carryA, carryN : std_logic;
	
	-- components for ALU
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
	-- initialising adder and nand gate
	type0: Adder_16bit port map (A, B, '0', resA, carryA);
	type1: Nand_16bit port map (A, B, resN);
	 
	process(optype, resA, resN, carryA, carryN)           -- process on input and output
	begin
		
		if(optype = '0') then                                -- output type "0" - add operation
			result <= resA;  
			outc <= carryA;                                    -- carry flag update
			if (resA = "0000000000000000") then                -- zero flag update
				outz <= '1';
			else
				outz <= '0';
			end if;
		else                                                -- output type "1" - nand operation
			result <= resN;  
			outc <= carryN;                                    -- carry flag update
			if (resN = "0000000000000000") then                -- zero flag update
				outz <= '1'; 
			else
				outz <= '0';
			end if;
		end if;
	end process;
end arch;