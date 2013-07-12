---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for BPM Swap Channels Interface Registers
---------------------------------------------------------------------------------------
-- File           : wb_bpm_swap_regs.vhd
-- Author         : auto-generated by wbgen2 from xbpm_swap.wb
-- Created        : Thu Jul 11 09:34:46 2013
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE xbpm_swap.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.bpm_swap_wbgen2_pkg.all;


entity wb_bpm_swap_regs is
  port (
    rst_n_i                                  : in     std_logic;
    clk_sys_i                                : in     std_logic;
    wb_adr_i                                 : in     std_logic_vector(2 downto 0);
    wb_dat_i                                 : in     std_logic_vector(31 downto 0);
    wb_dat_o                                 : out    std_logic_vector(31 downto 0);
    wb_cyc_i                                 : in     std_logic;
    wb_sel_i                                 : in     std_logic_vector(3 downto 0);
    wb_stb_i                                 : in     std_logic;
    wb_we_i                                  : in     std_logic;
    wb_ack_o                                 : out    std_logic;
    wb_stall_o                               : out    std_logic;
    fs_clk_i                                 : in     std_logic;
    regs_i                                   : in     t_bpm_swap_in_registers;
    regs_o                                   : out    t_bpm_swap_out_registers
  );
end wb_bpm_swap_regs;

architecture syn of wb_bpm_swap_regs is

