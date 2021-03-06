-------------------------------------------------------------------------------
-- Title      : Position calc, no sysgen generator
-- Project    :
-------------------------------------------------------------------------------
-- File       : position_nosysgen.vhd
-- Author     : aylons  <aylons@LNLS190>
-- Company    :
-- Created    : 2014-05-06
-- Last update: 2014-08-02
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Position calculation with no sysgen parts
-------------------------------------------------------------------------------
-- Copyright (c) 2014
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-05-06  1.0      aylons  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity position_nosysgen is
  port(
    adc_ch0_i : in std_logic_vector(15 downto 0);
    adc_ch1_i : in std_logic_vector(15 downto 0);
    adc_ch2_i : in std_logic_vector(15 downto 0);
    adc_ch3_i : in std_logic_vector(15 downto 0);

    clk : in std_logic;  -- clock period = 4.44116091946435 ns (225.16635135135124 Mhz)
    clr : in std_logic;                 -- clear signal

    del_sig_div_fofb_thres_i  : in std_logic_vector(25 downto 0);
    del_sig_div_monit_thres_i : in std_logic_vector(25 downto 0);
    del_sig_div_tbt_thres_i   : in std_logic_vector(25 downto 0);

    ksum_i : in std_logic_vector(23 downto 0);
    kx_i   : in std_logic_vector(23 downto 0);
    ky_i   : in std_logic_vector(23 downto 0);

    dds_config_valid_ch0_i : in std_logic;
    dds_config_valid_ch1_i : in std_logic;
    dds_config_valid_ch2_i : in std_logic;
    dds_config_valid_ch3_i : in std_logic;
    dds_pinc_ch0_i         : in std_logic_vector(29 downto 0);
    dds_pinc_ch1_i         : in std_logic_vector(29 downto 0);
    dds_pinc_ch2_i         : in std_logic_vector(29 downto 0);
    dds_pinc_ch3_i         : in std_logic_vector(29 downto 0);
    dds_poff_ch0_i         : in std_logic_vector(29 downto 0);
    dds_poff_ch1_i         : in std_logic_vector(29 downto 0);
    dds_poff_ch2_i         : in std_logic_vector(29 downto 0);
    dds_poff_ch3_i         : in std_logic_vector(29 downto 0);

    adc_ch0_dbg_data_o : out std_logic_vector(15 downto 0);
    adc_ch1_dbg_data_o : out std_logic_vector(15 downto 0);
    adc_ch2_dbg_data_o : out std_logic_vector(15 downto 0);
    adc_ch3_dbg_data_o : out std_logic_vector(15 downto 0);

    bpf_ch0_o : out std_logic_vector(31 downto 0);
    bpf_ch1_o : out std_logic_vector(31 downto 0);
    bpf_ch2_o : out std_logic_vector(31 downto 0);
    bpf_ch3_o : out std_logic_vector(31 downto 0);

    mix_ch0_i_o : out std_logic_vector(31 downto 0);
    mix_ch0_q_o : out std_logic_vector(31 downto 0);
    mix_ch1_i_o : out std_logic_vector(31 downto 0);
    mix_ch1_q_o : out std_logic_vector(31 downto 0);
    mix_ch2_i_o : out std_logic_vector(31 downto 0);
    mix_ch2_q_o : out std_logic_vector(31 downto 0);
    mix_ch3_i_o : out std_logic_vector(31 downto 0);
    mix_ch3_q_o : out std_logic_vector(31 downto 0);

    tbt_decim_ch0_i_o : out std_logic_vector(31 downto 0);
    tbt_decim_ch0_q_o : out std_logic_vector(31 downto 0);
    tbt_decim_ch1_i_o : out std_logic_vector(31 downto 0);
    tbt_decim_ch1_q_o : out std_logic_vector(31 downto 0);
    tbt_decim_ch2_i_o : out std_logic_vector(31 downto 0);
    tbt_decim_ch2_q_o : out std_logic_vector(31 downto 0);
    tbt_decim_ch3_i_o : out std_logic_vector(31 downto 0);
    tbt_decim_ch3_q_o : out std_logic_vector(31 downto 0);

    tbt_decim_q_ch01_incorrect_o : out std_logic;
    tbt_decim_q_ch23_incorrect_o : out std_logic;

    tbt_amp_ch0_o : out std_logic_vector(31 downto 0);
    tbt_amp_ch1_o : out std_logic_vector(31 downto 0);
    tbt_amp_ch2_o : out std_logic_vector(31 downto 0);
    tbt_amp_ch3_o : out std_logic_vector(31 downto 0);

    tbt_pha_ch0_o : out std_logic_vector(31 downto 0);
    tbt_pha_ch1_o : out std_logic_vector(31 downto 0);
    tbt_pha_ch2_o : out std_logic_vector(31 downto 0);
    tbt_pha_ch3_o : out std_logic_vector(31 downto 0);

    fofb_decim_ch0_i_o : out std_logic_vector(31 downto 0);
    fofb_decim_ch0_q_o : out std_logic_vector(31 downto 0);
    fofb_decim_ch1_i_o : out std_logic_vector(31 downto 0);
    fofb_decim_ch1_q_o : out std_logic_vector(31 downto 0);
    fofb_decim_ch2_i_o : out std_logic_vector(31 downto 0);
    fofb_decim_ch2_q_o : out std_logic_vector(31 downto 0);
    fofb_decim_ch3_i_o : out std_logic_vector(31 downto 0);
    fofb_decim_ch3_q_o : out std_logic_vector(31 downto 0);

    fofb_decim_q_01_missing_o : out std_logic;
    fofb_decim_q_23_missing_o : out std_logic;

    fofb_amp_ch0_o : out std_logic_vector(31 downto 0);
    fofb_amp_ch1_o : out std_logic_vector(31 downto 0);
    fofb_amp_ch2_o : out std_logic_vector(31 downto 0);
    fofb_amp_ch3_o : out std_logic_vector(31 downto 0);

    fofb_pha_ch0_o : out std_logic_vector(31 downto 0);
    fofb_pha_ch1_o : out std_logic_vector(31 downto 0);
    fofb_pha_ch2_o : out std_logic_vector(31 downto 0);
    fofb_pha_ch3_o : out std_logic_vector(31 downto 0);

    monit_amp_ch0_o : out std_logic_vector(31 downto 0);
    monit_amp_ch1_o : out std_logic_vector(31 downto 0);
    monit_amp_ch2_o : out std_logic_vector(31 downto 0);
    monit_amp_ch3_o : out std_logic_vector(31 downto 0);

    monit_cic_unexpected_o : out std_logic;
    monit_cfir_incorrect_o : out std_logic;
    monit_pfir_incorrect_o : out std_logic;

    x_tbt_o         : out std_logic_vector(31 downto 0);
    x_tbt_valid_o   : out std_logic;
    y_tbt_o         : out std_logic_vector(31 downto 0);
    y_tbt_valid_o   : out std_logic;
    q_tbt_o         : out std_logic_vector(31 downto 0);
    q_tbt_valid_o   : out std_logic;
    sum_tbt_o       : out std_logic_vector(31 downto 0);
    sum_tbt_valid_o : out std_logic;

    x_fofb_o         : out std_logic_vector(31 downto 0);
    x_fofb_valid_o   : out std_logic;
    y_fofb_o         : out std_logic_vector(31 downto 0);
    y_fofb_valid_o   : out std_logic;
    q_fofb_o         : out std_logic_vector(31 downto 0);
    q_fofb_valid_o   : out std_logic;
    sum_fofb_o       : out std_logic_vector(31 downto 0);
    sum_fofb_valid_o : out std_logic;

    x_monit_o         : out std_logic_vector(31 downto 0);
    x_monit_valid_o   : out std_logic;
    y_monit_o         : out std_logic_vector(31 downto 0);
    y_monit_valid_o   : out std_logic;
    q_monit_o         : out std_logic_vector(31 downto 0);
    q_monit_valid_o   : out std_logic;
    sum_monit_o       : out std_logic_vector(31 downto 0);
    sum_monit_valid_o : out std_logic;

    -- Clock drivers for various rates
    clk_ce_1_o     : out std_logic;
    clk_ce_2_o     : out std_logic;
    clk_ce_tbt_o   : out std_logic;
    clk_ce_monit_o : out std_logic;
    clk_ce_fofb_o  : out std_logic
   --clk_ce_1112_o      : out std_logic;
   --clk_ce_1390000_o   : out std_logic;
   --clk_ce_2224_o      : out std_logic;
   --clk_ce_22240000_o  : out std_logic;
   --clk_ce_222400000_o : out std_logic;
   --clk_ce_2780000_o   : out std_logic;
   --clk_ce_35_o        : out std_logic;
   --clk_ce_5000_o      : out std_logic;
   --clk_ce_556_o       : out std_logic;
   --clk_ce_5560000_o   : out std_logic;
   --clk_ce_70_o        : out std_logic
    );
