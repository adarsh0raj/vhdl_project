library ieee, std;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use IEEE.numeric_std.all;

entity Testbench is
end entity;

architecture arc of Testbench is
 
	component IITB_Proc is
	port ( clk, rst : in std_logic;
			output : out std_logic_vector(3 downto 0)
			);
	end component;
	
	signal clock, reset : std_logic;
	signal output : std_logic_vector(3 downto 0);

begin

	dut_instance : IITB_Proc
		port map(clk => clock, rst => reset, output => output);
		
	process
	begin
	
		clock <= '1';
		reset <= '1';
		wait for 10 ns;
		clock <= '0';
		wait for 10 ns;
	
		for i in 0 to 50 loop
			
			reset <= '0';
			clock <= '1';
			wait for 10 ns;
				
			clock <= '0';
			wait for 10 ns;
				
		end loop;
		
	wait;
	end process;
	
end architecture;