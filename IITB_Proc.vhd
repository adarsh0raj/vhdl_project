-- Main entity IITB Processor
-- loading libraries

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 

-- entity declaration
entity IITB_Proc is
  port (
    clk,rst, inst_flag : in std_logic;
    instruc : in std_logic_vector(15 downto 0);
	 output : out std_logic_vector(3 downto 0));
end entity;

architecture main of IITB_Proc is

-- alu component
component ALU is
	port( A,B : in std_logic_vector(15 downto 0);
		optype : in std_logic ;
		result : out std_logic_vector(15 downto 0);
		outc, outz: out std_logic);
end component;

-- register file component
component registerfile is
	port( add1, add2, add3 : in std_logic_vector(2 downto 0);
			data3, pc: in std_logic_vector(15 downto 0);
			clock, writ, writ_pc, rst: in std_logic ; 
			data1, data2: out std_logic_vector(15 downto 0));
end component;

-- memory component
component memory_readwrite is
	port (address_in, data_in: in std_logic_vector(15 downto 0);
			read_sig, write_sig, clock: in std_logic;
			data_out: out std_logic_vector(15 downto 0));
end component;

-- sign extenders
component SignExtender6to16 is
	port (inp: in std_logic_vector(5 downto 0);
		ext: out std_logic_vector(15 downto 0));
end component;

component SignExtender9to16 is 
	port (inp: in std_logic_vector(8 downto 0);
		optype: in std_logic;
		ext: out std_logic_vector(15 downto 0));
end component;

-- state variable
type State is (Sinit, Sinstr, Sx, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21);
signal currstate: State;

-- signals for all other inputs and outputs for components
signal optype: std_logic_vector(3 downto 0);
signal rAdd1, rAdd2, rAdd3: std_logic_vector(2 downto 0);
signal address, mem_add, mdatain, mdataout: std_logic_vector(15 downto 0);
signal t1, t2, t3, instruction: std_logic_vector(15 downto 0);
signal a_alu, b_alu, res_alu : std_logic_vector(15 downto 0);
signal carryout, zeroout : std_logic;
signal rData1, rData2, rData3, rDataPC : std_logic_vector(15 downto 0);
signal ext6in : std_logic_vector(5 downto 0);
signal ext9in : std_logic_vector(8 downto 0);
signal ext6out, ext9out : std_logic_vector(15 downto 0);
signal memread, memwrite, rPCwrite, rfilerst, rfwrite : std_logic;
signal carrymain, zeromain : std_logic;
signal alutype, ext9type: std_logic;


begin                  -- architecture begin

-- components port map
ALU0 : ALU
	port map(a_alu, b_alu, alutype, res_alu, carryout, zeroout);
regfile : registerfile
	port map(rAdd1, rAdd2, rAdd3, rData3, rDataPC, clk, rfwrite, rPCwrite, rfilerst, rData1, rData2);
Memory0: memory_readwrite
	port map(mem_add, mdatain, memread,  memwrite, clk, mdataout);

	
