library ieee;
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

library std;
use std.standard.all;

entity Memory_ReadWrite is 

	port (address_in, data_in: in std_logic_vector(15 downto 0);
			read_sig, write_sig, clock: in std_logic;
			data_out: std_logic_vector(15 downto 0));
			
end entity; 

architecture mem of Memory_ReadWrite is 

	type regArr is array(65535 downto 0) of std_logic_vector(15 downto 0);
	
	signal Memory_Reg: regArr:=(
		0 => x"3001", 
		1 => x"60aa", 
		2 => x"0038", 
		3 => x"03fa", 
		4 => x"0079", 
		5 => x"5f9f", 
		6 => x"13fb", 
		7 => x"2038",
		8 => x"233a", 
		9 => x"2079", 
		10 => x"4f86",
		11 => x"4f9f", 
		12 => x"c9c2", 
		13 => x"abcd", 
		14 => x"8e02", 
		15 => x"1234", 
		16 => x"7caa", 
		17 => x"91c0",
		128 => x"ffff", 
		129 => x"0002", 
		130 => x"0000", 
		131 => x"0000", 
		132 => x"0001", 
		133 => x"0000",
		others => x"0000");
		
	begin 
	
	  process(address_in, data_in, write_sig, read_sig, Memory_Reg, clock)
	  
	  begin
	  
			if (read_sig = '1') then
				 data_out <= Memory_Reg(to_integer(unsigned(address_in)));
				 
			elsif (read_sig = '0') then
				 data_out <= "1111111111111111";
				 
			end if;

			if (write_sig = '1') then
			
				if(falling_edge(clock)) then
					Memory_Reg(to_integer(unsigned(address_in))) <= data_in;
				end if;
				
			end if;
	  end process;
	
end mem;