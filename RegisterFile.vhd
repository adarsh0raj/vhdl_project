-- Sub Entity Register File
-- loading libraries

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 

library std;
use std.standard.all;

-- entity declaration
entity RegisterFile is 

	port( add1, add2, add3 : in std_logic_vector(2 downto 0);
			data3, pc: in std_logic_vector(15 downto 0);
			clock, writ, writ_pc, rst: in std_logic ; 
			data1, data2: out std_logic_vector(15 downto 0));
end entity;

-- architecture
architecture rf of RegisterFile is 
 
-- reg file of size 8 and each 16 bits
type regFile is array(0 to 7) of std_logic_vector(15 downto 0);
signal registers: regFile;                 -- signal to represent reg file

begin 

process (clock)                            -- process on clock
begin 
	
	if((falling_edge(clock))) then
	
		if (rst = '1') then                      -- reset -> all value set to zero
			for i in 0 to 7 loop
				registers(i) <= "0000000000000000";
			end loop;
			
		else
		
			if (writ = '1' and writ_pc = '1') then                 -- reg update based on write and program counter write signals
				
				if ((not (add3 = "111")) ) then	
					registers(to_integer(unsigned(add3))) <= data3;	
				end if;
				registers(7) <= pc;
				
			end if;
			
			if(writ = '1' and writ_pc = '0') then
				registers(to_integer(unsigned(add3))) <= data3;	
			end if;
				
		end if;
		
	end if;
end process;

process (add1, add2)                                         -- process on address signals

begin
	data1 <= registers(to_integer(unsigned(add1)));                  -- reading data from provided addresses
	data2 <= registers(to_integer(unsigned(add2)));
end process;
		  
end rf;