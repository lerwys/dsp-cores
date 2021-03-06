-------------------------------------------------------------------------------
-- Title      : Fixed sin-cos DDS
-- Project    :
-------------------------------------------------------------------------------
-- File       : fixed_dds.vhd
-- Author     : aylons  <aylons@LNLS190>
-- Company    :
-- Created    : 2014-03-07
-- Last update: 2014-06-20
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Fixed frequency phase and quadrature DDS for use in tuned DDCs.
-- Moreover, it has an option to dynamically change the output signal phase,
-- according to the phase_i input.
-------------------------------------------------------------------------------
-- Copyright (c) 2014
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-03-07  1.0      aylons  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.vcomponents.all;

library work;
use work.genram_pkg.all;
-------------------------------------------------------------------------------

entity fixed_dds is

  generic (
    g_number_of_points : natural := 203;  -- Number of points of sin and cos (each)
    g_output_width     : natural := 16;   -- Output resolution
    g_phase_bus_size   : natural := 8;  -- Number of selectable phases, max 256
    g_sin_file         : string  := "./dds_sin.ram";  -- Files with points data
    g_cos_file         : string  := "./dds_cos.ram"
    );
  port (
    clock_i     : in  std_logic;
    ce_i        : in  std_logic;
    reset_i     : in  std_logic;
    phase_sel_i : in  std_logic_vector(g_phase_bus_size-1 downto 0);
    sin_o       : out std_logic_vector(g_output_width-1 downto 0);
    cos_o       : out std_logic_vector(g_output_width-1 downto 0)
    );

end entity fixed_dds;

-------------------------------------------------------------------------------

architecture str of fixed_dds is

  constant c_bus_size     : natural := f_log2_size(g_number_of_points)+g_phase_bus_size;
  signal cur_address      : std_logic_vector(c_bus_size-1 downto 0);
  signal reset_n          : std_logic;
  signal cos_reg, sin_reg : std_logic_vector(g_output_width-1 downto 0);

  component lut_sweep is
    generic (
      g_phase_bus_size   : natural;
      g_number_of_points : natural;
      g_bus_size         : natural);
    port (
      reset_i     : in  std_logic;
      clock_i     : in  std_logic;
      ce_i        : in  std_logic;
      phase_sel_i : in  std_logic_vector(g_phase_bus_size-1 downto 0);
      address_o   : out std_logic_vector(g_bus_size-1 downto 0));
  end component lut_sweep;

  component pipeline is
    generic (
      g_width : natural;
      g_depth : natural);
    port (
      data_i : in  std_logic_vector(g_width-1 downto 0);
      clk_i  : in  std_logic;
      ce_i   : in  std_logic;
      data_o : out std_logic_vector(g_width-1 downto 0));
  end component pipeline;

  component sin_lut_uvx_35_148
    port (
      clka  : in std_logic;
      addra : in std_logic_vector(5 downto 0);
      douta : out std_logic_vector(31 downto 0)
    );
  end component sin_lut_uvx_35_148;

  component cos_lut_uvx_35_148
    port (
      clka  : in std_logic;
      addra : in std_logic_vector(5 downto 0);
      douta : out std_logic_vector(31 downto 0)
    );
  end component cos_lut_uvx_35_148;

begin  -- architecture str

  cmp_lut_sweep : lut_sweep
    generic map (
      g_phase_bus_size   => g_phase_bus_size,
      g_number_of_points => g_number_of_points,
      g_bus_size         => c_bus_size)
    port map (
      reset_i     => reset_i,
      clock_i     => clock_i,
      ce_i        => ce_i,
      phase_sel_i => phase_sel_i,
      address_o   => cur_address);

  reset_n <= not(reset_i);

  cmp_sin_lut : sin_lut_uvx_35_148
  port map (
    clka    => clock_i,
    addra   => cur_address,
    douta   => sin_reg
  );

  cmp_cos_lut : cos_lut_uvx_35_148
  port map (
    clka    => clock_i,
    addra   => cur_address,
    douta   => cos_reg
  );

  cmp_reg_sin : pipeline
    generic map (
      g_width => g_output_width,
      g_depth => 2)
    port map (
      data_i => sin_reg,
      clk_i  => clock_i,
      ce_i   => ce_i,
      data_o => sin_o);

  cmp_reg_cos : pipeline
    generic map (
      g_width => g_output_width,
      g_depth => 2)
    port map (
      data_i => cos_reg,
      clk_i  => clock_i,
      ce_i   => ce_i,
      data_o => cos_o);

end architecture str;

-------------------------------------------------------------------------------
