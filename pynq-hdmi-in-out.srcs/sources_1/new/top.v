`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2017 06:50:28 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(/*autoport*/
//inout
         FIXED_IO_mio,
         FIXED_IO_ps_clk,
         FIXED_IO_ps_porb,
         FIXED_IO_ps_srstb,
         hdmi_rx_scl,
         hdmi_rx_sda,
         hdmi_tx_scl,
         hdmi_tx_sda,
//output
         hdmi_rx_hpd,
         hdmi_tx_clk_n,
         hdmi_tx_clk_p,
         hdmi_tx_d_n,
         hdmi_tx_d_p,
         hdmi_tx_hpdn,
         led,
//input
         hdmi_rx_clk_n,
         hdmi_rx_clk_p,
         hdmi_rx_d_n,
         hdmi_rx_d_p,
         sw);

inout [53:0]FIXED_IO_mio;
inout FIXED_IO_ps_clk;
inout FIXED_IO_ps_porb;
inout FIXED_IO_ps_srstb;


input hdmi_rx_clk_n;
input hdmi_rx_clk_p;
input [2:0]hdmi_rx_d_n;
input [2:0]hdmi_rx_d_p;
inout hdmi_rx_scl;
inout hdmi_rx_sda;
output [0:0]hdmi_rx_hpd;

output hdmi_tx_clk_n;
output hdmi_tx_clk_p;
output [2:0]hdmi_tx_d_n;
output [2:0]hdmi_tx_d_p;
inout hdmi_tx_scl;
inout hdmi_tx_sda;
output [0:0]hdmi_tx_hpdn;

output[3:0] led;
input [1:0] sw;

assign hdmi_tx_scl = 1'bz;
assign hdmi_tx_sda = 1'bz;
assign hdmi_rx_hpd = sw[0];

wire[23:0] vid_pData;
wire vid_pVDE, vid_pHSync, vid_pVSync, PixelClk, aPixelClkLckd;
reg[23:0] vid_regData, vid_regData2;
reg vid_regVDE, vid_regHSync, vid_regVSync;
reg vid_regVDE2, vid_regHSync2, vid_regVSync2;
wire aRst, RefClk, FCLK_RESET0_N;

wire RX_DDC_SCL_O, RX_DDC_SCL_I, RX_DDC_SCL_T;
wire RX_DDC_SDA_O, RX_DDC_SDA_I, RX_DDC_SDA_T;

reg [7:0] reset_ctl;
reg pRst;

reg [11:0] lineCnt;
reg last_VSync, last_DE;

assign aRst = ~FCLK_RESET0_N;
assign led[0] = pRst;
assign led[1] = aRst;
assign led[3] = sw[1];

always @(posedge PixelClk or negedge aPixelClkLckd) begin : proc_reset_ctl
    if(~aPixelClkLckd) begin
        reset_ctl <= 0;
        pRst <= 1;
    end else begin
        reset_ctl <= reset_ctl+1;
        if(reset_ctl == 8'h55)
            pRst <= 0;
    end
end

always @(posedge PixelClk) begin
    vid_regVDE <= vid_pVDE;
    vid_regHSync <= vid_pHSync;
    vid_regVSync <= vid_pVSync;
    vid_regData <= (lineCnt==0) ? 24'hff0000 : 
                    lineCnt==719 ? 24'h00ff00 : vid_pData;

    vid_regVDE2 <= vid_regVDE;
    vid_regHSync2 <= vid_regHSync;
    vid_regVSync2 <= vid_regVSync;
    vid_regData2 <= ((~vid_regVDE2 & vid_regVDE)||(vid_regVDE & ~vid_pVDE)) ? 24'hff : vid_regData;
end

always @(posedge PixelClk) begin
    last_VSync <= vid_pVSync;
    last_DE <= vid_pVDE;
    if(last_VSync != vid_pVSync)
        lineCnt <= 0;
    else if(last_DE & ~vid_pVDE)
        lineCnt <= lineCnt+1;
end

led_clkdiv(.clk(PixelClk), .divided(led[2]));

IOBUF hdmi_in_ddc_scl_iobuf
( .I(RX_DDC_SCL_O),
  .IO(hdmi_rx_scl),
  .O(RX_DDC_SCL_I),
  .T(RX_DDC_SCL_T));

IOBUF hdmi_in_ddc_sda_iobuf
( .I(RX_DDC_SDA_O),
  .IO(hdmi_rx_sda),
  .O(RX_DDC_SDA_I),
  .T(RX_DDC_SDA_T));

dvi2rgb_0 hdmi_rx (
  .TMDS_Clk_p(hdmi_rx_clk_p),        // input wire TMDS_Clk_p
  .TMDS_Clk_n(hdmi_rx_clk_n),        // input wire TMDS_Clk_n
  .TMDS_Data_p(hdmi_rx_d_p),      // input wire [2 : 0] TMDS_Data_p
  .TMDS_Data_n(hdmi_rx_d_n),      // input wire [2 : 0] TMDS_Data_n
  .RefClk(RefClk),                // input wire RefClk
  .aRst(aRst),                    // input wire aRst
  .vid_pData(vid_pData),          // output wire [23 : 0] vid_pData
  .vid_pVDE(vid_pVDE),            // output wire vid_pVDE
  .vid_pHSync(vid_pHSync),        // output wire vid_pHSync
  .vid_pVSync(vid_pVSync),        // output wire vid_pVSync
  .PixelClk(PixelClk),            // output wire PixelClk
  .aPixelClkLckd(aPixelClkLckd),  // output wire aPixelClkLckd
  .SDA_I(RX_DDC_SDA_I),          // input wire DDC_SDA_I
  .SDA_O(RX_DDC_SDA_O),          // output wire DDC_SDA_O
  .SDA_T(RX_DDC_SDA_T),          // output wire DDC_SDA_T
  .SCL_I(RX_DDC_SCL_I),          // input wire DDC_SCL_I
  .SCL_O(RX_DDC_SCL_O),          // output wire DDC_SCL_O
  .SCL_T(RX_DDC_SCL_T),          // output wire DDC_SCL_T
  .pRst(pRst)                    // input wire pRst
);

rgb2dvi_0 hdmi_tx (
  .TMDS_Clk_p(hdmi_tx_clk_p),    // output wire TMDS_Clk_p
  .TMDS_Clk_n(hdmi_tx_clk_n),    // output wire TMDS_Clk_n
  .TMDS_Data_p(hdmi_tx_d_p),  // output wire [2 : 0] TMDS_Data_p
  .TMDS_Data_n(hdmi_tx_d_n),  // output wire [2 : 0] TMDS_Data_n
  .aRst(aRst),                // input wire aRst
  .vid_pData(vid_pData),      // input wire [23 : 0] vid_pData
  .vid_pVDE(vid_pVDE),        // input wire vid_pVDE
  .vid_pHSync(vid_pHSync),    // input wire vid_pHSync
  .vid_pVSync(vid_pVSync),    // input wire vid_pVSync
  // .vid_pData(vid_regData2),      // input wire [23 : 0] vid_pData
  // .vid_pVDE(vid_regVDE2),        // input wire vid_pVDE
  // .vid_pHSync(vid_regHSync2),    // input wire vid_pHSync
  // .vid_pVSync(vid_regVSync2),    // input wire vid_pVSync
  .PixelClk(PixelClk)        // input wire PixelClk
);

ps_blk ps_blk_i
   (.FCLK_CLK0(RefClk),
    .FCLK_RESET0_N(FCLK_RESET0_N),
    .FIXED_IO_mio(FIXED_IO_mio),
    .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
    .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
    .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb));

endmodule
