library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity Nand_16bit is
	port(A,B: in std_logic_vector(15 downto 0);
		nandAB: out std_logic_vector(15 downto 0));
end entity;

architecture nandres of Nand_16bit is
begin
	nandAB <= A nand B;
	
end nandres;