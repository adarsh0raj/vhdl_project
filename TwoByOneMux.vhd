library work;
use work.all;

library IEEE;
use IEEE.std_logic_1164.all;

--declaring entity

entity TwoByOneMux is
	-- one input vector of size 2
	-- one input for selector
	-- one output
	port(i : in std_logic_vector(1 downto 0);
		sel : in std_logic;
		z : out std_logic);
end entity;

-- declaring architecture for Two by One Mux
architecture tboarch of TwoByOneMux is
	
	-- intermediate variables used
	signal o0, o1, sneg : std_logic;
	
	-- declaring OR NOT and AND gates here
	component OrGate
		port (A,B: in std_logic; D: out std_logic);
	end component;
	
	component NotGate
		port(A : in std_logic; N: out std_logic);
	end component;
	
	component AndGate
		port(A,B: in std_logic; C: out std_logic);
	end component;

begin
		-- Instantiating and connecting the gates in correct manner
		andgate1 : AndGate
			port map ( A => i(1), B=>sel, C=>o1);
		
		notgate1 : NotGate
			port map(A=>sel, N=>sneg);
			
		andgate2 : AndGate
			port map(A=> i(0), B=>sneg, C=>o0);
		
		orgate1: OrGate
			port map(A=>o1, B=>o0, D=>z);
			
end architecture;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		