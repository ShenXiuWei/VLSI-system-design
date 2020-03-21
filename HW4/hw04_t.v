// Change the filename when necessary
`timescale 1ns/1ps
`define FSDB_FILE      "hw04.fsdb"

module testbench(
  output reg clk,
  output reg rst_n,
  output reg start,
  output reg finish,
  input wire [7:0]out_c0,
  input wire [7:0]out_c1,
  input wire [7:0]out_c2,
  input wire [7:0]out_c3,
  input wire [7:0]out_c4,
  input wire [7:0]out_c5,
  input wire [7:0]out_c6,
  input wire [7:0]out_c7,
  input wire [7:0]out_c8,
  input wire [7:0]out_c9,
  input wire [7:0]out_c10,
  input wire [7:0]out_c11,
  input wire [7:0]out_c12,
  input wire [7:0]out_c13,
  input wire [7:0]out_c14,
  input wire [7:0]out_c15,
  input wire out_valid
);
  parameter period = 10;
  parameter delay = 1;
  integer file_w;
  integer i;

  initial begin
    `ifdef SYNTHESIS
        $sdf_annotate("hw04.sdf",top);
        $fsdbDumpfile("hw04_syn.fsdb");
    `else
        $fsdbDumpfile("hw04.fsdb");
    `endif    
    $fsdbDumpvars;
  end


  
  // create the clock
  always #(period/2) clk = ~clk;

  // test patterns
  initial begin
    clk = 0;
    rst_n = 1;
    start = 0;
    #(delay) rst_n = 0;
    #(period) rst_n = 1;
    #(period) start = 1;

    file_w = $fopen("output_c.txt", "w");
     for(i = 0; i < 128 ; i = i + 1) begin
        @(posedge out_valid) @(posedge clk)
         $fwrite (file_w,"%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",out_c0,out_c1,out_c2,out_c3,out_c4,out_c5,out_c6,out_c7,out_c8,out_c9,out_c10,out_c11,out_c12,out_c13,out_c14,out_c15);
         $display("output%3d    %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d ",i,out_c0,out_c1,out_c2,out_c3,out_c4,out_c5,out_c6,out_c7,out_c8,out_c9,out_c10,out_c11,out_c12,out_c13,out_c14,out_c15);
     end
    $fclose(file_w);
    finish = 1;
    #(delay)
    finish = 0;
    // delay 100 more cycles
    #(period*100)

    $finish;
    
    $display($time);
    // enjoy the Verilog coding
  end
endmodule
