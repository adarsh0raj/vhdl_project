--importing required libraries
library work;
use work.all;

library IEEE;
use IEEE.std_logic_1164.all;

-- declaring entity
entity OnebitFullAdd is
	port( a, b, cin: in std_logic;
			sum, carry: out std_logic
			);
end entity;

-- declaring architecture
architecture fulladd of OnebitFullAdd is
	--intermediate variables
	signal s1, c1, c2, cor: std_logic;
	
	--component declarations
	component TwoByOneMux
		port(i : in std_logic_vector(1 downto 0);
				sel : in std_logic;
				z : out std_logic
				);
	end component;
	
	component OnebitHalfAdd
		port( a, b : in std_logic;
			sum, carry: out std_logic
			);
	end component;
	
begin
	
	--instantiating half adders

	ha1 : OnebitHalfAdd
		port map(a,b,s1,c1);
	ha2 : OnebitHalfAdd
		port map(cin, s1, sum, c2);
	
	--making OR gate
	mux1 : TwoByOneMux
		port map (i(1) => '1', i(0) => '0', sel => c1, z => cor);
	mux2 : TwoByOneMux
		port map (i(1) => '1', i(0) => cor, sel => c2, z => carry);
		
end architecture;