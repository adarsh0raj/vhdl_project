-- Sub entity Sign Extender 6 bits to 16bits

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration
entity SignExtender6to16 is
port (inp: in std_logic_vector(5 downto 0);
		ext: out std_logic_vector(15 downto 0));
end entity;
architecture extend6 of SignExtender6to16 is

begin
      ext(5 downto 0) <= inp(5 downto 0);         -- Copying 6 LSBs
		process(inp)
		begin
		for x in 6 to 15 loop               -- MSBs of output same as MSB of input using for loop
			ext(x) <= inp(5);
		end loop;
		end process;

end architecture;