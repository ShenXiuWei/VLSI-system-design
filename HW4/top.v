module top;
  wire clk;
  wire rst_n;
  wire start;
  wire [10:0] addr_a;
  wire en_a;
  wire out_valid_a;
  wire [7:0] q_a;

  wire [10:0] addr_b;
  wire en_b;
  wire out_valid_b;
  wire [7:0] q_b;

  wire finish;
  wire [7:0] in_a0,in_a1,in_a2,in_a3;
  wire [7:0] in_b0,in_b1,in_b2,in_b3;
  wire [7:0] out_c[0:15];
  wire [7:0] a0_1,a1_2,a2_3 ,a4_5,a5_6,a6_7 ,a8_9,a9_10,a10_11,a12_13,a13_14,a14_15;
  wire [7:0] b0_4,b4_8,b8_12,b1_5,b5_9,b9_13,b2_6,b6_10,b10_14,b3_7  ,b7_11 ,b11_15;
  wire [7:0] x0,x1,x2,x3,x4,x5,x6,x7;
  wire out_valid;
  wire reset_PE;

  initial begin
    `ifdef SYNTHESIS
        $sdf_annotate("hw04_syn.sdf",ctrl);
    `endif
  end

  
  testbench t(
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .finish(finish),
    .out_c0(out_c[0]),
    .out_c1(out_c[1]),
    .out_c2(out_c[2]),
    .out_c3(out_c[3]),
    .out_c4(out_c[4]),
    .out_c5(out_c[5]),
    .out_c6(out_c[6]),
    .out_c7(out_c[7]),
    .out_c8(out_c[8]),
    .out_c9(out_c[9]),
    .out_c10(out_c[10]),
    .out_c11(out_c[11]),
    .out_c12(out_c[12]),
    .out_c13(out_c[13]),
    .out_c14(out_c[14]),
    .out_c15(out_c[15]),
    .out_valid(out_valid)
  );

  sram_A_2048x8 sram_A (
    .clk(clk),
    .en(en_a),
    .addr(addr_a),
    .q(q_a)
  );

  sram_B_2048x8 sram_B (
    .clk(clk),
    .en(en_b),
    .addr(addr_b),
    .q(q_b)
  );

  sram_C_2048x8 sram_C (
    .clk(clk),
    .en(),
    .addr(),
    .finish(finish),
    .q()
  );
  
  PE pe0 (clk,rst_n,in_a0 ,in_b0 ,reset_PE ,a0_1  ,b0_4  ,out_c[0]);
  PE pe1 (clk,rst_n,a0_1  ,in_b1 ,reset_PE ,a1_2  ,b1_5  ,out_c[1]);
  PE pe2 (clk,rst_n,a1_2  ,in_b2 ,reset_PE ,a2_3  ,b2_6  ,out_c[2]);
  PE pe3 (clk,rst_n,a2_3  ,in_b3 ,reset_PE ,x0    ,b3_7  ,out_c[3]);
  PE pe4 (clk,rst_n,in_a1 ,b0_4  ,reset_PE ,a4_5  ,b4_8  ,out_c[4]);
  PE pe5 (clk,rst_n,a4_5  ,b1_5  ,reset_PE ,a5_6  ,b5_9  ,out_c[5]);
  PE pe6 (clk,rst_n,a5_6  ,b2_6  ,reset_PE ,a6_7  ,b6_10 ,out_c[6]);
  PE pe7 (clk,rst_n,a6_7  ,b3_7  ,reset_PE ,x1    ,b7_11 ,out_c[7]);
  PE pe8 (clk,rst_n,in_a2 ,b4_8  ,reset_PE ,a8_9  ,b8_12 ,out_c[8]);
  PE pe9 (clk,rst_n,a8_9  ,b5_9  ,reset_PE ,a9_10 ,b9_13 ,out_c[9]);
  PE pe10(clk,rst_n,a9_10 ,b6_10 ,reset_PE ,a10_11,b10_14,out_c[10]);
  PE pe11(clk,rst_n,a10_11,b7_11 ,reset_PE ,x2    ,b11_15,out_c[11]);
  PE pe12(clk,rst_n,in_a3 ,b8_12 ,reset_PE ,a12_13,x4    ,out_c[12]);
  PE pe13(clk,rst_n,a12_13,b9_13 ,reset_PE ,a13_14,x5    ,out_c[13]);
  PE pe14(clk,rst_n,a13_14,b10_14,reset_PE ,a14_15,x6    ,out_c[14]);
  PE pe15(clk,rst_n,a14_15,b11_15,reset_PE ,x3    ,x7    ,out_c[15]);

  controller ctrl(
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .value_a(q_a),
    .value_b(q_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .en_a(en_a),
    .en_b(en_b),
    .in_a0(in_a0),
    .in_a1(in_a1),
    .in_a2(in_a2),
    .in_a3(in_a3),
    .in_b0(in_b0),
    .in_b1(in_b1),
    .in_b2(in_b2),
    .in_b3(in_b3),
    .reset_PE(reset_PE),
    .out_valid(out_valid)
  );

endmodule