process(clk, currstate)                    -- process on clock and state
	
	-- state variables
	variable nxtstate : State;
	variable z, c : std_logic;
	variable opr : std_logic_vector(3 downto 0);
	variable x1, x2, x3, instr, nxtaddr : std_logic_vector(15 downto 0);
	
	begin                       -- intial assignments of state variables
			
		nxtstate := currstate;
		c:=carrymain; z:= zeromain;
		x1 := t1; x2 := t2; x3:=t3;
		opr := optype;
		nxtaddr := address;
	
	case currstate is                         -- cases on all states
		when Sinit =>
			rfilerst <= '1';
			memread <= '0';
			memwrite <= '0';
			rfwrite <= '0';
			c := '0'; z := '0';
			x1 := "0000000000000000"; x2 := "0000000000000000"; x3 := "0000000000000000";
			nxtaddr := "0000000000000000";
			
			nxtstate := S0;
			
		when Sinstr =>     --write instruction into memory
			memwrite <= '1';
			rfilerst <= '0';
			memread <= '0';	
			mem_add <= address;
			mdatain <= instruc;   --writing instruction
			
			nxtstate := Sx;   --to increment the address for inserting the instruction		
		
		when Sx =>
			memwrite <= '0';
			rfilerst <= '0';
			memread <= '0';
			a_alu <= address;
			b_alu <= "0000000000000001";
			alutype <= '0';
			nxtaddr := res_alu;
			nxtstate := S0;
			
		when S0 =>
			rfilerst <= '0';
			memread <= '1';
			memwrite <= '0';
			rfwrite <= '0';
			x1 := "0000000000000000"; x2 := "0000000000000000"; x3 := "0000000000000000";
			nxtaddr := address;
			instr := mdataout;
			opr := instr(15 downto 12);
			
			case (opr) is
			   	when "0000" =>
				  nxtstate := S1;
				when "0001" =>
				  nxtstate := S2;
				when "0010" =>
				  nxtstate := S1;
				when "0011" =>
				  nxtstate := S3;
				when "0100" =>
				  nxtstate := S5;
				when "0101" =>
				  nxtstate := S5;
				when "0110" =>
				  nxtstate := S10;
				when "1001" =>
				  nxtstate := S9;
				when "1100" =>
				  nxtstate := S1;
				when "1000" =>
				  nxtstate := S9;
				when "0111" =>
				  nxtstate := S10;
			   when others => null;
			end case;
			
		
		
		when S1 =>
			rfilerst <= '0';
			memread <= '0';
			memwrite <= '0';
			rfwrite <= '0';
			
			rAdd1 <= instr(11 downto 9);
			rAdd2 <= instr(8 downto 6);
			x1 := rData1;
			x2 := rData2;
			nxtstate := S4;
		
		when S2 => 
			memwrite <= '0';
			memread <= '0';
			rfwrite <= '0';
			rAdd1 <= instr(11 downto 9);
			x1 := rData1;
			ext6in <= instr(5 downto 0);
			x2 := ext6out;
			nxtstate := S4;
		
		when S3 =>
			memwrite <= '0';
			memread <= '0';
			rfwrite <= '0';
			ext9in <= instr(8 downto 0);
			ext9type <= '1';
			x1 := ext9out;
			nxtstate := S20;
			
		when S4 =>
			rfilerst <= '0';
			memread <= '0';
			memwrite <= '0';
			rfwrite <= '0';
			a_alu <= x1; b_alu <= x2;
			if(opr = "0000" or opr = "0001" or opr = "0100") then
				alutype <= '0';
			else
				alutype <= '1';
			end if;
			x3 := res_alu;
			
			case (opr) is
				when "0000" =>
					nxtstate :=S6;
				when "0001" =>
					nxtstate :=S8;
				when "0010" =>
					nxtstate :=S6;
				when "0100" =>
					nxtstate :=S17;
				when "0101" =>
					nxtstate :=S11;
				when "1100" =>
					if(x1=x2) then
						nxtstate :=S7;
					else
						nxtstate :=Sx;
					end if;
				when others => null;
			end case;
		
		when S5 => 
			memwrite <= '0';
			memread <= '0';
			rfwrite <= '0';
			rAdd1 <= instr(8 downto 6);
			ext6in <= instr(5 downto 0);
			x1 := rData1;
			x2 := ext6out;
			nxtstate := S4;
		
		when S6 =>
			rfilerst <= '0';
			memread <= '0';
			memwrite <= '0';
			rfwrite <= '1';
			if(instr(1 downto 0) = "00" or (instr(1 downto 0) = "10" and c = '1') or (instr(1 downto 0) = "01" and z = '1')) then 
				rData3 <= x3;
				rAdd3 <= instr(5 downto 3);
				if(opr = "0000") then
					c:= carryout;
				end if;
				
				z := zeroout;
			end if;
			nxtstate := Sx;
			
		when S7 =>
			a_alu <= address;
			ext6in <= instr(5 downto 0);
			b_alu <= ext6out;
			alutype <= '0';
			nxtaddr := res_alu;
			nxtstate := S0;
			
			
		when S8 =>
			memwrite <= '0';
			memread <= '0';
			rfwrite <= '1';
			
			c := carryout;
			z := zeroout;

			rData3 <= x3;
			rAdd3 <= instr(8 downto 6);
			nxtstate := Sx;
		
		
			
		when S9 =>
			memwrite <= '0';
			memread <= '0';
			rfwrite <= '1';
			rData3 <= address;
			rAdd3 <= instr(11 downto 9);
			if(opr = "1001") then
				nxtstate := S18;
			else
				nxtstate := S19;
			end if;
			
		
		when S10 =>
			memwrite <= '0';
			memread <= '0';
			rfwrite <= '0';
			rAdd1 <= instr(11 downto 9);
			x1 := rData1;
			if(opr = "0111") then
				nxtstate := S16;
			else 
				nxtstate := S12;
			end if;	
		
			
		when S11 =>
			memwrite <= '1';
			memread <= '0';
			rfwrite <= '0';
			rAdd1 <= instr(11 downto 9);
			x2 := rData1;
			mem_add <= x3;
			mdatain <= x2;
			nxtstate := Sx;
			
		
		when S12 =>
			memwrite <= '0';
			memread <= '1';
			rfwrite <= '0';
			mem_add <= x1;
			x3 := mdataout;
			nxtstate := S14;
		
		when S13 =>
			a_alu <= x1;
			b_alu <= "0000000000000001";
			alutype <= '1';
			x1 := res_alu;
			if(unsigned(x2)<8) then
				if(opr = "0111") then
					nxtstate := S16;
				else 
					nxtstate := S12;
				end if;
			else
				nxtstate := Sx;
			end if;
		
		when S14 =>
			rfwrite <= '1';
			rData3 <= x3;
			rAdd3 <= x2(2 downto 0);
			a_alu <= x2;
			b_alu <= "0000000000000001";
			alutype <= '0';
			x2 := res_alu;
			nxtstate := S13;
			

		when S15 =>
			a_alu <= x2;
			b_alu <= "0000000000000001";
			alutype <= '0';
			x2 := res_alu;
			nxtstate := S13;
		
		
		when S16 =>
			memwrite <= '1';
			memread <= '0';
			rfwrite <= '0';
			rAdd2 <= x2(2 downto 0);
			x3 := rData2;
			mem_add <= x1;
			mdatain <= x3;
			
			nxtstate := S15;
			

			
		when S17 =>
			memread <= '1';
			rfwrite <= '1';
			
			c := carryout;
			z := zeroout;
			
			mem_add <= x3;
			x1 := mdataout;
			rData3 <= x1;
			rAdd3 <= instr(11 downto 9);
			nxtstate := Sx;
		
		when S18 =>
			memwrite <= '0';
			memread <= '0';
			rfwrite <= '0';
			rAdd1 <= instr(8 downto 6);
			nxtaddr := rData1;
			nxtstate := S0;
			
		when S19 =>
			memwrite <= '0';
			memread <= '0';
			rfwrite <= '0';
			a_alu <= nxtaddr;
			ext9in <= instr(8 downto 0);
			ext9type <= '0';
			b_alu <= ext9out;
			alutype <= '0';
			nxtaddr := res_alu;
			nxtstate := S0;
			
		when S20 =>
			memwrite <= '0';
			memread <= '0';
			rfwrite <= '1';
			rData3 <= x1; 
			rAdd3 <= instr(11 downto 9);
			nxtstate := Sx;
		
		when others => null;
	
	end case;                           -- cases on state end
	
	if(falling_edge(clk)) then                 -- if falling edge and reset-> 0, update state
		if(rst = '0') then
			
			t1 <= x1; t2 <= x2; t3 <= x3;
			carrymain <= c; zeromain <= z;
			instruction <= instr;
			optype <= opr;
			address <= nxtaddr;
			currstate <= nxtstate;
			
			if(inst_flag = '1') then --go to Sinstr if instruction is being given
				currstate <= Sinstr;
			end if;
			
		else 
			currstate <= Sinit;                    -- if reset is 1, then go to initial state
		end if;
	end if;
	end process;                               -- end process
end architecture;
