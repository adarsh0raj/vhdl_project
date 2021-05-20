-- Sub Entity Nand gate for 16 bit inputs

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration
entity Nand_16bit is
	port(A,B: in std_logic_vector(15 downto 0);
		nandAB: out std_logic_vector(15 downto 0));
end entity;

architecture nandres of Nand_16bit is
begin
	nandAB <= A nand B;           -- nand operation
	
end nandres;