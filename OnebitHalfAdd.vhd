-- importing libraries
library work;
use work.all;

library IEEE;
use IEEE.std_logic_1164.all;

-- defining entity
entity OnebitHalfAdd is
	port( a, b : in std_logic;
			sum, carry: out std_logic
			);
end entity;

--defining architecture
architecture halfadd of OnebitHalfAdd is
	-- intermediate variables
	signal ac, a1, a0: std_logic;
	
	-- component declaration
	component TwoByOneMux
		port(i : in std_logic_vector(1 downto 0);
				sel : in std_logic;
				z : out std_logic
				);
	end component;

begin 
	-- instantiating required mux and connecting them
	mux1 : TwoByOneMux
		port map (i(1) => '0', i(0) => '1', sel => b, z => a1);
	
	mux2 : TwoByOneMux
		port map (i(1) => '1', i(0) => '0', sel => b, z=> a0);
		
	mux3 : TwoByOneMux
		port map (i(1) => a1, i(0) => a0, sel => a, z=> sum);
	
	mux4 : TwoByOneMux
		port map (i(0) => '0', i(1) => '1', sel => b, z=> ac);
		
	mux5 : TwoByOneMux
		port map (i(0) => '0', i(1) => ac, sel => a, z=> carry);
		
end architecture;
		
		
		