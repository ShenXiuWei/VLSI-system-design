module GCD(
  input wire CLK,
  input wire RST_N,
  input wire [7:0] A,
  input wire [7:0] B,
  input wire START,
  output reg [7:0] Y,
  output reg DONE,
  output reg ERROR
);

  reg found, swap;
  reg [7:0] reg_a, reg_b, data_a, data_b;
  reg [7:0] diff;
  reg error_next;
  reg [1:0] state, state_next;

  parameter [1:0] IDLE = 2'b00;
  parameter [1:0] CALC = 2'b01;
  parameter [1:0] FINISH = 2'b10;
  
  always@(posedge CLK or negedge RST_N)begin
   if(!RST_N)begin 
    state <= IDLE;
    ERROR <= 0;
    reg_a <= 0;
    reg_b <= 0; 
   end
   else begin
    state <= state_next;
	ERROR <= error_next;
    if(START)begin
     reg_a = A;
     reg_b = B;
	 Y = 8'bx;
    end
    else begin
     reg_a <= diff;
     reg_b <= data_b;
    end
   end
  end
 
  always@*begin 
   state_next = IDLE;
   DONE = 0;  
    case(state)
    IDLE:begin
     if(!START) begin 
      state_next = IDLE;
      error_next = 0;
     end
     else begin 
      state_next = CALC;
      error_next = (A==0||B==0);
     end
    end
    CALC:begin
     if(!found && !ERROR)begin
	  if(swap)begin
	  data_a = reg_b;
      data_b = reg_a;
      end 
	  else begin
      data_a = reg_a;
      data_b = reg_b;
      end
 	  diff = data_a - data_b;
	  state_next = CALC;
      error_next = ERROR;
     end
     else if(found || ERROR)begin
      state_next = FINISH;
      error_next = ERROR;   
     end
    end
    FINISH:begin
	 state_next = IDLE;
     error_next = 1'b0;
	 if(ERROR) Y = 8'bx;
	 else if(found && !ERROR) Y = data_a;
	 DONE = 1'b1; 
    end
	endcase
   end

   always @* begin
    swap  = (reg_b > reg_a)?1:0;
    found = (reg_a == reg_b)?1:0;
   end
endmodule