signal bpm_swap_ctrl_rst_int                    : std_logic      ;
signal bpm_swap_ctrl_mode1_int                  : std_logic_vector(1 downto 0);
signal bpm_swap_ctrl_mode1_swb                  : std_logic      ;
signal bpm_swap_ctrl_mode1_swb_delay            : std_logic      ;
signal bpm_swap_ctrl_mode1_swb_s0               : std_logic      ;
signal bpm_swap_ctrl_mode1_swb_s1               : std_logic      ;
signal bpm_swap_ctrl_mode1_swb_s2               : std_logic      ;
signal bpm_swap_ctrl_mode2_int                  : std_logic_vector(1 downto 0);
signal bpm_swap_ctrl_mode2_swb                  : std_logic      ;
signal bpm_swap_ctrl_mode2_swb_delay            : std_logic      ;
signal bpm_swap_ctrl_mode2_swb_s0               : std_logic      ;
signal bpm_swap_ctrl_mode2_swb_s1               : std_logic      ;
signal bpm_swap_ctrl_mode2_swb_s2               : std_logic      ;
signal bpm_swap_ctrl_swap_div_f_int             : std_logic_vector(15 downto 0);
signal bpm_swap_ctrl_swap_div_f_swb             : std_logic      ;
signal bpm_swap_ctrl_swap_div_f_swb_delay       : std_logic      ;
signal bpm_swap_ctrl_swap_div_f_swb_s0          : std_logic      ;
signal bpm_swap_ctrl_swap_div_f_swb_s1          : std_logic      ;
signal bpm_swap_ctrl_swap_div_f_swb_s2          : std_logic      ;
signal bpm_swap_dly_1_int                       : std_logic_vector(15 downto 0);
signal bpm_swap_dly_1_swb                       : std_logic      ;
signal bpm_swap_dly_1_swb_delay                 : std_logic      ;
signal bpm_swap_dly_1_swb_s0                    : std_logic      ;
signal bpm_swap_dly_1_swb_s1                    : std_logic      ;
signal bpm_swap_dly_1_swb_s2                    : std_logic      ;
signal bpm_swap_dly_2_int                       : std_logic_vector(15 downto 0);
signal bpm_swap_dly_2_swb                       : std_logic      ;
signal bpm_swap_dly_2_swb_delay                 : std_logic      ;
signal bpm_swap_dly_2_swb_s0                    : std_logic      ;
signal bpm_swap_dly_2_swb_s1                    : std_logic      ;
signal bpm_swap_dly_2_swb_s2                    : std_logic      ;
signal bpm_swap_a_a_int                         : std_logic_vector(9 downto 0);
signal bpm_swap_a_a_swb                         : std_logic      ;
signal bpm_swap_a_a_swb_delay                   : std_logic      ;
signal bpm_swap_a_a_swb_s0                      : std_logic      ;
signal bpm_swap_a_a_swb_s1                      : std_logic      ;
signal bpm_swap_a_a_swb_s2                      : std_logic      ;
signal bpm_swap_a_c_int                         : std_logic_vector(9 downto 0);
signal bpm_swap_a_c_swb                         : std_logic      ;
signal bpm_swap_a_c_swb_delay                   : std_logic      ;
signal bpm_swap_a_c_swb_s0                      : std_logic      ;
signal bpm_swap_a_c_swb_s1                      : std_logic      ;
signal bpm_swap_a_c_swb_s2                      : std_logic      ;
signal bpm_swap_b_b_int                         : std_logic_vector(9 downto 0);
signal bpm_swap_b_b_swb                         : std_logic      ;
signal bpm_swap_b_b_swb_delay                   : std_logic      ;
signal bpm_swap_b_b_swb_s0                      : std_logic      ;
signal bpm_swap_b_b_swb_s1                      : std_logic      ;
signal bpm_swap_b_b_swb_s2                      : std_logic      ;
signal bpm_swap_b_d_int                         : std_logic_vector(9 downto 0);
signal bpm_swap_b_d_swb                         : std_logic      ;
signal bpm_swap_b_d_swb_delay                   : std_logic      ;
signal bpm_swap_b_d_swb_s0                      : std_logic      ;
signal bpm_swap_b_d_swb_s1                      : std_logic      ;
signal bpm_swap_b_d_swb_s2                      : std_logic      ;
signal bpm_swap_c_c_int                         : std_logic_vector(9 downto 0);
signal bpm_swap_c_c_swb                         : std_logic      ;
signal bpm_swap_c_c_swb_delay                   : std_logic      ;
signal bpm_swap_c_c_swb_s0                      : std_logic      ;
signal bpm_swap_c_c_swb_s1                      : std_logic      ;
signal bpm_swap_c_c_swb_s2                      : std_logic      ;
signal bpm_swap_c_a_int                         : std_logic_vector(9 downto 0);
signal bpm_swap_c_a_swb                         : std_logic      ;
signal bpm_swap_c_a_swb_delay                   : std_logic      ;
signal bpm_swap_c_a_swb_s0                      : std_logic      ;
signal bpm_swap_c_a_swb_s1                      : std_logic      ;
signal bpm_swap_c_a_swb_s2                      : std_logic      ;
signal bpm_swap_d_d_int                         : std_logic_vector(9 downto 0);
signal bpm_swap_d_d_swb                         : std_logic      ;
signal bpm_swap_d_d_swb_delay                   : std_logic      ;
signal bpm_swap_d_d_swb_s0                      : std_logic      ;
signal bpm_swap_d_d_swb_s1                      : std_logic      ;
signal bpm_swap_d_d_swb_s2                      : std_logic      ;
signal bpm_swap_d_b_int                         : std_logic_vector(9 downto 0);
signal bpm_swap_d_b_swb                         : std_logic      ;
signal bpm_swap_d_b_swb_delay                   : std_logic      ;
signal bpm_swap_d_b_swb_s0                      : std_logic      ;
signal bpm_swap_d_b_swb_s1                      : std_logic      ;
signal bpm_swap_d_b_swb_s2                      : std_logic      ;
signal ack_sreg                                 : std_logic_vector(9 downto 0);
signal rddata_reg                               : std_logic_vector(31 downto 0);
signal wrdata_reg                               : std_logic_vector(31 downto 0);
signal bwsel_reg                                : std_logic_vector(3 downto 0);
signal rwaddr_reg                               : std_logic_vector(2 downto 0);
signal ack_in_progress                          : std_logic      ;
signal wr_int                                   : std_logic      ;
signal rd_int                                   : std_logic      ;
signal allones                                  : std_logic_vector(31 downto 0);
signal allzeros                                 : std_logic_vector(31 downto 0);

begin
-- Some internal signals assignments. For (foreseen) compatibility with other bus standards.
  wrdata_reg <= wb_dat_i;
  bwsel_reg <= wb_sel_i;
  rd_int <= wb_cyc_i and (wb_stb_i and (not wb_we_i));
  wr_int <= wb_cyc_i and (wb_stb_i and wb_we_i);
  allones <= (others => '1');
  allzeros <= (others => '0');
