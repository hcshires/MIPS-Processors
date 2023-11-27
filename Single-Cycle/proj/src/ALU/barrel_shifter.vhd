-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires and Henry Shires
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- barrel_shifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a design for a barrel shifter.
--              
-- 03/03/23: Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity barrel_shifter is
  generic (
    bus_width : integer := 32;
    sel_width : integer := 5
  );
  port (
    i_shamt : in std_logic_vector(sel_width - 1 downto 0);
    i_shsrc : in std_logic_vector(bus_width - 1 downto 0); -- Input to shift
    i_shdir : in std_logic;                                -- Shift direction (0 = left, 1 = right)
    i_sharr : in std_logic;                                -- Shift arithmetic (0 = logical, 1 = yes)
    o_val : out std_logic_vector(bus_width - 1 downto 0)   -- Output new value
  );

end barrel_shifter;

-- 32-bit 2-1 MUX Barrel Shifter for SLL, SRL, and SRA
architecture structural of barrel_shifter is
  component mux2t1_N is
    port (
      i_S : in std_logic;
      i_D0 : in std_logic_vector(bus_width - 1 downto 0);
      i_D1 : in std_logic_vector(bus_width - 1 downto 0);
      o_O : out std_logic_vector(bus_width - 1 downto 0)
    );

  end component;

  component mux2t1 is
    port(
    i_S       : in std_logic;
    i_D0      : in std_logic;
    i_D1      : in std_logic;
    o_O       : out std_logic
  );

  end component;
  
  -- Reversed data vectors
  signal s_reverseIn   : std_logic_vector(bus_width - 1 downto 0);
  signal s_reverseOut  : std_logic_vector(bus_width - 1 downto 0);

  -- Shift logical (L/R)
  signal s_LogicalShift1   : std_logic_vector(bus_width - 1 downto 0);
  signal s_LogicalShift2   : std_logic_vector(bus_width - 1 downto 0);
  signal s_LogicalShift4   : std_logic_vector(bus_width - 1 downto 0);
  signal s_LogicalShift8   : std_logic_vector(bus_width - 1 downto 0);

  -- Shift right arithmetic
  signal s_RightArrShift1  : std_logic_vector(bus_width - 1 downto 0);
  signal s_RightArrShift2  : std_logic_vector(bus_width - 1 downto 0);
  signal s_RightArrShift4  : std_logic_vector(bus_width - 1 downto 0);
  signal s_RightArrShift8  : std_logic_vector(bus_width - 1 downto 0);

  -- Concatenated outputs
  signal s_LogicalShift    : std_logic_vector(bus_width - 1 downto 0);
  signal s_RightArrShift   : std_logic_vector(bus_width - 1 downto 0);

