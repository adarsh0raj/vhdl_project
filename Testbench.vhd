library ieee, std;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use IEEE.numeric_std.all;

entity Testbench is
end entity;

architecture arc of Testbench is
 
	component IITB_Proc is
	port (
    clk,rst, inst_flag : in std_logic;
    instruc : in std_logic_vector(15 downto 0);
	 output : out std_logic_vector(3 downto 0));
	end component;
	
	signal clock, reset : std_logic;
	signal output : std_logic_vector(3 downto 0);
	signal instr : std_logic;
	signal instruction : std_logic_vector(15 downto 0);

begin

	dut_instance : IITB_Proc
		port map(clk => clock, rst => reset, inst_flag => instr, instruc => instruction, output => output);
		
	process
	begin
	
		clock <= '1';
		reset <= '1';
		instr <= '0';
		wait for 10 ns;
		clock <= '0';
		wait for 10 ns;
		
		
		for i in 0 to 20 loop --depends on number of instructions you want to insert. There are 15 types of instructions in total
			reset <= '0';
			clock <= '1';
			instr <= '1';
			
			--instruction <= instruction ka code add karo
--			if(i=1) then
--				instruction <= "0000000000000001";
--			else 
--				if(i=3) then
--					instruction <= "0100000000000001";
--				else
--					instruction <= "0000000000000000";
--				end if;
--			end if;

			instruction <= "0000000000001000";  --1 + 1 = 2 stored in R1
			
			wait for 10 ns;
			
			clock <= '0';
			
			wait for 10 ns;
			
			reset <= '0';   --for Sx state to happen and increment memory location
			clock <= '1';
			instr <= '0';
			
			wait for 10 ns;
			
			clock <= '0';
			wait for 10 ns;
			
		end loop;
		
		clock <= '1';
		reset <= '1';  --So that FSM goes to Sinit and PC becomes 0
		instr <= '0';
		wait for 10 ns;
		clock <= '0';
		wait for 10 ns;		
			
	
		for i in 0 to 20 loop
			
			reset <= '0';
			clock <= '1';
			instr <= '0';
			wait for 10 ns;
				
			clock <= '0';
			wait for 10 ns;
				
		end loop;
		
	wait;
	end process;
	
end architecture;
