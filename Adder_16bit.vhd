library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity Adder_16bit is
port (A, B : in std_logic_vector(15 downto 0);
		cin : in std_logic;
		sum : out std_logic_vector(15 downto 0);
		cout : out std_logic);
end entity;

Architecture addition of Adder_16bit is
signal c1, c2, c3 : std_logic;
component FourbitFullAdd is
	port( a,b : in std_logic_vector(3 downto 0);
			cin : in std_logic;
			sum: out std_logic_vector(3 downto 0);
			carry: out std_logic);
end component;

begin
	add00 : FourbitFullAdd
				port map(A(3 downto 0), B(3 downto 0), cin, sum(3 downto 0), c1);
	add01 : FourbitFullAdd
				port map(A(7 downto 4), B(7 downto 4), c1, sum(7 downto 4), c2);
	add10 : FourbitFullAdd
				port map(A(11 downto 8), B(11 downto 8), c2, sum(11 downto 8), c3);
	add11 : FourbitFullAdd
				port map(A(15 downto 12), B(15 downto 12), c3, sum(15 downto 12), cout);

end Architecture;