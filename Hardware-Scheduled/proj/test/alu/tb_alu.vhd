-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the ALU.
--              
-- 03/10/23: Created
-- 3/30/23: Modified by Henry Shires
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_alu is
  generic (
    bus_width : integer := 32;
    sel_width : integer := 5
  );
end tb_alu;

architecture structural of tb_alu is
  component ALU is
    --Data bus width
    generic (N : integer := 32);
    port (
          i_ALUCtrl   : in std_logic_vector(4 downto 0);
          --Data 0 goes to i_A of adder
          i_Data_0    : in std_logic_vector(N-1 downto 0);
          --Data 1 goes to 1's comp unit (inverter), and to input 0 of mux
          --Mux controls whether the inverted or untouched data is added to data_0
          i_Data_1    : in std_logic_vector(N-1 downto 0);
          i_shamt     : in std_logic_vector(4 downto 0);

          o_ALUOut    : out std_logic_vector(N-1 downto 0);
          o_Cout      : out std_logic;
          o_Overflow  : out std_logic
    );
  end component;

  -- ALU Control input
  signal s_iALUCtrl : std_logic_vector(4 downto 0);

  -- Data inputs
  signal s_iData0   : std_logic_vector(bus_width - 1 downto 0);
  signal s_iData1   : std_logic_vector(bus_width - 1 downto 0);
  signal s_iShamt   : std_logic_vector(sel_width - 1 downto 0);

  -- Data outputs
  signal s_oALUOut  : std_logic_vector(bus_width - 1 downto 0);
  signal s_oCout, s_oOverflow : std_logic;

