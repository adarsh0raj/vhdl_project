-- Sub entities Basic Gates
-- defining all gates in 1 file for better reusability 

--AND GATE

library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

-- entity declaration
entity AndGate is
	-- two inputs and one output port (std_logics)
	port(A,B: in std_logic; C: out std_logic);
end entity AndGate;

-- defining the architecture for an and gate functionality
architecture Struct of AndGate is
begin
	--And operation
	C<= (A and B);
end Struct;


-- NOT GATE

library ieee;
use ieee.std_logic_1164.all;
-- entity declaration
entity NotGate is
	-- one input and one output port (std_logics)
	port(A: in std_logic; N: out std_logic);
end entity NotGate;

-- defining the architecture for not gate functionality
architecture Struct of NotGate is
begin
	--Negation operation
	N<= not A;
end Struct;

-- OR GATE

library ieee;
use ieee.std_logic_1164.all;
-- entity declaration
entity OrGate is
	-- two inputs and one output port (std_logics)
	port(A,B: in std_logic; D: out std_logic);
end entity OrGate;

-- defining the architecture for or gate functionality
architecture Struct of OrGate is
begin
	--Or operation
	D<= (A or B);
end Struct;