begin
  -- Logical Shift (sll and srl) --
  -- Reverse vector for left
  reverse1: for i in 0 to bus_width-1 generate
    MUX: mux2t1 port map(i_shdir, i_shsrc(bus_width-1 - i), i_shsrc(i), s_reverseIn(i)); -- When 0, reverse for left, else normal
  end generate;

  -- Shift 16 Logical
  shift_16L: for i in 0 to bus_width-16-1 generate
    MUX: mux2t1 port map(i_shamt(4), s_reverseIn(i), s_reverseIn(i + 16), s_LogicalShift8(i));
  end generate;

  shift_16L2: for i in bus_width-16 to bus_width-1 generate
    MUX: mux2t1 port map(i_shamt(4), s_reverseIn(i), '0', s_LogicalShift8(i));
  end generate;

  -- Shift 8
  shift_8L: for i in 0 to bus_width-8-1 generate
    MUX: mux2t1 port map(i_shamt(3), s_LogicalShift8(i), s_LogicalShift8(i + 8), s_LogicalShift4(i));
  end generate;

  shift_8L2: for i in bus_width-8 to bus_width-1 generate
    MUX: mux2t1 port map(i_shamt(3), s_LogicalShift8(i), '0', s_LogicalShift4(i));
  end generate;

  -- Shift 4
  shift_4L: for i in 0 to bus_width-4-1 generate
    MUX: mux2t1 port map(i_shamt(2), s_LogicalShift4(i), s_LogicalShift4(i + 4), s_LogicalShift2(i));
  end generate;
  
  shift_4L2: for i in bus_width-4 to bus_width-1 generate
    MUX: mux2t1 port map(i_shamt(2), s_LogicalShift4(i), '0', s_LogicalShift2(i));
  end generate;

  -- Shift 2
  shift_2L: for i in 0 to bus_width-2-1 generate
    MUX: mux2t1 port map(i_shamt(1), s_LogicalShift2(i), s_LogicalShift2(i + 2), s_LogicalShift1(i));
  end generate;

  shift_2L2: for i in bus_width-2 to bus_width-1 generate
    MUX: mux2t1 port map(i_shamt(1), s_LogicalShift2(i), '0', s_LogicalShift1(i));
  end generate;

  -- Shift 1
  shift_1L: for i in 0 to bus_width-1-1 generate
    MUX: mux2t1 port map(i_shamt(0), s_LogicalShift1(i), s_LogicalShift1(i + 1), s_LogicalShift(i));
  end generate;

  shift_1L2: mux2t1 port map(i_shamt(0), s_LogicalShift1(31), '0', s_LogicalShift(31));

  -- Reverse reverse vector for left lol
  reverse2: for i in 0 to bus_width-1 generate
    MUX: mux2t1 port map(i_shdir, s_LogicalShift(bus_width-1 - i), s_LogicalShift(i), s_reverseOut(i)); -- When 0, reverse for left, else normal
  end generate;
  -- End sll srl --

  -- Arithmetic Shift (sra) --
  -- Shift 16
  shift_16R: for i in 0 to bus_width-16-1 generate
    MUX: mux2t1 port map(i_shamt(4), i_shsrc(i), i_shsrc(i + 16), s_RightArrShift8(i));
  end generate;

  shift_16R2: for i in bus_width-16 to bus_width-1 generate
    MUX: mux2t1 port map(i_shamt(4), s_reverseIn(i), i_shsrc(31), s_RightArrShift8(i));
  end generate;

  -- Shift 8
  shift_8R: for i in 0 to bus_width-8-1 generate
    MUX: mux2t1 port map(i_shamt(3), s_RightArrShift8(i), s_RightArrShift8(i + 8), s_RightArrShift4(i));
  end generate;

  shift_8R2: for i in bus_width-8 to bus_width-1 generate
    MUX: mux2t1 port map(i_shamt(3), s_RightArrShift8(i), i_shsrc(31), s_RightArrShift4(i));
  end generate;

  -- Shift 4
  shift_4R: for i in 0 to bus_width-4-1 generate
    MUX: mux2t1 port map(i_shamt(2), s_RightArrShift4(i), s_RightArrShift4(i + 4), s_RightArrShift2(i));
  end generate;
  
  shift_4R2: for i in bus_width-4 to bus_width-1 generate
    MUX: mux2t1 port map(i_shamt(2), s_RightArrShift4(i), i_shsrc(31), s_RightArrShift2(i));
  end generate;

  -- Shift 2
  shift_2R: for i in 0 to bus_width-2-1 generate
    MUX: mux2t1 port map(i_shamt(1), s_RightArrShift2(i), s_RightArrShift2(i + 2), s_RightArrShift1(i));
  end generate;

  shift_2R2: for i in bus_width-2 to bus_width-1 generate
    MUX: mux2t1 port map(i_shamt(1), s_RightArrShift2(i), i_shsrc(31), s_RightArrShift1(i));
  end generate;

  -- Shift 1
  shift_1R: for i in 0 to bus_width-1-1 generate
    MUX: mux2t1 port map(i_shamt(0), s_RightArrShift1(i), s_RightArrShift1(i + 1), s_RightArrShift(i));
  end generate;

  shift_1R2: mux2t1 port map(i_shamt(0), s_RightArrShift1(31), i_shsrc(31), s_RightArrShift(31));
  -- End sra --

  -- OUTPUT: Select logical or arithmetic output
  ArrMUX : mux2t1_N port map(i_sharr, s_reverseOut, s_RightArrShift, o_val);

end architecture;