end position_nosysgen;

architecture rtl of position_nosysgen is

  -------------
  --Constants--
  -------------
  --downconverter
  constant c_input_width : natural := adc_ch0_i'length;
  constant c_mixed_width : natural := mix_ch0_i_o'length;
  constant c_decim_width : natural := c_mixed_width;
  constant c_phase_width : natural := 0; -- No phase shifts
  constant c_sin_file    : string  := "../../../dsp-cores/hdl/modules/position_calc/dds_lut/dds_sin_uvx_35_148.ram";
  constant c_cos_file    : string  := "../../../dsp-cores/hdl/modules/position_calc/dds_lut/dds_cos_uvx_35_148.ram";
  constant c_dds_points  : natural := 35;

  constant c_adc_ratio       : natural := 2;
  constant c_adc_ratio_full  : natural := 2;

  --dual cic delay
  constant c_tbt_cic1_delay  : natural := 2;
  constant c_tbt_cic1_stages : natural := 1;
  constant c_tbt_ratio1      : natural := 7;
  constant c_tbt_ratio1_full : natural := 7*c_adc_ratio_full;

  constant c_tbt_cic2_delay  : natural := 1;
  constant c_tbt_cic2_stages : natural := 2;
  constant c_tbt_ratio2      : natural := 29;
  constant c_tbt_ratio2_full : natural := 29*c_tbt_ratio1_full;

  constant c_fofb_cic_delay  : natural := 1;
  constant c_fofb_cic_stages : natural := 1;
  constant c_fofb_ratio      : natural := 5;
  constant c_fofb_ratio_full : natural := 5*c_tbt_ratio2_full;

  constant c_monit_cic_delay  : natural := 1;
  constant c_monit_cic_stages : natural := 1;
  constant c_monit_ratio      : natural := 2049;
  constant c_monit_ratio_full : natural := 2049*c_fofb_ratio_full;

  constant c_cic_fofb_width  : natural := natural(ceil(log2(real(c_fofb_ratio))));
  constant c_cic_monit_width : natural := natural(ceil(log2(real(c_monit_ratio))));
  constant c_cic_tbt1_width  : natural := natural(ceil(log2(real(c_tbt_ratio1))));
  constant c_cic_tbt2_width  : natural := natural(ceil(log2(real(c_tbt_ratio2))));
  constant c_adc_width       : natural := natural(ceil(log2(real(c_adc_ratio))));

  constant c_adc_width_full    : natural := natural(ceil(log2(real(c_adc_ratio_full))));
  constant c_tbt1_width_full   : natural := natural(ceil(log2(real(c_tbt_ratio1_full))));
  constant c_tbt2_width_full   : natural := natural(ceil(log2(real(c_tbt_ratio2_full))));
  constant c_fofb_width_full   : natural := natural(ceil(log2(real(c_fofb_ratio_full))));
  constant c_monit_width_full  : natural := natural(ceil(log2(real(c_monit_ratio_full))));

  constant c_k_width : natural := ksum_i'length;

  constant c_fofb_ratio_slv  : std_logic_vector(c_cic_fofb_width-1 downto 0)  := std_logic_vector(to_unsigned(c_fofb_ratio, c_cic_fofb_width));
  constant c_tbt_ratio1_slv  : std_logic_vector(c_cic_tbt1_width-1 downto 0)  := std_logic_vector(to_unsigned(c_tbt_ratio1, c_cic_tbt1_width));
  constant c_tbt_ratio2_slv  : std_logic_vector(c_cic_tbt2_width-1 downto 0)  := std_logic_vector(to_unsigned(c_tbt_ratio1, c_cic_tbt2_width));
  constant c_monit_ratio_slv : std_logic_vector(c_cic_monit_width-1 downto 0) := std_logic_vector(to_unsigned(c_monit_ratio, c_cic_monit_width));
  constant c_adc_ratio_slv   : std_logic_vector(c_adc_width-1 downto 0)       := std_logic_vector(to_unsigned(c_adc_ratio, c_adc_width));

  constant c_adc_ratio_slv_full   : std_logic_vector(c_adc_width_full-1 downto 0)
      := std_logic_vector(to_unsigned(c_adc_ratio_full, c_adc_width_full));
  constant c_tbt_ratio1_slv_full  : std_logic_vector(c_tbt1_width_full-1 downto 0)
      := std_logic_vector(to_unsigned(c_tbt_ratio1_full, c_tbt1_width_full));
  constant c_tbt_ratio2_slv_full  : std_logic_vector(c_tbt2_width_full-1 downto 0)
      := std_logic_vector(to_unsigned(c_tbt_ratio1_full, c_tbt2_width_full));
  constant c_fofb_ratio_slv_full  : std_logic_vector(c_fofb_width_full-1 downto 0)
      := std_logic_vector(to_unsigned(c_fofb_ratio_full, c_fofb_width_full));
  constant c_monit_ratio_slv_full : std_logic_vector(c_monit_width_full-1 downto 0)
      := std_logic_vector(to_unsigned(c_monit_ratio_full, c_monit_width_full));


  --Cordic
  constant c_cordic_stages : natural := c_decim_width+1;

  -- Actual position calculation
  constant c_output_width : natural := x_fofb_o'length;

  -----------
  --Signals--
  -----------
  type input_slv is array(3 downto 0) of std_logic_vector(c_input_width-1 downto 0);
  signal adc_input : input_slv := (others => (others => '0'));

  type mixed_slv is array(3 downto 0) of std_logic_vector(c_mixed_width-1 downto 0);
  signal full_i, full_q : mixed_slv := (others => (others => '0'));


  -- decimated data
  type decim_data is array(3 downto 0) of std_logic_vector(c_decim_width-1 downto 0);
  signal fofb_i, fofb_q, fofb_mag, fofb_phase : decim_data := (others => (others => '0'));

  signal tbt2_i, tbt2_q, tbt_mag, tbt_phase : decim_data := (others => (others => '0'));

  signal monit_mag : decim_data := (others => (others => '0'));

  type decim_ext is array(3 downto 0) of std_logic_vector(c_decim_width+5 downto 0);
  signal tbt1_i, tbt1_q : decim_ext := (others => (others => '0'));

  --after deltasigma

  signal fofb_x_pre, fofb_y_pre, fofb_q_pre, fofb_sum_pre :
    std_logic_vector(c_decim_width-1 downto 0) := (others => '0');

  signal tbt_x_pre, tbt_y_pre, tbt_q_pre, tbt_sum_pre :
    std_logic_vector(c_decim_width-1 downto 0) := (others => '0');

  signal monit_x_pre, monit_y_pre, monit_q_pre, monit_sum_pre :
    std_logic_vector(c_decim_width-1 downto 0) := (others => '0');


  ----------------------------
  --Clocks and clock enables--
  ----------------------------
  type ce_sl is array(3 downto 0) of std_logic;

  signal valid_tbt1, valid_tbt2, valid_cordic, valid_fofb, valid_monit : ce_sl := (others => '0');
  signal ce_adc, ce_fofb, ce_monit, ce_tbt1, ce_tbt2 : ce_sl := (others => '0');

  attribute max_fanout                                                : string;
  attribute max_fanout of ce_adc, ce_fofb, ce_monit, ce_tbt1, ce_tbt2 : signal is "50";

  component strobe_gen is
    generic (
      g_maxrate   : natural;
      g_bus_width : natural);
    port (
      clock_i  : in  std_logic;
      reset_i  : in  std_logic;
      ce_i     : in  std_logic;
      ratio_i  : in  std_logic_vector(g_bus_width-1 downto 0);
      strobe_o : out std_logic);
  end component strobe_gen;

  component mixer is
    generic (
      g_sin_file         : string;
      g_cos_file         : string;
      g_number_of_points : natural;
      g_phase_bus_size   : natural;
      g_input_width      : natural;
      g_output_width     : natural);
    port (
      reset_i     : in  std_logic;
      clock_i     : in  std_logic;
      ce_i        : in  std_logic;
      signal_i    : in  std_logic_vector(g_input_width-1 downto 0);
      phase_sel_i : in  std_logic_vector(g_phase_bus_size-1 downto 0);
      I_out       : out std_logic_vector(g_output_width-1 downto 0);
      Q_out       : out std_logic_vector(g_output_width-1 downto 0));
  end component mixer;

  component cic_dual is
    generic (
      g_input_width  : natural;
      g_output_width : natural;
      g_stages       : natural;
      g_delay        : natural;
      g_max_rate     : natural;
      g_bus_width    : natural);
    port (
      clock_i : in  std_logic;
      reset_i : in  std_logic;
      ce_i    : in  std_logic;
      valid_i : in  std_logic;
      I_i     : in  std_logic_vector(g_input_width-1 downto 0);
      Q_i     : in  std_logic_vector(g_input_width-1 downto 0);
      ratio_i : in  std_logic_vector(g_bus_width-1 downto 0);
      I_o     : out std_logic_vector(g_output_width-1 downto 0);
      Q_o     : out std_logic_vector(g_output_width-1 downto 0);
      valid_o : out std_logic);
  end component cic_dual;

  component cic_dyn is
    generic (
      g_input_width  : natural;
      g_output_width : natural;
      g_stages       : natural;
      g_delay        : natural;
      g_max_rate     : natural;
      g_bus_width    : natural);
    port (
      clock_i : in  std_logic;
      reset_i : in  std_logic;
      ce_i    : in  std_logic;
      data_i  : in  std_logic_vector(g_input_width-1 downto 0);
      ratio_i : in  std_logic_vector(g_bus_width-1 downto 0);
      data_o  : out std_logic_vector(g_output_width-1 downto 0);
      valid_o : out std_logic);
  end component cic_dyn;

  component cordic_vectoring_slv is
    generic (
      g_stages : natural;
      g_width  : natural);
    port (
      x_i     : in  std_logic_vector(g_width-1 downto 0) := (others => '0');
      y_i     : in  std_logic_vector(g_width-1 downto 0) := (others => '0');
      clk_i   : in  std_logic;
      ce_i    : in  std_logic;
      valid_i : in  std_logic;
      rst_i   : in  std_logic;
      mag_o   : out std_logic_vector(g_width-1 downto 0) := (others => '0');
      phase_o : out std_logic_vector(g_width-1 downto 0) := (others => '0');
      valid_o : out std_logic);
  end component cordic_vectoring_slv;

  component delta_sigma is
    generic (
      g_width   : natural;
      g_k_width : natural);
    port (
      a_i    : in  std_logic_vector(g_width-1 downto 0);
      b_i    : in  std_logic_vector(g_width-1 downto 0);
      c_i    : in  std_logic_vector(g_width-1 downto 0);
      d_i    : in  std_logic_vector(g_width-1 downto 0);
      kx_i   : in  std_logic_vector(g_k_width-1 downto 0);
      ky_i   : in  std_logic_vector(g_k_width-1 downto 0);
      ksum_i : in  std_logic_vector(g_k_width-1 downto 0);
      clk_i  : in  std_logic;
      ce_i   : in  std_logic;
      rst_i  : in  std_logic;
      x_o    : out std_logic_vector(g_width-1 downto 0);
      y_o    : out std_logic_vector(g_width-1 downto 0);
      q_o    : out std_logic_vector(g_width-1 downto 0);
      sum_o  : out std_logic_vector(g_width-1 downto 0));
  end component delta_sigma;

