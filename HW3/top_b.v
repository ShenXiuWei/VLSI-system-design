module top;
  wire clk;
  wire rst_n;
  wire start;
  wire [15:0] addra;
  wire [15:0] addrb;
  wire wen;
  wire en;
  wire out_valid;
  wire [7:0] d;
  wire [7:0] qa;
  wire [7:0] qb;
  wire signed [7:0] fc;
  wire [7:0] out_pixel;
  
  initial begin
    `ifdef SYNTHESIS
        $sdf_annotate("hw03b_syn.sdf",filt);
    `endif
  end

  load_bmp testbench (
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .fc_valid(fc_valid),
    .fc(fc),
    .out_pixel(out_pixel),
    .out_valid(out_valid)
  );

  sram65536x8 sram_a(
    .clk(clk),
    .wen(wen),
    .en(en),
    .addr(addra),
    .d(d),
    .q(qa)
  );
  
  sram65536x8 sram_b (
    .clk(clk),
    .wen(wen),
    .en(en),
    .addr(addrb),
    .d(d),
    .q(qb)
  );

  filter filt (
    .clk(clk),
    .rst_n(rst_n),
    .fc_valid(fc_valid),
    .working_pixel_a(qa),
    .working_pixel_b(qb),
    .wen(wen),
    .en(en),
    .fc(fc),
    .out_pixel(out_pixel),
    .out_valid(out_valid),
    .d(d),
    .addra(addra),
    .addrb(addrb),
    .start(start)
  );

endmodule
