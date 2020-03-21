// Change the filename when necessary
`timescale 1ns/1ps
`define FSDB_FILE      "RSA.fsdb"

module testbench
( 
  input  wire o_en,
  input  wire [31:0]result,
  output reg clk,
  output reg rst_n,
  output reg exe,
  output reg mode

);
  parameter period = 10;
  parameter delay = 1;
  integer file_w;
  integer i;

  initial begin
    `ifdef SYNTHESIS
        $sdf_annotate("RSA.sdf",sbprsa);
        $fsdbDumpfile("RSA_syn.fsdb");
    `else
        $fsdbDumpfile("RSA.fsdb");
    `endif    
    $fsdbDumpvars;
  end


  
  // create the clock
  always #(period/2) clk = ~clk;

  // test patterns
  initial begin
    clk = 0;
    rst_n = 1;
    exe = 0;
    #(delay)  rst_n = 0;
    #(period) rst_n = 1;
    #(period) exe   = 1;
    #(period) mode  = 0;
    file_w = $fopen("data_output.txt", "w");
    $write("\n==================================================AFTER=============================================\n");
     for(i = 0; i < 64 ; i = i + 1) begin
        @(posedge o_en) @(posedge clk) begin
         $fwrite (file_w,"%b\n",result);
         $write("A[%d] : %11d\n",i,result);
        end
     end
    $fclose(file_w);
    $write("\n");
    // delay 100 more cycles
    #(period*100)

    $finish;
    
    $display($time);
    // enjoy the Verilog coding
  end
endmodule