begin
  DUT0: ALU generic map (bus_width) port map (s_iALUCtrl, s_iData0, s_iData1, s_iShamt, s_oALUOut, s_oCout, s_oOverflow);

  P_TEST_CASES: process begin
    -- Add signed. Should cause overflow to trigger
    s_iALUCtrl <= "11010";
    s_iData0   <= x"7FFFFFFF";
    s_iData1   <= x"00000001";
    wait for 5 ns;

    -- Add unsigned. Should not cause overflow to trigger
    s_iALUCtrl <= "01010";
    s_iData0   <= x"7FFFFFFF";
    s_iData1   <= x"00000001";
    wait for 5 ns;

    -- AND. Expect 00000001000000100000101000001110
    s_iALUCtrl <= "00000";
    s_iData0   <= b"01010001010100101100101000111110";
    s_iData1   <= b"00001111000011110000111100001111";
    wait for 5 ns;

    -- AND. Expect 0s
    s_iALUCtrl <= "00000";
    s_iData0   <= x"00000000";
    s_iData1   <= x"00000000";
    wait for 5 ns;

    -- AND. Expect 0s
    s_iALUCtrl <= "00000";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"00000000";
    wait for 5 ns;

    -- AND. Expect 0s
    s_iALUCtrl <= "00000";
    s_iData0   <= x"00000000";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- AND. Expect 1s
    s_iALUCtrl <= "00000";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- NOR. Expect 10100000101000000011000011000000
    s_iALUCtrl <= "00110";
    s_iData0   <= b"01010001010100101100101000111110";
    s_iData1   <= b"00001111000011110000111100001111";
    wait for 5 ns;

    -- NOR. Expect 1s
    s_iALUCtrl <= "00110";
    s_iData0   <= x"00000000";
    s_iData1   <= x"00000000";
    wait for 5 ns;

    -- NOR. Expect 0s
    s_iALUCtrl <= "00110";
    s_iData0   <= x"00000000";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- NOR. Expect 0s
    s_iALUCtrl <= "00110";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"00000000";
    wait for 5 ns;

    -- NOR. Expect 0s
    s_iALUCtrl <= "00110";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- XOR. Expect 01011110010111011100010100110001
    s_iALUCtrl <= "00111";
    s_iData0   <= b"01010001010100101100101000111110";
    s_iData1   <= b"00001111000011110000111100001111";
    wait for 5 ns;

    -- XOR. Expect 0s
    s_iALUCtrl <= "00111";
    s_iData0   <= x"00000000";
    s_iData1   <= x"00000000";
    wait for 5 ns;

    -- XOR. Expect 1s
    s_iALUCtrl <= "00111";
    s_iData0   <= x"00000000";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- XOR. Expect 1s
    s_iALUCtrl <= "00111";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"00000000";
    wait for 5 ns;

    -- XOR. Expect 0s
    s_iALUCtrl <= "00111";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- OR. Expect 01011111010111111100111100111111
    s_iALUCtrl <= "00001";
    s_iData0   <= b"01010001010100101100101000111110";
    s_iData1   <= b"00001111000011110000111100001111";
    wait for 5 ns;

    -- OR. Expect 0s
    s_iALUCtrl <= "00001";
    s_iData0   <= x"00000000";
    s_iData1   <= x"00000000";
    wait for 5 ns;

    -- OR. Expect "FFFFFFFF"
    s_iALUCtrl <= "00001";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"00000000";
    wait for 5 ns;

    -- OR. Expect "FFFFFFFF"
    s_iALUCtrl <= "00001";
    s_iData0   <= x"00000000";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- OR. Expect "FFFFFFFF"
    s_iALUCtrl <= "00001";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- Set less than, both positive iD0 < iD1 -> 1
    s_iALUCtrl <= "01111";
    s_iData0   <= x"70000000";
    s_iData1   <= x"70001234";
    wait for 5 ns;

    -- Set less than, both positive iD0 > iD1 -> 0
    s_iALUCtrl <= "01111";
    s_iData0   <= x"70001234";
    s_iData1   <= x"70000000";
    wait for 5 ns;

    -- Set less than, positive negative (1 -1) -> 0
    s_iALUCtrl <= "01111";
    s_iData0   <= x"00000001";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- Set less than, positive negative (-1 1) -> 1
    s_iALUCtrl <= "01111";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"00000001";
    wait for 5 ns;

    -- Set less than, negative negative (-1 -2) -> 0
    s_iALUCtrl <= "01111";
    s_iData0   <= x"FFFFFFFF";
    s_iData1   <= x"FFFFFFFE";
    wait for 5 ns;

    -- Set less than, negative negative (-2 -1) -> 1
    s_iALUCtrl <= "01111";
    s_iData0   <= x"FFFFFFFE";
    s_iData1   <= x"FFFFFFFF";
    wait for 5 ns;

    -- Shift left logical. 0
    s_iALUCtrl <= "01011";
    s_iData1   <= x"00000001";
    s_iShamt   <= "00000";
    wait for 5 ns;

    -- Shift left logical. 1
    s_iALUCtrl <= "01011";
    s_iData1   <= x"00000001";
    s_iShamt   <= "00001";
    wait for 5 ns;

    -- Shift left logical. 2
    s_iALUCtrl <= "01011";
    s_iData1   <= x"00000001";
    s_iShamt   <= "00010";
    wait for 5 ns;

    -- Shift left logical. 4
    s_iALUCtrl <= "01011";
    s_iData1   <= x"00000001";
    s_iShamt   <= "00100";
    wait for 5 ns;

    -- Shift left logical. 8
    s_iALUCtrl <= "01011";
    s_iData1   <= x"00000001";
    s_iShamt   <= "01000";
    wait for 5 ns;

    -- Shift left logical. 16
    s_iALUCtrl <= "01011";
    s_iData1   <= x"00000001";
    s_iShamt   <= "10000";
    wait for 5 ns;

    -- Shift left logical. 31
    s_iALUCtrl <= "01011";
    s_iData1   <= x"00000001";
    s_iShamt   <= "11111";
    wait for 5 ns;

    -- Shift right logical. 0
    s_iALUCtrl <= "01100";
    s_iData1   <= x"80000000";
    s_iShamt   <= "00000";
    wait for 5 ns;

    -- Shift right logical. 1
    s_iALUCtrl <= "01100";
    s_iData1   <= x"80000000";
    s_iShamt   <= "00001";
    wait for 5 ns;

    -- Shift right logical. 2
    s_iALUCtrl <= "01100";
    s_iData1   <= x"80000000";
    s_iShamt   <= "00010";
    wait for 5 ns;

    -- Shift right logical. 4
    s_iALUCtrl <= "01100";
    s_iData1   <= x"80000000";
    s_iShamt   <= "00100";
    wait for 5 ns;

    -- Shift right logical. 8
    s_iALUCtrl <= "01100";
    s_iData1   <= x"80000000";
    s_iShamt   <= "01000";
    wait for 5 ns;

    -- Shift right logical. 16
    s_iALUCtrl <= "01100";
    s_iData1   <= x"80000000";
    s_iShamt   <= "10000";
    wait for 5 ns;

    -- Shift right logical. 31
    s_iALUCtrl <= "01100";
    s_iData1   <= x"80000000";
    s_iShamt   <= "11111";
    wait for 5 ns;

    -- Shift right arithmetic. 0
    s_iALUCtrl <= "01100";
    s_iData1   <= x"80000000";
    s_iShamt   <= "00000";
    wait for 5 ns;

    -- Shift right arithmetic. 1
    s_iALUCtrl <= "01101";
    s_iData1   <= x"80000000";
    s_iShamt   <= "00001";
    wait for 5 ns;

    -- Shift right arithmetic. 2
    s_iALUCtrl <= "01101";
    s_iData1   <= x"80000000";
    s_iShamt   <= "00010";
    wait for 5 ns;

    -- Shift right arithmetic. 4
    s_iALUCtrl <= "01101";
    s_iData1   <= x"80000000";
    s_iShamt   <= "00100";
    wait for 5 ns;

    -- Shift right arithmetic. 8
    s_iALUCtrl <= "01101";
    s_iData1   <= x"80000000";
    s_iShamt   <= "01000";
    wait for 5 ns;

    -- Shift right arithmetic. 16
    s_iALUCtrl <= "01101";
    s_iData1   <= x"80000000";
    s_iShamt   <= "10000";
    wait for 5 ns;

    -- Shift right arithmetic. 31
    s_iALUCtrl <= "01101";
    s_iData1   <= x"80000000";
    s_iShamt   <= "11111";
    wait for 5 ns;

    -- Subtract signed. Should cause overflow
    s_iALUCtrl <= "11110";
    s_iData0   <= x"80000000";
    s_iData1   <= x"00000001";
    wait for 5 ns;

    -- Subtract signed. Zero detection
    s_iALUCtrl <= "11110";
    s_iData0   <= x"80000000";
    s_iData1   <= x"80000000";
    wait for 5 ns;

    -- Subtract unsigned. Should not cause overflow
    s_iALUCtrl <= "01110";
    s_iData0   <= x"80000000";
    s_iData1   <= x"00000001";
    wait for 5 ns;
    wait;
  end process;

end structural;