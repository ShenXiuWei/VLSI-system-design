module stimulus;
  parameter cyc = 10;
  parameter delay = 1;

  reg clk, rst_n, start;
  reg [7:0] a, b;
  wire done, error;
  wire [7:0] y;
   
  GCD gcd01(
    .CLK(clk),
    .RST_N(rst_n),
    .A(a),
    .B(b),
    .START(start),
    .Y(y),
    .DONE(done),
    .ERROR(error)
  );
  
  always #(cyc/2) clk = ~clk;

  initial begin
    `ifdef SYNTHESIS
        $sdf_annotate("hw02.sdf", gcd01);
        $fsdbDumpfile("hw02_syn.fsdb");
    `else
        $fsdbDumpfile("hw02.fsdb");
    `endif   
    $fsdbDumpvars;
    $monitor($time, " CLK=%b RST_N=%b START=%b A=%d B=%d | DONE=%b Y=%d ERROR=%b",
      clk, rst_n, start, a, b, done, y, error);
	  
	#(cyc * 100000) $display("wrong")  ;
	$finish;
  end

  initial begin
    clk = 1;
    rst_n = 1;
    start = 0;
    #(cyc)nop ;
    #(delay) rst_n = 0;
    #(cyc*4) rst_n = 1;
    #(cyc*2);

    
    
  	
	#(cyc) load; 
      data_in1(16'd50000, 16'd48000); 
  	#(cyc)data_in2(16'd50000, 16'd48000);
    #(cyc) nop;
    @(posedge done);
	

    #(delay)
	#(cyc)
	  #(cyc) load; 
  	 data_in1(16'd7777, 16'd48000); 
  	#(cyc)data_in2(16'd7777, 16'd48000);
    #(cyc) nop;
    @(posedge done);
	
    
	#(delay)
	#(cyc)
	  #(cyc) load; 
    data_in1(16'd50000, 16'd7777); 
  	#(cyc)data_in2(16'd50000, 16'd7777);
    #(cyc) nop;
    @(posedge done);
	
    #(delay)
	#(cyc)
	  #(cyc) load; 
  	data_in1(16'd50000, 16'd0); 
  	#(cyc)data_in2(16'd50000, 16'd0);
    #(cyc) nop;
    @(posedge done);
	
    #(delay)
	#(cyc)
	  #(cyc) load; 
  	data_in1(16'd0, 16'd48000); 
  	#(cyc)data_in2(16'd0, 16'd48000);
    #(cyc) nop;
    @(posedge done);
	
	#(delay)
    #(cyc)
	#(cyc) load; 
  	data_in1(16'd0, 16'd0); 
  	#(cyc)data_in2(16'd0, 16'd0);
    #(cyc) nop;
    @(posedge done);
	
	
	

	

	
// [HW] apply more patterns to cover
// different conditions

    #(cyc) nop;
    #(cyc*2);
    $finish;
  end

  // take a careful look at 
  // the usage of task here
  task nop;
    begin
      start = 0;
    end
  endtask
  task load;
    begin
      start = 1;
    end
  endtask
  task data_in1;
    input [15:0] data1, data2;
    begin
      a = data1[15:8];
      b = data2[15:8];
    end
  endtask
  task data_in2;
    input [15:0] data1, data2;
    begin
      a = data1[7:0];
      b = data2[7:0];
    end
  endtask
endmodule

