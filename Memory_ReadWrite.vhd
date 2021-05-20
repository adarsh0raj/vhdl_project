-- Sub Entity Memory Read Write

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all; 
library ieee;
use ieee.numeric_std.all;
library std;
use std.standard.all;

-- entity declaration
entity Memory_ReadWrite is 

	port (address_in, data_in: in std_logic_vector(15 downto 0);
			read_sig, write_sig, clock: in std_logic;
			data_out: out std_logic_vector(15 downto 0));
			
end entity; 

-- architecture
architecture mem of Memory_ReadWrite is 

	-- buffer for memory
	type regArr is array(65535 downto 0) of std_logic_vector(15 downto 0);
	
	signal Memory_Reg: regArr;                                     -- variable for buffer
		
	begin 
	
	  process(address_in, data_in, write_sig, read_sig, Memory_Reg, clock)       -- process in inputs and clock
	  
	  begin
	  
			if (write_sig = '1' and falling_edge(clock)) then                  -- write signal == 1, then write data to provided address
				Memory_Reg(to_integer(unsigned(address_in))) <= data_in;
			end if;
			
			if (read_sig = '0') then                                           -- read signal == 0, read a fixed data
				data_out <= "1111111111111111";
				 	 
			else
				data_out <= Memory_Reg(to_integer(unsigned(address_in)));        -- else, read data from provided address
				 
			end if;

			
	  end process;
	
end mem;