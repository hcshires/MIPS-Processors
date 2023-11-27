-------------------------------------------------------------------------
-- Tony Manschula and Henry Shires [CPR E]
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
--
-- regFile.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an 32-reg register 
-- file
--
-- 02/15/2023 Design created.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MIPS_types.all;

entity regfile is
  --Reg size = amount of bits per register, also corresponds to bus width in the mux
  --Sel width = Amount of bits for mux select signal, same size as i_rX, and tells us how many registers to have in the file
  generic (reg_size : integer := 32;
           sel_width : integer := 5
          );
  port (i_src1      : in std_logic_vector(sel_width-1 downto 0);
        i_src2      : in std_logic_vector(sel_width-1 downto 0);
        i_dest      : in std_logic_vector(sel_width-1 downto 0);
        i_wdata     : in std_logic_vector(reg_size-1 downto 0);
        i_RegWrite  : in std_logic; 
        i_CLK       : in std_logic;
        i_RST       : in std_logic;
        o_data_src1 : out std_logic_vector(reg_size-1 downto 0);
        o_data_src2 : out std_logic_vector(reg_size-1 downto 0)
        );

end regfile;

architecture structural of regfile is
  --Contains output of the decoder from the write enable signal (rd)
  signal s_dec_bus : std_logic_vector((2**sel_width)-1 downto 0);
  --Bus array contains sel_width^2 signals of reg_size bits wide. Output of each register
  signal s_data_bus_array : bus_array((2**sel_width) - 1 downto 0)(reg_size-1 downto 0);
  signal s_WrEn : std_logic_vector((2**sel_width)-1 downto 0);
  
  component dec_5t32 is
    port (
          i_sel        : in std_logic_vector(4 downto 0);
          o_sel_1hot   : out std_logic_vector(31 downto 0)
          );
  end component;

  component reg is
    generic (N : integer := 32);  --Default 32 bit register
    port (i_CLK   : in std_logic;
          i_RST   : in std_logic;
          i_WEn   : in std_logic;
          i_Data  : in std_logic_vector(N-1 downto 0);
          o_Data  : out std_logic_vector(N-1 downto 0)
          );
  end component;

  component mips_reg_preset is
    generic (N: integer := 32);
    port (i_CLK     : in std_logic;
          i_RST     : in std_logic;
          i_RST_Val : in std_logic_vector (N-1 downto 0);
          i_WEn     : in std_logic;
          i_Data    : in std_logic_vector(N-1 downto 0);
          o_Data    : out std_logic_vector(N-1 downto 0)
    );
  end component;

  component mux_Nt1 is
    generic (
            bus_width : integer := 32;
            sel_width : integer := 5
          );
    port (
          --2D array of [2^sel_width][bus_width] size
          --Array width must be an int that represents the size, not treated as a binary
          i_reg_bus : in bus_array(2**sel_width- 1 downto 0)(bus_width-1 downto 0);
          i_sel     : in std_logic_vector(sel_width-1 downto 0);
          o_reg     : out std_logic_vector(bus_width-1 downto 0)
          );
  end component;

  component andg2 is
    port(i_A          : in std_logic;
        i_B          : in std_logic;
        o_F          : out std_logic);
  end component;

begin
  rd_dec : dec_5t32 port map (i_dest, s_dec_bus);

  --Set up the zero register independently
  zero_reg : reg  generic map (reg_size) 
                  --Even though we have i_wdata bound to the data input, it will never be written as RST is tied to 1
                  port map (i_CLK, '1', '0', i_wdata, s_data_bus_array(0));

  g_and_loop : for i in 1 to (2**sel_width)-1 generate
    AND_N : andg2 port map (s_dec_bus(i), i_RegWrite, s_WrEn(i));
  end generate g_and_loop;

  --Regs $1 to $27
  g_reg_loop : for i in 1 to (2**sel_width)-5 generate
    REG_N : reg generic map (reg_size)
                port map (i_CLK, i_RST, s_WrEn(i), i_wdata, s_data_bus_array(i));
  end generate g_reg_loop;

  gp_reg: mips_reg_preset
    generic map(reg_size)
    port map (i_CLK, i_RST, x"10008000", s_WrEn(28), i_wdata, s_data_bus_array(28));

  sp_reg: mips_reg_preset
    generic map(reg_size)
    port map (i_CLK, i_RST, x"7FFFEFFC", s_WrEn(29), i_wdata, s_data_bus_array(29));

  fp_reg: reg 
    generic map (reg_size)
    port map (i_CLK, i_RST, s_WrEn(30), i_wdata, s_data_bus_array(30));

  ra_reg: reg 
    generic map (reg_size)
    port map (i_CLK, i_RST, s_WrEn(31), i_wdata, s_data_bus_array(31));

  mux_rs : mux_Nt1 generic map (reg_size, sel_width)
                  port map (s_data_bus_array, i_src1, o_data_src1);

  mux_rt : mux_Nt1 generic map (reg_size, sel_width)
                  port map (s_data_bus_array, i_src2, o_data_src2);
end structural;