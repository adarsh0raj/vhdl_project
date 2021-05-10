library ieee;
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

library std;
use std.standard.all;

entity Reg_16bit is
	port ( inp : in  std_logic_vector(15 downto 0);
			 en: in std_logic;
          clock: in  std_logic;
			 outp : out std_logic_vector(15 downto 0));
end Reg_16bit;

architecture rg of Reg_16bit is

begin  

	process(clock,en,inp)
	
	begin 
	  if(clock'event and clock = '1') then
	  
		 if en = '1' then
			outp <= inp;
		 end if;
		 
	  end if;
	  
	end process;
	
end rg;