-- 
-- Main register bank access process.
  process (clk_sys_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      ack_sreg <= "0000000000";
      ack_in_progress <= '0';
      rddata_reg <= "00000000000000000000000000000000";
      bpm_swap_ctrl_rst_int <= '0';
      bpm_swap_ctrl_mode1_int <= "00";
      bpm_swap_ctrl_mode1_swb <= '0';
      bpm_swap_ctrl_mode1_swb_delay <= '0';
      bpm_swap_ctrl_mode2_int <= "00";
      bpm_swap_ctrl_mode2_swb <= '0';
      bpm_swap_ctrl_mode2_swb_delay <= '0';
      bpm_swap_ctrl_swap_div_f_int <= "0000000000000000";
      bpm_swap_ctrl_swap_div_f_swb <= '0';
      bpm_swap_ctrl_swap_div_f_swb_delay <= '0';
      bpm_swap_dly_1_int <= "0000000000000000";
      bpm_swap_dly_1_swb <= '0';
      bpm_swap_dly_1_swb_delay <= '0';
      bpm_swap_dly_2_int <= "0000000000000000";
      bpm_swap_dly_2_swb <= '0';
      bpm_swap_dly_2_swb_delay <= '0';
      bpm_swap_a_a_int <= "0000000000";
      bpm_swap_a_a_swb <= '0';
      bpm_swap_a_a_swb_delay <= '0';
      bpm_swap_a_c_int <= "0000000000";
      bpm_swap_a_c_swb <= '0';
      bpm_swap_a_c_swb_delay <= '0';
      bpm_swap_b_b_int <= "0000000000";
      bpm_swap_b_b_swb <= '0';
      bpm_swap_b_b_swb_delay <= '0';
      bpm_swap_b_d_int <= "0000000000";
      bpm_swap_b_d_swb <= '0';
      bpm_swap_b_d_swb_delay <= '0';
      bpm_swap_c_c_int <= "0000000000";
      bpm_swap_c_c_swb <= '0';
      bpm_swap_c_c_swb_delay <= '0';
      bpm_swap_c_a_int <= "0000000000";
      bpm_swap_c_a_swb <= '0';
      bpm_swap_c_a_swb_delay <= '0';
      bpm_swap_d_d_int <= "0000000000";
      bpm_swap_d_d_swb <= '0';
      bpm_swap_d_d_swb_delay <= '0';
      bpm_swap_d_b_int <= "0000000000";
      bpm_swap_d_b_swb <= '0';
      bpm_swap_d_b_swb_delay <= '0';
    elsif rising_edge(clk_sys_i) then
-- advance the ACK generator shift register
      ack_sreg(8 downto 0) <= ack_sreg(9 downto 1);
      ack_sreg(9) <= '0';
      if (ack_in_progress = '1') then
        if (ack_sreg(0) = '1') then
          ack_in_progress <= '0';
        else
          bpm_swap_ctrl_mode1_swb <= bpm_swap_ctrl_mode1_swb_delay;
          bpm_swap_ctrl_mode1_swb_delay <= '0';
          bpm_swap_ctrl_mode2_swb <= bpm_swap_ctrl_mode2_swb_delay;
          bpm_swap_ctrl_mode2_swb_delay <= '0';
          bpm_swap_ctrl_swap_div_f_swb <= bpm_swap_ctrl_swap_div_f_swb_delay;
          bpm_swap_ctrl_swap_div_f_swb_delay <= '0';
          bpm_swap_dly_1_swb <= bpm_swap_dly_1_swb_delay;
          bpm_swap_dly_1_swb_delay <= '0';
          bpm_swap_dly_2_swb <= bpm_swap_dly_2_swb_delay;
          bpm_swap_dly_2_swb_delay <= '0';
          bpm_swap_a_a_swb <= bpm_swap_a_a_swb_delay;
          bpm_swap_a_a_swb_delay <= '0';
          bpm_swap_a_c_swb <= bpm_swap_a_c_swb_delay;
          bpm_swap_a_c_swb_delay <= '0';
          bpm_swap_b_b_swb <= bpm_swap_b_b_swb_delay;
          bpm_swap_b_b_swb_delay <= '0';
          bpm_swap_b_d_swb <= bpm_swap_b_d_swb_delay;
          bpm_swap_b_d_swb_delay <= '0';
          bpm_swap_c_c_swb <= bpm_swap_c_c_swb_delay;
          bpm_swap_c_c_swb_delay <= '0';
          bpm_swap_c_a_swb <= bpm_swap_c_a_swb_delay;
          bpm_swap_c_a_swb_delay <= '0';
          bpm_swap_d_d_swb <= bpm_swap_d_d_swb_delay;
          bpm_swap_d_d_swb_delay <= '0';
          bpm_swap_d_b_swb <= bpm_swap_d_b_swb_delay;
          bpm_swap_d_b_swb_delay <= '0';
        end if;
      else
        if ((wb_cyc_i = '1') and (wb_stb_i = '1')) then
          case rwaddr_reg(2 downto 0) is
          when "000" => 
            if (wb_we_i = '1') then
              bpm_swap_ctrl_rst_int <= wrdata_reg(0);
              bpm_swap_ctrl_mode1_int <= wrdata_reg(2 downto 1);
              bpm_swap_ctrl_mode1_swb <= '1';
              bpm_swap_ctrl_mode1_swb_delay <= '1';
              bpm_swap_ctrl_mode2_int <= wrdata_reg(4 downto 3);
              bpm_swap_ctrl_mode2_swb <= '1';
              bpm_swap_ctrl_mode2_swb_delay <= '1';
              bpm_swap_ctrl_swap_div_f_int <= wrdata_reg(23 downto 8);
              bpm_swap_ctrl_swap_div_f_swb <= '1';
              bpm_swap_ctrl_swap_div_f_swb_delay <= '1';
            end if;
            rddata_reg(0) <= bpm_swap_ctrl_rst_int;
            rddata_reg(2 downto 1) <= bpm_swap_ctrl_mode1_int;
            rddata_reg(4 downto 3) <= bpm_swap_ctrl_mode2_int;
            rddata_reg(23 downto 8) <= bpm_swap_ctrl_swap_div_f_int;
            rddata_reg(5) <= 'X';
            rddata_reg(6) <= 'X';
            rddata_reg(7) <= 'X';
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "001" => 
            if (wb_we_i = '1') then
              bpm_swap_dly_1_int <= wrdata_reg(15 downto 0);
              bpm_swap_dly_1_swb <= '1';
              bpm_swap_dly_1_swb_delay <= '1';
              bpm_swap_dly_2_int <= wrdata_reg(31 downto 16);
              bpm_swap_dly_2_swb <= '1';
              bpm_swap_dly_2_swb_delay <= '1';
            end if;
            rddata_reg(15 downto 0) <= bpm_swap_dly_1_int;
            rddata_reg(31 downto 16) <= bpm_swap_dly_2_int;
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "010" => 
            if (wb_we_i = '1') then
              bpm_swap_a_a_int <= wrdata_reg(9 downto 0);
              bpm_swap_a_a_swb <= '1';
              bpm_swap_a_a_swb_delay <= '1';
              bpm_swap_a_c_int <= wrdata_reg(25 downto 16);
              bpm_swap_a_c_swb <= '1';
              bpm_swap_a_c_swb_delay <= '1';
            end if;
            rddata_reg(9 downto 0) <= bpm_swap_a_a_int;
            rddata_reg(25 downto 16) <= bpm_swap_a_c_int;
            rddata_reg(10) <= 'X';
            rddata_reg(11) <= 'X';
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "011" => 
            if (wb_we_i = '1') then
              bpm_swap_b_b_int <= wrdata_reg(9 downto 0);
              bpm_swap_b_b_swb <= '1';
              bpm_swap_b_b_swb_delay <= '1';
              bpm_swap_b_d_int <= wrdata_reg(25 downto 16);
              bpm_swap_b_d_swb <= '1';
              bpm_swap_b_d_swb_delay <= '1';
            end if;
            rddata_reg(9 downto 0) <= bpm_swap_b_b_int;
            rddata_reg(25 downto 16) <= bpm_swap_b_d_int;
            rddata_reg(10) <= 'X';
            rddata_reg(11) <= 'X';
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "100" => 
            if (wb_we_i = '1') then
              bpm_swap_c_c_int <= wrdata_reg(9 downto 0);
              bpm_swap_c_c_swb <= '1';
              bpm_swap_c_c_swb_delay <= '1';
              bpm_swap_c_a_int <= wrdata_reg(25 downto 16);
              bpm_swap_c_a_swb <= '1';
              bpm_swap_c_a_swb_delay <= '1';
            end if;
            rddata_reg(9 downto 0) <= bpm_swap_c_c_int;
            rddata_reg(25 downto 16) <= bpm_swap_c_a_int;
            rddata_reg(10) <= 'X';
            rddata_reg(11) <= 'X';
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "101" => 
            if (wb_we_i = '1') then
              bpm_swap_d_d_int <= wrdata_reg(9 downto 0);
              bpm_swap_d_d_swb <= '1';
              bpm_swap_d_d_swb_delay <= '1';
              bpm_swap_d_b_int <= wrdata_reg(25 downto 16);
              bpm_swap_d_b_swb <= '1';
              bpm_swap_d_b_swb_delay <= '1';
            end if;
            rddata_reg(9 downto 0) <= bpm_swap_d_d_int;
            rddata_reg(25 downto 16) <= bpm_swap_d_b_int;
            rddata_reg(10) <= 'X';
            rddata_reg(11) <= 'X';
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(3) <= '1';
            ack_in_progress <= '1';
          when "110" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(31 downto 0) <= regs_i.dummy_i;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when others =>
-- prevent the slave from hanging the bus on invalid address
            ack_in_progress <= '1';
            ack_sreg(0) <= '1';
          end case;
        end if;
      end if;
    end if;
  end process;
  
  
-- Drive the data output bus
  wb_dat_o <= rddata_reg;
-- Reset
  regs_o.ctrl_rst_o <= bpm_swap_ctrl_rst_int;
-- Mode Input 1
-- asynchronous std_logic_vector register : Mode Input 1 (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_ctrl_mode1_swb_s0 <= '0';
      bpm_swap_ctrl_mode1_swb_s1 <= '0';
      bpm_swap_ctrl_mode1_swb_s2 <= '0';
      regs_o.ctrl_mode1_o <= "00";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_ctrl_mode1_swb_s0 <= bpm_swap_ctrl_mode1_swb;
      bpm_swap_ctrl_mode1_swb_s1 <= bpm_swap_ctrl_mode1_swb_s0;
      bpm_swap_ctrl_mode1_swb_s2 <= bpm_swap_ctrl_mode1_swb_s1;
      if ((bpm_swap_ctrl_mode1_swb_s2 = '0') and (bpm_swap_ctrl_mode1_swb_s1 = '1')) then
        regs_o.ctrl_mode1_o <= bpm_swap_ctrl_mode1_int;
      end if;
    end if;
  end process;
  
  
-- Mode Input 2
-- asynchronous std_logic_vector register : Mode Input 2 (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_ctrl_mode2_swb_s0 <= '0';
      bpm_swap_ctrl_mode2_swb_s1 <= '0';
      bpm_swap_ctrl_mode2_swb_s2 <= '0';
      regs_o.ctrl_mode2_o <= "00";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_ctrl_mode2_swb_s0 <= bpm_swap_ctrl_mode2_swb;
      bpm_swap_ctrl_mode2_swb_s1 <= bpm_swap_ctrl_mode2_swb_s0;
      bpm_swap_ctrl_mode2_swb_s2 <= bpm_swap_ctrl_mode2_swb_s1;
      if ((bpm_swap_ctrl_mode2_swb_s2 = '0') and (bpm_swap_ctrl_mode2_swb_s1 = '1')) then
        regs_o.ctrl_mode2_o <= bpm_swap_ctrl_mode2_int;
      end if;
    end if;
  end process;
  
  
-- Swap Divisor
-- asynchronous std_logic_vector register : Swap Divisor (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_ctrl_swap_div_f_swb_s0 <= '0';
      bpm_swap_ctrl_swap_div_f_swb_s1 <= '0';
      bpm_swap_ctrl_swap_div_f_swb_s2 <= '0';
      regs_o.ctrl_swap_div_f_o <= "0000000000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_ctrl_swap_div_f_swb_s0 <= bpm_swap_ctrl_swap_div_f_swb;
      bpm_swap_ctrl_swap_div_f_swb_s1 <= bpm_swap_ctrl_swap_div_f_swb_s0;
      bpm_swap_ctrl_swap_div_f_swb_s2 <= bpm_swap_ctrl_swap_div_f_swb_s1;
      if ((bpm_swap_ctrl_swap_div_f_swb_s2 = '0') and (bpm_swap_ctrl_swap_div_f_swb_s1 = '1')) then
        regs_o.ctrl_swap_div_f_o <= bpm_swap_ctrl_swap_div_f_int;
      end if;
    end if;
  end process;
  
  
-- Delay1
-- asynchronous std_logic_vector register : Delay1 (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_dly_1_swb_s0 <= '0';
      bpm_swap_dly_1_swb_s1 <= '0';
      bpm_swap_dly_1_swb_s2 <= '0';
      regs_o.dly_1_o <= "0000000000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_dly_1_swb_s0 <= bpm_swap_dly_1_swb;
      bpm_swap_dly_1_swb_s1 <= bpm_swap_dly_1_swb_s0;
      bpm_swap_dly_1_swb_s2 <= bpm_swap_dly_1_swb_s1;
      if ((bpm_swap_dly_1_swb_s2 = '0') and (bpm_swap_dly_1_swb_s1 = '1')) then
        regs_o.dly_1_o <= bpm_swap_dly_1_int;
      end if;
    end if;
  end process;
  
  
-- Delay2
-- asynchronous std_logic_vector register : Delay2 (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_dly_2_swb_s0 <= '0';
      bpm_swap_dly_2_swb_s1 <= '0';
      bpm_swap_dly_2_swb_s2 <= '0';
      regs_o.dly_2_o <= "0000000000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_dly_2_swb_s0 <= bpm_swap_dly_2_swb;
      bpm_swap_dly_2_swb_s1 <= bpm_swap_dly_2_swb_s0;
      bpm_swap_dly_2_swb_s2 <= bpm_swap_dly_2_swb_s1;
      if ((bpm_swap_dly_2_swb_s2 = '0') and (bpm_swap_dly_2_swb_s1 = '1')) then
        regs_o.dly_2_o <= bpm_swap_dly_2_int;
      end if;
    end if;
  end process;
  
  
-- Signal A by Channel A
-- asynchronous std_logic_vector register : Signal A by Channel A (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_a_a_swb_s0 <= '0';
      bpm_swap_a_a_swb_s1 <= '0';
      bpm_swap_a_a_swb_s2 <= '0';
      regs_o.a_a_o <= "0000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_a_a_swb_s0 <= bpm_swap_a_a_swb;
      bpm_swap_a_a_swb_s1 <= bpm_swap_a_a_swb_s0;
      bpm_swap_a_a_swb_s2 <= bpm_swap_a_a_swb_s1;
      if ((bpm_swap_a_a_swb_s2 = '0') and (bpm_swap_a_a_swb_s1 = '1')) then
        regs_o.a_a_o <= bpm_swap_a_a_int;
      end if;
    end if;
  end process;
  
  
-- Signal A by Channel C
-- asynchronous std_logic_vector register : Signal A by Channel C (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_a_c_swb_s0 <= '0';
      bpm_swap_a_c_swb_s1 <= '0';
      bpm_swap_a_c_swb_s2 <= '0';
      regs_o.a_c_o <= "0000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_a_c_swb_s0 <= bpm_swap_a_c_swb;
      bpm_swap_a_c_swb_s1 <= bpm_swap_a_c_swb_s0;
      bpm_swap_a_c_swb_s2 <= bpm_swap_a_c_swb_s1;
      if ((bpm_swap_a_c_swb_s2 = '0') and (bpm_swap_a_c_swb_s1 = '1')) then
        regs_o.a_c_o <= bpm_swap_a_c_int;
      end if;
    end if;
  end process;
  
  
-- Signal B by Channel B
-- asynchronous std_logic_vector register : Signal B by Channel B (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_b_b_swb_s0 <= '0';
      bpm_swap_b_b_swb_s1 <= '0';
      bpm_swap_b_b_swb_s2 <= '0';
      regs_o.b_b_o <= "0000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_b_b_swb_s0 <= bpm_swap_b_b_swb;
      bpm_swap_b_b_swb_s1 <= bpm_swap_b_b_swb_s0;
      bpm_swap_b_b_swb_s2 <= bpm_swap_b_b_swb_s1;
      if ((bpm_swap_b_b_swb_s2 = '0') and (bpm_swap_b_b_swb_s1 = '1')) then
        regs_o.b_b_o <= bpm_swap_b_b_int;
      end if;
    end if;
  end process;
  
  
-- Signal B by Channel D
-- asynchronous std_logic_vector register : Signal B by Channel D (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_b_d_swb_s0 <= '0';
      bpm_swap_b_d_swb_s1 <= '0';
      bpm_swap_b_d_swb_s2 <= '0';
      regs_o.b_d_o <= "0000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_b_d_swb_s0 <= bpm_swap_b_d_swb;
      bpm_swap_b_d_swb_s1 <= bpm_swap_b_d_swb_s0;
      bpm_swap_b_d_swb_s2 <= bpm_swap_b_d_swb_s1;
      if ((bpm_swap_b_d_swb_s2 = '0') and (bpm_swap_b_d_swb_s1 = '1')) then
        regs_o.b_d_o <= bpm_swap_b_d_int;
      end if;
    end if;
  end process;
  
  
-- Signal C by Channel C
-- asynchronous std_logic_vector register : Signal C by Channel C (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_c_c_swb_s0 <= '0';
      bpm_swap_c_c_swb_s1 <= '0';
      bpm_swap_c_c_swb_s2 <= '0';
      regs_o.c_c_o <= "0000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_c_c_swb_s0 <= bpm_swap_c_c_swb;
      bpm_swap_c_c_swb_s1 <= bpm_swap_c_c_swb_s0;
      bpm_swap_c_c_swb_s2 <= bpm_swap_c_c_swb_s1;
      if ((bpm_swap_c_c_swb_s2 = '0') and (bpm_swap_c_c_swb_s1 = '1')) then
        regs_o.c_c_o <= bpm_swap_c_c_int;
      end if;
    end if;
  end process;
  
  
-- Signal C by Channel A
-- asynchronous std_logic_vector register : Signal C by Channel A (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_c_a_swb_s0 <= '0';
      bpm_swap_c_a_swb_s1 <= '0';
      bpm_swap_c_a_swb_s2 <= '0';
      regs_o.c_a_o <= "0000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_c_a_swb_s0 <= bpm_swap_c_a_swb;
      bpm_swap_c_a_swb_s1 <= bpm_swap_c_a_swb_s0;
      bpm_swap_c_a_swb_s2 <= bpm_swap_c_a_swb_s1;
      if ((bpm_swap_c_a_swb_s2 = '0') and (bpm_swap_c_a_swb_s1 = '1')) then
        regs_o.c_a_o <= bpm_swap_c_a_int;
      end if;
    end if;
  end process;
  
  
-- Signal D by Channel D
-- asynchronous std_logic_vector register : Signal D by Channel D (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_d_d_swb_s0 <= '0';
      bpm_swap_d_d_swb_s1 <= '0';
      bpm_swap_d_d_swb_s2 <= '0';
      regs_o.d_d_o <= "0000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_d_d_swb_s0 <= bpm_swap_d_d_swb;
      bpm_swap_d_d_swb_s1 <= bpm_swap_d_d_swb_s0;
      bpm_swap_d_d_swb_s2 <= bpm_swap_d_d_swb_s1;
      if ((bpm_swap_d_d_swb_s2 = '0') and (bpm_swap_d_d_swb_s1 = '1')) then
        regs_o.d_d_o <= bpm_swap_d_d_int;
      end if;
    end if;
  end process;
  
  
-- Signal D by Channel B
-- asynchronous std_logic_vector register : Signal D by Channel B (type RW/RO, fs_clk_i <-> clk_sys_i)
  process (fs_clk_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      bpm_swap_d_b_swb_s0 <= '0';
      bpm_swap_d_b_swb_s1 <= '0';
      bpm_swap_d_b_swb_s2 <= '0';
      regs_o.d_b_o <= "0000000000";
    elsif rising_edge(fs_clk_i) then
      bpm_swap_d_b_swb_s0 <= bpm_swap_d_b_swb;
      bpm_swap_d_b_swb_s1 <= bpm_swap_d_b_swb_s0;
      bpm_swap_d_b_swb_s2 <= bpm_swap_d_b_swb_s1;
      if ((bpm_swap_d_b_swb_s2 = '0') and (bpm_swap_d_b_swb_s1 = '1')) then
        regs_o.d_b_o <= bpm_swap_d_b_int;
      end if;
    end if;
  end process;
  
  
-- Dummy
  rwaddr_reg <= wb_adr_i;
  wb_stall_o <= (not ack_sreg(0)) and (wb_stb_i and wb_cyc_i);
-- ACK signal generation. Just pass the LSB of ACK counter.
  wb_ack_o <= ack_sreg(0);
end syn;
