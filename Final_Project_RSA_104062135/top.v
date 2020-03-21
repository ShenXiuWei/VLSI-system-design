module top;
  wire clk;
  wire rst_n;
  wire exe;
  wire mode;
  wire wen;
  wire [31:0] input_data;
  wire en;
  wire [7:0] addr;
  wire [31:0]result;
  wire [1:0]status;
  wire o_en;
  wire [2047:0] MM_temp_key;
  wire [31:0] MM_text;
  wire [31:0] MM_answer;
  wire [2047:0] in_temp_key;
  wire [31:0] in_text;
  wire [31:0] in_answer;
  wire [2047:0] in_N;


  initial begin
    `ifdef SYNTHESIS
        $sdf_annotate("RSA_syn.sdf",sbprsa);
    `endif
  end

  testbench t
  ( 
    .o_en(o_en),
    .result(result),
    .clk(clk),
    .rst_n(rst_n),
    .exe(exe),
    .mode(mode)
  );

  sram_I_256x32 sram_i
  (
    .clk(clk),
    .en(en),
    .addr(addr),
    .data(input_data)
  );

  SBPRSA sbprsa
  (
    .clk(clk),
    .rst_n(rst_n),
    .exe(exe),
    .mode(mode),
    .wen(wen),
    .data(input_data),
    .en(en),
    .addr(addr),
    .result(result),
    .status(status),
    .o_en(o_en),
    .MM_temp_key(MM_temp_key),
    .MM_text(MM_text),
    .MM_answer(MM_answer),
    .in_temp_key(in_temp_key),
    .in_text(in_text),
    .in_answer(in_answer),
    .in_N(in_N)
  );

  MM mm
  (
    .clk(clk),
    .rst_n(rst_n),
    .MM_temp_key(MM_temp_key),
    .MM_text(MM_text),
    .MM_answer(MM_answer),
    .in_temp_key(in_temp_key),
    .in_text(in_text),
    .in_answer(in_answer),
    .in_N(in_N)
  );

endmodule