module led_clkdiv (
    input wire clk,    // Clock
    output wire divided
);

parameter CNT_BITS = 25;

reg [CNT_BITS-1:0] cnt;

assign divided = cnt[CNT_BITS-1];

always @(posedge clk) begin : proc_cnt
    cnt <= cnt + 1'b1;
end


endmodule