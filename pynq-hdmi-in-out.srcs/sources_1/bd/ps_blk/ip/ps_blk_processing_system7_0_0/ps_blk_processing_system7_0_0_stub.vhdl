-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.1 (lin64) Build 1846317 Fri Apr 14 18:54:47 MDT 2017
-- Date        : Sat Dec 30 00:54:27 2017
-- Host        : nuc6i7 running 64-bit Ubuntu 16.04.3 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/zhang/pynq-hdmi-in-out/pynq-hdmi-in-out.srcs/sources_1/bd/ps_blk/ip/ps_blk_processing_system7_0_0/ps_blk_processing_system7_0_0_stub.vhdl
-- Design      : ps_blk_processing_system7_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ps_blk_processing_system7_0_0 is
  Port ( 
    FCLK_CLK0 : out STD_LOGIC;
    FCLK_RESET0_N : out STD_LOGIC;
    MIO : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    PS_SRSTB : inout STD_LOGIC;
    PS_CLK : inout STD_LOGIC;
    PS_PORB : inout STD_LOGIC
  );

end ps_blk_processing_system7_0_0;

architecture stub of ps_blk_processing_system7_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "FCLK_CLK0,FCLK_RESET0_N,MIO[53:0],PS_SRSTB,PS_CLK,PS_PORB";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "processing_system7_v5_5_processing_system7,Vivado 2017.1";
begin
end;
