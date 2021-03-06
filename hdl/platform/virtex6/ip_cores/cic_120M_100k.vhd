--------------------------------------------------------------------------------
--    This file is owned and controlled by Xilinx and must be used solely     --
--    for design, simulation, implementation and creation of design files     --
--    limited to Xilinx devices or technologies. Use with non-Xilinx          --
--    devices or technologies is expressly prohibited and immediately         --
--    terminates your license.                                                --
--                                                                            --
--    XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY    --
--    FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY    --
--    PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE             --
--    IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS      --
--    MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY      --
--    CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY       --
--    RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY       --
--    DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE   --
--    IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR          --
--    REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF         --
--    INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A   --
--    PARTICULAR PURPOSE.                                                     --
--                                                                            --
--    Xilinx products are not intended for use in life support appliances,    --
--    devices, or systems.  Use in such applications are expressly            --
--    prohibited.                                                             --
--                                                                            --
--    (c) Copyright 1995-2014 Xilinx, Inc.                                    --
--    All rights reserved.                                                    --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- You must compile the wrapper file cic_120M_100k.vhd when simulating
-- the core, cic_120M_100k. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on
ENTITY cic_120M_100k IS
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC
  );
END cic_120M_100k;

ARCHITECTURE cic_120M_100k_a OF cic_120M_100k IS
-- synthesis translate_off
COMPONENT wrapped_cic_120M_100k
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC
  );
END COMPONENT;

-- Configuration specification
  FOR ALL : wrapped_cic_120M_100k USE ENTITY XilinxCoreLib.cic_compiler_v3_0(behavioral)
    GENERIC MAP (
      c_c1 => 37,
      c_c2 => 36,
      c_c3 => 35,
      c_c4 => 35,
      c_c5 => 0,
      c_c6 => 0,
      c_clk_freq => 1,
      c_component_name => "cic_120M_100k",
      c_diff_delay => 1,
      c_family => "virtex6",
      c_filter_type => 1,
      c_has_aclken => 0,
      c_has_aresetn => 0,
      c_has_dout_tready => 0,
      c_has_rounding => 0,
      c_i1 => 64,
      c_i2 => 59,
      c_i3 => 50,
      c_i4 => 41,
      c_i5 => 0,
      c_i6 => 0,
      c_input_width => 24,
      c_m_axis_data_tdata_width => 32,
      c_m_axis_data_tuser_width => 1,
      c_max_rate => 1000,
      c_min_rate => 1000,
      c_num_channels => 1,
      c_num_stages => 4,
      c_output_width => 32,
      c_rate => 1000,
      c_rate_type => 0,
      c_s_axis_config_tdata_width => 1,
      c_s_axis_data_tdata_width => 24,
      c_sample_freq => 1,
      c_use_dsp => 1,
      c_use_streaming_interface => 1,
      c_xdevicefamily => "virtex6"
    );
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_cic_120M_100k
  PORT MAP (
    aclk => aclk,
    s_axis_data_tdata => s_axis_data_tdata,
    s_axis_data_tvalid => s_axis_data_tvalid,
    s_axis_data_tready => s_axis_data_tready,
    m_axis_data_tdata => m_axis_data_tdata,
    m_axis_data_tvalid => m_axis_data_tvalid
  );
-- synthesis translate_on

END cic_120M_100k_a;
