library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity SignExtender6to16 is
port (inp: in std_logic_vector(5 downto 0);
		ext: out std_logic_vector(15 downto 0));
end entity;
architecture extend6 of SignExtender6to16 is

begin
      ext(5 downto 0) <= inp(5 downto 0); 
		ext(15) <= inp(5);
		ext(14) <= inp(5); 
		ext(13) <= inp(5);
		ext(12) <= inp(5); 
		ext(11) <= inp(5);
		ext(10) <= inp(5);
		ext(9) <= inp(5);
		ext(8) <= inp(5);
		ext(7) <= inp(5);
		ext(6) <= inp(5);
end extend6;