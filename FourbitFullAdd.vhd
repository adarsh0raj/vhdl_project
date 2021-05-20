-- Sub Entity Four Bit Full Adder
-- importing required libraries

library work;
use work.all;

library IEEE;
use IEEE.std_logic_1164.all;

-- declaring entity
entity FourbitFullAdd is
	port( a,b : in std_logic_vector(3 downto 0);
			cin : in std_logic;
			sum: out std_logic_vector(3 downto 0);
			carry: out std_logic);
end entity;
--declaring architecture
architecture fbfa of FourbitFullAdd is
	--intermediate variables
	signal c1, c2, c3 : std_logic;
	--declaring One bit full adder component
	component OnebitFullAdd
		port( a, b, cin: in std_logic;
				sum, carry: out std_logic
				);
	end component;
	-- instantiating one bit full adders and connecting them logically
begin
	add0 : OnebitFullAdd
		port map(cin, a(0), b(0), sum(0), c1);
	
	add1 : OnebitFullAdd
		port map(c1, a(1), b(1), sum(1), c2);
		
	add2 : OnebitFullAdd
		port map(c2, a(2), b(2), sum(2), c3);
		
	add3 : OnebitFullAdd
		port map(c3, a(3), b(3), sum(3), carry);

end architecture;
		