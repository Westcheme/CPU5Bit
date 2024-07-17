--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   07:25:15 04/06/2021
-- Design Name:   
-- Module Name:   /home/ise/Documents/ECE475/CPU5Bit/CPU5Bit_TB.vhd
-- Project Name:  CPU5Bit
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU5Bit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CPU5Bit_TB IS
END CPU5Bit_TB;
 
ARCHITECTURE behavior OF CPU5Bit_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU5Bit
    PORT(
         CLK : IN  std_logic;
         Instruction : IN STD_LOGIC_VECTOR(15 downto 0);
         t0Val : OUT  std_logic_vector(4 downto 0);
         t1Val : OUT  std_logic_vector(4 downto 0);
         t2Val : OUT  std_logic_vector(4 downto 0);
         t3Val : OUT  std_logic_vector(4 downto 0);
         t4Val : OUT  std_logic_vector(4 downto 0);
         t5Val : OUT  std_logic_vector(4 downto 0);
			loVal : OUT  std_logic_vector(4 downto 0);
         hiVal : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Instruction : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

 	--Outputs
   signal t0Val : std_logic_vector(4 downto 0);
   signal t1Val : std_logic_vector(4 downto 0);
   signal t2Val : std_logic_vector(4 downto 0);
   signal t3Val : std_logic_vector(4 downto 0);
   signal t4Val : std_logic_vector(4 downto 0);
   signal t5Val : std_logic_vector(4 downto 0);
	signal loVal : std_logic_vector(4 downto 0);
   signal hiVal : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU5Bit PORT MAP (
          CLK => CLK,
          Instruction => Instruction,
          t0Val => t0Val,
          t1Val => t1Val,
          t2Val => t2Val,
          t3Val => t3Val,
          t4Val => t4Val,
          t5Val => t5Val,
			 loVal => loVal,
          hiVal => hiVal
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		Instruction <= b"0001_000_001_000100";	-- I-Type Instruction: addi $t1, $t0, "00100"
		wait for CLK_period;
		Instruction <= b"0001_000_010_000001";	-- I-Type Instruction: addi $t2, $t0, "00001"
		wait for CLK_period;
		Instruction <= b"0000_001_010_011_000";	-- R-Type Instruction: add $t3, $t1, $t2
		wait for CLK_period;
		Instruction <= b"0010_001_010_011_000";	-- R-Type Instruction: sub $t3, $t1, $t2
		wait for CLK_period;
--		Opcode <= "0001";
--		RR1 <= "000";
--		RR2 <= "001";
--		RW <= "011";
--		shamt <= "111";
--		wait for CLK_period;
--		Opcode <= "0001";
--		RR1 <= "000";
--		RR2 <= "010";
--		RW <= "011";
--		shamt <= "111";
--		wait for CLK_period;
--		Opcode <= "0011";
--		RR1 <= "001";
--		RR2 <= "010";
--		RW <= "011";
--		shamt <= "000";
--		wait for CLK_period;
--		Opcode <= "0100";
--		RR1 <= "001";
--		RR2 <= "011";
--		RW <= "011";
--		shamt <= "000";
--		wait for CLK_period;
--		Opcode <= "0101";
--		RR1 <= "001";
--		RR2 <= "011";
--		RW <= "100";
--		shamt <= "000";
--		wait for CLK_period;
--		Opcode <= "1010";
--		RR1 <= "011";
--		RR2 <= "011";
--		RW <= "011";
--		shamt <= "011";
--		wait for CLK_period;
--		Opcode <= "1011";
--		RR1 <= "011";
--		RR2 <= "011";
--		RW <= "011";
--		shamt <= "011";
--		wait for CLK_period;
--		Opcode <= "1100";
--		RR1 <= "011";
--		RR2 <= "011";
--		RW <= "011";
--		shamt <= "100";
--		wait for CLK_period;
--		Opcode <= "1101";
--		RR1 <= "011";
--		RR2 <= "011";
--		RW <= "011";
--		shamt <= "010";
--		wait for CLK_period;
		Instruction <= (others => 'X');

      wait;
   end process;

END;
