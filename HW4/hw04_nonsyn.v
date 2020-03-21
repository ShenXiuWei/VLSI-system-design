module sram_A_2048x8 (
  input clk,
  input en,
  input [10:0] addr,
  output [7:0] q
);
 
  reg [7:0] ram [0:2047];
  reg [10:0] read_addr;
  integer file_r,cnt,i ;

  initial begin
    file_r = $fopen("input_A.txt", "r");
    for (i=0; i<2048; i=i+1) begin
      cnt = $fscanf(file_r, "%d   ", ram[i]);
    end 
    $fclose(file_r);
  end
 
  always @(posedge clk) begin
    if (en) begin
      read_addr <= addr;
    end
  end
  assign q = ram[read_addr];
endmodule

module sram_B_2048x8 (
  input clk,
  input en,
  input [10:0] addr,
  output [7:0] q
);
  
  reg [7:0] ram [0:2047];
  reg [10:0] read_addr;
  integer file_r,cnt,i ;

  initial begin
    file_r = $fopen("input_B.txt", "r");
    for (i=0; i<2048; i=i+1) begin
      cnt = $fscanf(file_r, "%d   ", ram[i]);
    end 
    $fclose(file_r);
  end
 
  always @(posedge clk) begin
    if (en) begin
      read_addr <= addr;
    end
  end
  assign q = ram[read_addr];
endmodule

module sram_C_2048x8 (
  input clk,
  input en,
  input [10:0] addr,
  input finish,
  output [7:0] q
);
 
  reg [7:0] ram [0:2047];
  reg [10:0] read_addr;
  integer file_r,cnt,i ;
  always @(posedge clk) begin
    if(finish == 1) begin
      file_r = $fopen("output_c.txt", "r");
      for (i=0; i<2048; i=i+1) begin
        cnt = $fscanf(file_r, "%d   ", ram[i]);
        //$display("addr = %d  value = %d", i,ram[i]);
      end 
      $fclose(file_r);
    end
  end
  always @(posedge clk) begin
    if (en) begin
      read_addr <= addr;
    end
  end
  assign q = ram[read_addr];
endmodule