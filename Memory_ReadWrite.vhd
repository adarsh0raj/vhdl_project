library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all; 
library ieee;
use ieee.numeric_std.all;
library std;
use std.standard.all;

entity Memory_ReadWrite is 

	port (address_in, data_in: in std_logic_vector(15 downto 0);
			read_sig, write_sig, clock: in std_logic;
			data_out: out std_logic_vector(15 downto 0));
			
end entity; 

architecture mem of Memory_ReadWrite is 

	type regArr is array(65535 downto 0) of std_logic_vector(15 downto 0);
	
	signal Memory_Reg: regArr;
		
	begin 
	
	  process(address_in, data_in, write_sig, read_sig, Memory_Reg, clock)
	  
	  begin
	  
			if (write_sig = '1' and falling_edge(clock)) then
				Memory_Reg(to_integer(unsigned(address_in))) <= data_in;
			end if;
			
			if (read_sig = '0') then
				data_out <= "1111111111111111";
				 	 
			else
				data_out <= Memory_Reg(to_integer(unsigned(address_in))); 
				 
			end if;

			
	  end process;
	
end mem;