begin

  adc_input(0) <= adc_ch0_i;
  adc_input(1) <= adc_ch1_i;
  adc_input(2) <= adc_ch2_i;
  adc_input(3) <= adc_ch3_i;

  gen_ddc : for chan in 3 downto 0 generate

    -- Generate clock enable
    cmp_ce_adc : strobe_gen
      generic map (
        g_maxrate   => c_adc_ratio_full,
        g_bus_width => c_adc_width_full)
      port map (
        clock_i  => clk,
        reset_i  => '0',
        ce_i     => '1',
        ratio_i  => c_adc_ratio_slv_full,
        strobe_o => ce_adc(chan));

    cmp_ce_tbt1 : strobe_gen
      generic map (
        g_maxrate   => c_tbt_ratio1_full,
        g_bus_width => c_tbt1_width_full)
      port map (
        clock_i  => clk,
        reset_i  => '0',
        ce_i     => '1',
        ratio_i  => c_tbt_ratio1_slv_full,
        strobe_o => ce_tbt1(chan));

    cmp_ce_tbt2 : strobe_gen
      generic map (
        g_maxrate   => c_tbt_ratio2_full,
        g_bus_width => c_tbt2_width_full)
      port map (
        clock_i  => clk,
        reset_i  => '0',
        ce_i     => '1',
        ratio_i  => c_tbt_ratio2_slv_full,
        strobe_o => ce_tbt2(chan));

    cmp_ce_fofb : strobe_gen
      generic map (
        g_maxrate   => c_fofb_ratio_full,
        g_bus_width => c_fofb_width_full)
      port map (
        clock_i  => clk,
        reset_i  => '0',
        ce_i     => '1',
        ratio_i  => c_fofb_ratio_slv_full,
        strobe_o => ce_fofb(chan));

      cmp_ce_monit : strobe_gen
      generic map (
        g_maxrate   => c_monit_ratio_full,
        g_bus_width => c_monit_width_full)
      port map (
        clock_i  => clk,
        reset_i  => '0',
        ce_i     => '1',
        ratio_i  => c_monit_ratio_slv_full,
        strobe_o => ce_monit(chan));

    -- Posistion calculation

    cmp_mixer : mixer
      generic map (
        g_sin_file         => c_sin_file,
        g_cos_file         => c_cos_file,
        g_number_of_points => c_dds_points,
        g_phase_bus_size   => c_phase_width,
        g_input_width      => c_input_width,
        g_output_width     => c_mixed_width)
      port map (
        reset_i     => clr,
        clock_i     => clk,
        ce_i        => ce_adc(chan),
        signal_i    => adc_input(chan),
        phase_sel_i => (others => '0'),
        I_out       => full_i(chan),
        Q_out       => full_q(chan));

    cmp_tbt_cic1 : cic_dual
      generic map (
        g_input_width  => c_mixed_width,
        g_output_width => c_decim_width+6,
        g_stages       => c_tbt_cic1_stages,
        g_delay        => c_tbt_cic1_delay,
        g_max_rate     => c_tbt_ratio1,
        g_bus_width    => c_cic_tbt1_width)
      port map (
        clock_i => clk,
        reset_i => clr,
        ce_i    => ce_adc(chan),
        valid_i => '1',
        I_i     => full_i(chan),
        Q_i     => full_q(chan),
        ratio_i => c_tbt_ratio1_slv,
        I_o     => tbt1_i(chan),
        Q_o     => tbt1_q(chan),
        valid_o => valid_tbt1(chan));

    cmp_tbt_cic2 : cic_dual
      generic map (
        g_input_width  => c_decim_width,
        g_output_width => c_decim_width,
        g_stages       => c_tbt_cic2_stages,
        g_delay        => c_tbt_cic2_delay,
        g_max_rate     => c_tbt_ratio2,
        g_bus_width    => c_cic_tbt2_width)
      port map (
        clock_i => clk,
        reset_i => clr,
        ce_i    => ce_tbt1(chan),
        valid_i => valid_tbt1(chan),
        I_i     => tbt1_i(chan)(c_decim_width downto 1),
        Q_i     => tbt1_q(chan)(c_decim_width downto 1),
        ratio_i => c_tbt_ratio2_slv,
        I_o     => tbt2_i(chan),
        Q_o     => tbt2_q(chan),
        valid_o => valid_tbt2(chan));

    cmp_tbt_cordic : cordic_vectoring_slv
      generic map (
        g_stages => c_cordic_stages,
        g_width  => c_decim_width)
      port map (
        x_i     => tbt2_i(chan),
        y_i     => tbt2_q(chan),
        clk_i   => clk,
        ce_i    => ce_tbt2(chan),
        valid_i => valid_tbt2(chan),
        rst_i   => clr,
        mag_o   => tbt_mag(chan),
        phase_o => tbt_phase(chan),
        valid_o => valid_cordic(chan));

    cmp_fofb_cic : cic_dual
      generic map (
        g_input_width  => c_decim_width,
        g_output_width => c_decim_width,
        g_stages       => c_fofb_cic_stages,
        g_delay        => c_fofb_cic_delay,
        g_max_rate     => c_fofb_ratio,
        g_bus_width    => c_cic_fofb_width)
      port map (
        clock_i => clk,
        reset_i => clr,
        ce_i    => ce_tbt2(chan),
        valid_i => valid_cordic(chan),
        I_i     => tbt_mag(chan),
        Q_i     => tbt_phase(chan),
        ratio_i => c_fofb_ratio_slv,
        I_o     => fofb_mag(chan),
        Q_o     => fofb_phase(chan),
        valid_o => valid_fofb(chan));

    cmp_monit_cic : cic_dyn
      generic map (
        g_input_width  => c_decim_width,
        g_output_width => c_decim_width,
        g_stages       => c_tbt_cic2_stages,
        g_delay        => c_tbt_cic2_delay,
        g_max_rate     => c_monit_ratio,
        g_bus_width    => c_cic_monit_width)
      port map (
        clock_i => clk,
        reset_i => clr,
        ce_i    => ce_fofb(chan),
        data_i  => fofb_mag(chan),
        ratio_i => c_monit_ratio_slv,
        data_o  => monit_mag(chan),
        valid_o => valid_monit(chan));

  end generate gen_ddc;

  cmp_fofb_ds : delta_sigma
    generic map (
      g_width   => c_decim_width,
      g_k_width => c_k_width)
    port map (
      a_i    => fofb_mag(0),
      b_i    => fofb_mag(1),
      c_i    => fofb_mag(2),
      d_i    => fofb_mag(3),
      kx_i   => kx_i,
      ky_i   => ky_i,
      ksum_i => ksum_i,
      clk_i  => clk,
      ce_i   => ce_fofb(0),
      rst_i  => clr,
      x_o    => x_fofb_o,
      y_o    => y_fofb_o,
      q_o    => q_fofb_o,
      sum_o  => sum_fofb_o);

  cmp_monit_ds : delta_sigma
    generic map (
      g_width   => c_decim_width,
      g_k_width => c_k_width)
    port map (
      a_i    => monit_mag(0),
      b_i    => monit_mag(1),
      c_i    => monit_mag(2),
      d_i    => monit_mag(3),
      kx_i   => kx_i,
      ky_i   => ky_i,
      ksum_i => ksum_i,
      clk_i  => clk,
      ce_i   => ce_monit(1),
      rst_i  => clr,
      x_o    => x_monit_o,
      y_o    => y_monit_o,
      q_o    => q_monit_o,
      sum_o  => sum_monit_o);

  cmp_tbt_ds : delta_sigma
    generic map (
      g_width   => c_decim_width,
      g_k_width => c_k_width)
    port map (
      a_i    => tbt_mag(0),
      b_i    => tbt_mag(1),
      c_i    => tbt_mag(2),
      d_i    => tbt_mag(3),
      kx_i   => kx_i,
      ky_i   => ky_i,
      ksum_i => ksum_i,
      clk_i  => clk,
      ce_i   => ce_tbt2(2),
      rst_i  => clr,
      x_o    => x_tbt_o,
      y_o    => y_tbt_o,
      q_o    => q_tbt_o,
      sum_o  => sum_tbt_o);

  -- Wiring intermediate signals to outputs

  mix_ch0_i_o <= full_i(0);
  mix_ch0_q_o <= full_q(0);
  mix_ch1_i_o <= full_i(1);
  mix_ch1_q_o <= full_q(1);
  mix_ch2_i_o <= full_i(2);
  mix_ch2_q_o <= full_q(2);
  mix_ch3_i_o <= full_i(3);
  mix_ch3_q_o <= full_q(3);

  tbt_decim_ch0_i_o <= tbt2_i(0);
  tbt_decim_ch0_q_o <= tbt2_q(0);
  tbt_decim_ch1_i_o <= tbt2_i(1);
  tbt_decim_ch1_q_o <= tbt2_q(1);
  tbt_decim_ch2_i_o <= tbt2_i(2);
  tbt_decim_ch2_q_o <= tbt2_q(2);
  tbt_decim_ch3_i_o <= tbt2_i(3);
  tbt_decim_ch3_q_o <= tbt2_q(3);

  tbt_amp_ch0_o <= tbt_mag(0);
  tbt_amp_ch1_o <= tbt_mag(1);
  tbt_amp_ch2_o <= tbt_mag(2);
  tbt_amp_ch3_o <= tbt_mag(3);

  tbt_pha_ch0_o <= tbt_phase(0);
  tbt_pha_ch1_o <= tbt_phase(1);
  tbt_pha_ch2_o <= tbt_phase(2);
  tbt_pha_ch3_o <= tbt_phase(3);

  fofb_decim_ch0_i_o <= (others => '0');
  fofb_decim_ch0_q_o <= (others => '0');
  fofb_decim_ch1_i_o <= (others => '0');
  fofb_decim_ch1_q_o <= (others => '0');
  fofb_decim_ch2_i_o <= (others => '0');
  fofb_decim_ch2_q_o <= (others => '0');
  fofb_decim_ch3_i_o <= (others => '0');
  fofb_decim_ch3_q_o <= (others => '0');

  fofb_amp_ch0_o <= fofb_mag(0);
  fofb_amp_ch1_o <= fofb_mag(1);
  fofb_amp_ch2_o <= fofb_mag(2);
  fofb_amp_ch3_o <= fofb_mag(3);

  fofb_pha_ch0_o <= fofb_phase(0);
  fofb_pha_ch1_o <= fofb_phase(1);
  fofb_pha_ch2_o <= fofb_phase(2);
  fofb_pha_ch3_o <= fofb_phase(3);

  monit_amp_ch0_o <= monit_mag(0);
  monit_amp_ch1_o <= monit_mag(1);
  monit_amp_ch2_o <= monit_mag(2);
  monit_amp_ch3_o <= monit_mag(3);

  x_tbt_valid_o   <= valid_tbt2(0);
  y_tbt_valid_o   <= valid_tbt2(0);
  q_tbt_valid_o   <= valid_tbt2(0);
  sum_tbt_valid_o <= valid_tbt2(0);

  x_fofb_valid_o   <= valid_fofb(0);
  y_fofb_valid_o   <= valid_fofb(0);
  q_fofb_valid_o   <= valid_fofb(0);
  sum_fofb_valid_o <= valid_fofb(0);

  x_monit_valid_o   <= valid_monit(0);
  y_monit_valid_o   <= valid_monit(0);
  q_monit_valid_o   <= valid_monit(0);
  sum_monit_valid_o <= valid_monit(0);

  clk_ce_tbt_o   <= ce_tbt2(0);
  clk_ce_monit_o <= ce_monit(0);
  clk_ce_fofb_o  <= ce_fofb(0);
  clk_ce_2_o <= ce_adc(0);

  -- Just for Compatibility !!!
  adc_ch0_dbg_data_o <= (others => '0');
  adc_ch1_dbg_data_o <= (others => '0');
  adc_ch2_dbg_data_o <= (others => '0');
  adc_ch3_dbg_data_o <= (others => '0');

  bpf_ch0_o <= (others => '0');
  bpf_ch1_o <= (others => '0');
  bpf_ch2_o <= (others => '0');
  bpf_ch3_o <= (others => '0');

  tbt_decim_q_ch01_incorrect_o <= '0';
  tbt_decim_q_ch23_incorrect_o <= '0';
  fofb_decim_q_01_missing_o <= '0';
  fofb_decim_q_23_missing_o <= '0';
  monit_cic_unexpected_o <= '0';
  monit_cfir_incorrect_o <= '0';
  monit_pfir_incorrect_o <= '0';

end rtl;
