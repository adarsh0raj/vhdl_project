library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 

library std;
use std.standard.all;

entity RegisterFile is 

	port( add1, add2, add3 : in std_logic_vector(2 downto 0);
			data3, pc: in std_logic_vector(15 downto 0);
			clock, writ, writ_pc, rst: in std_logic ; 
			data1, data2: out std_logic_vector(15 downto 0));
end entity;

architecture rf of RegisterFile is 
 
type regFile is array(0 to 7) of std_logic_vector(15 downto 0);
signal registers: regFile;

begin 

process (clock)
begin 
	if((clock'event and clock = '0')) then
	
		if (rst = '1') then
			for i in 0 to 7 loop
				registers(i) <= "0000000000000000";
			end loop;
			
		else
             	if (writ = '1') then
					
						if ((not (add3 = "111")) and writ_pc = '1') then
							
							registers(to_integer(unsigned(add3))) <= data3;
							registers(7) <= pc;
							
							
						elsif (add3 = "111" and writ_pc = '1') then
							registers(7) <= pc;
							
						else
							registers(to_integer(unsigned(add3))) <= data3;
							
						end if;
						
		   	end if;
				
		end if;
		
	end if;
end process;

process (add1, add2)

begin
	data1 <= registers(to_integer(unsigned(add1)));
	data2 <= registers(to_integer(unsigned(add2)));
end process;
		  
end rf;