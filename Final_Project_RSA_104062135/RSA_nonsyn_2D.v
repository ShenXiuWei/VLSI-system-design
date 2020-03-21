module sram_I_256x32(
  input clk,
  input en,
  input [7:0] addr,
  output [31:0] data
);
 
  reg [31:0] ram [0:255];
  reg [31:0] rand;
  reg [ 7:0] read_addr;
  integer file_r, file_w, cnt, i, j, seed;

  initial begin 
    seed = 0; 
    file_w = $fopen("data_input.txt", "w");
      for(i = 0; i < 64 ; i = i + 1) begin
           $fwrite (file_w,"%b\n",{$random(seed)});
      end
    $fclose(file_w);

    file_r = $fopen("data_input.txt", "r");
      for(i=0; i<64; i = i+1) begin   //random data
         cnt = $fscanf(file_r, "%b\n",ram[i]);
        $write("B[%d] : %11d\n",i,ram[i]);
      end 
    $fclose(file_r);

    file_r = $fopen("key2_D.txt", "r");
      for(i=64; i<128; i=i+1) begin       //read D-key or E-key
         cnt = $fscanf(file_r, "%b\n",ram[i]);
         // $display("ram[%d] = %b \n",i,ram[i]);
      end 
      for(i=128; i<192; i=i+1) begin     //read N
         cnt = $fscanf(file_r, "%b\n",ram[i]);
         // $display("ram[%d] = %b \n",i,ram[i]);
      end 
    $fclose(file_r);
  end
 
  always @(posedge clk) begin
    if (en) begin
      read_addr <= addr;
    end
  end
  assign data = ram[read_addr];
endmodule
