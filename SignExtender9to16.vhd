library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity SignExtender9to16 is
port (inp: in std_logic_vector(8 downto 0);
optype: in std_logic;
ext: out std_logic_vector(15 downto 0));
end entity;
architecture extend9 of SignExtender9to16 is

begin
process(inp,optype)
begin
if(optype='1') then
      ext(15 downto 7) <= inp;
		ext(6 downto 0) <= "0000000";
else

		for x in 9 to 15 loop
			ext(x) <= inp(8);
		end loop;
      ext(8 downto 0) <= inp(8 downto 0); 
end if;
end process;
end architecture;