----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:00:43 04/06/2021 
-- Design Name: 
-- Module Name:    CPU5Bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL; 



entity CPU5Bit is
	port(CLK : in STD_LOGIC;
		  Instruction : in STD_LOGIC_VECTOR(15 downto 0);
		  t0Val, t1Val, t2Val, t3Val, t4Val, t5Val, loVal, hiVal : out STD_LOGIC_VECTOR(4 downto 0));
end CPU5Bit;

architecture Behavioral of CPU5Bit is

constant t0Addr : std_logic_vector(2 downto 0) := "000";
constant t1Addr : std_logic_vector(2 downto 0) := "001";
constant t2Addr : std_logic_vector(2 downto 0) := "010";
constant t3Addr : std_logic_vector(2 downto 0) := "011";
constant t4Addr : std_logic_vector(2 downto 0) := "100";
constant t5Addr : std_logic_vector(2 downto 0) := "101";
constant loAddr : std_logic_vector(2 downto 0) := "110";
constant hiAddr : std_logic_vector(2 downto 0) := "111";

shared variable Opcode : std_logic_vector(3 downto 0);
shared variable RR1 : std_logic_vector(2 downto 0);
shared variable RR2 : std_logic_vector(2 downto 0);
shared variable RW : std_logic_vector(2 downto 0);
shared variable shamt : std_logic_vector(2 downto 0);

shared variable t0, t1, t2, t3, t4, t5 : std_logic_vector (4 downto 0) := (others => '0');
shared variable hi : std_logic_vector (4 downto 0) := (others => '0');
shared variable lo : std_logic_vector (4 downto 0) := (others => '0');

procedure write_register(reg: in std_logic_vector(2 downto 0); wr: in std_logic_vector (4 downto 0)) is
begin
	case reg is
		when "000" => t0 := wr;
		when "001" => t1 := wr;
		when "010" => t2 := wr;
		when "011" => t3 := wr;
		when "100" => t4 := wr;
		when "101" => t5 := wr;
		when "110" => lo := wr;
		when "111" => hi := wr;
		when others => NULL;
	end case;
end write_register;

procedure read_register(reg: in std_logic_vector(2 downto 0); rd: out std_logic_vector (4 downto 0)) is
begin
	case reg IS
		when "000" => rd := t0;
		when "001" => rd := t1;
		when "010" => rd := t2;
		when "011" => rd := t3;
		when "100" => rd := t4;
		when "101" => rd := t5;
		when "110" => rd := lo;
		when "111" => rd := hi;
		when others => NULL;
	end case;
end read_register;

shared variable immediate : std_logic_vector(4 downto 0);
shared variable temp1, temp2, temp3 : std_logic_vector (4 downto 0);
shared variable temp4 : std_logic_vector (9 downto 0);

begin
	process(CLK)
	begin
		Opcode := Instruction(15 downto 12);
		RR1 := Instruction(11 downto 9);
		RR2 := Instruction(8 downto 6);
		RW := Instruction(5 downto 3);
		shamt := Instruction(2 downto 0);
		if rising_edge(CLK) then
			case Opcode is
				when "0000" =>	--Add
					read_register(RR1, temp1);
					read_register(RR2, temp2);
					temp3 := temp1 + temp2;
					write_register(RW, temp3);
				when "0001" => --Add Immediate
					immediate := Instruction(4 downto 0);
					read_register(RR1, temp1);
					temp3 := temp1 + immediate;
					write_register(RR2, temp3);
				when "0010" =>	--Subtract
					read_register(RR1, temp1);
					read_register(RR2, temp2);
					temp3 := temp1 - temp2;
					write_register(RW, temp3);
				when "0011" =>	--Multiply
					read_register(RR1, temp1);
					read_register(RR2, temp2);
					temp4 := temp1 * temp2;
					write_register(hiAddr, temp4(9 downto 5));
					write_register(loAddr, temp4(4 downto 0));
				when "0100" =>	--Divide
					read_register(RR1, temp1);
					read_register(RR2, temp2);
					temp3 := std_logic_vector(to_unsigned(to_integer(unsigned(temp1)) / to_integer(unsigned(temp2)), 5));		--lo contains quotient
					write_register(loAddr, temp3);
					temp3 := std_logic_vector(to_unsigned(to_integer(unsigned(temp1)) REM to_integer(unsigned(temp2)), 5));	--hi contains remainder
					write_register(hiAddr, temp3);
				when "0101" =>	--AND
					read_register(RR1, temp1);
					read_register(RR2, temp2);
					temp3 := temp1 AND temp2;
					write_register(RW, temp3);
				when "0110" =>	--OR
					read_register(RR1, temp1);
					read_register(RR2, temp2);
					temp3 := temp1 OR temp2;
					write_register(RW, temp3);
				when "0111" =>	--XOR
					read_register(RR1, temp1);
					read_register(RR2, temp2);
					temp3 := temp1 XOR temp2;
					write_register(RW, temp3);
				when "1000" =>	--NOR
					read_register(RR1, temp1);
					read_register(RR2, temp2);
					temp3 := temp1 NOR temp2;
					write_register(RW, temp3);
				when "1001" =>	--NAND
					read_register(RR1, temp1);
					read_register(RR2, temp2);
					temp3 := temp1 NAND temp2;
					write_register(RW, temp3);
				when "1010" =>	--Shift Left Logical
					read_register(RR1, temp1);
					temp3 := std_logic_vector(unsigned(temp1) SLL to_integer(unsigned(shamt)));
					write_register(RW, temp3);
				when "1011" =>	--Shift Right Logical
					read_register(RR1, temp1);
					temp3 := std_logic_vector(unsigned(temp1) SRL to_integer(unsigned(shamt)));
					write_register(RW, temp3);
				when "1100" =>	--Rotate Left
					read_register(RR1, temp1);
					temp3 := std_logic_vector(unsigned(temp1) ROL to_integer(unsigned(shamt)));
					write_register(RW, temp3);
				when "1101" =>	--Rotate Right
					read_register(RR1, temp1);
					temp3 := std_logic_vector(unsigned(temp1) ROR to_integer(unsigned(shamt)));
					write_register(RW, temp3);
				when "1110" => --AND Immediate
					immediate := Instruction(4 downto 0);
					read_register(RR1, temp1);
					temp3 := temp1 AND immediate;
					write_register(RR2, temp3);
				when "1111" => --OR Immediate
					immediate := Instruction(4 downto 0);
					read_register(RR1, temp1);
					temp3 := temp1 OR immediate;
					write_register(RR2, temp3);
				when others => NULL;
			end case;
			read_register(t0Addr, temp3);
			t0Val <= temp3;
			read_register(t1Addr, temp3);
			t1Val <= temp3;
			read_register(t2Addr, temp3);
			t2Val <= temp3;
			read_register(t3Addr, temp3);
			t3Val <= temp3;
			read_register(t4Addr, temp3);
			t4Val <= temp3;
			read_register(t5Addr, temp3);
			t5Val <= temp3;
			read_register(loAddr, temp3);
			loVal <= temp3;
			read_register(hiAddr, temp3);
			hiVal <= temp3;
		end if;
	end process;

end Behavioral;

