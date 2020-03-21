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
  reg [1:0]  load;
  reg [15:0] reg_a, reg_b, reg_a_next, reg_b_next;
  reg [15:0] diff, data_a, data_b;
  reg error_next;
  reg [2:0] state, state_next;

  parameter [2:0] IDLE    = 3'b000;
  parameter [2:0] LOAD    = 3'b001;
  parameter [2:0] CHECK   = 3'b010;
  parameter [2:0] CALC    = 3'b011;
  parameter [2:0] FINISH  = 3'b100;
  parameter [2:0] FINISH2 = 3'b101;
  

  always@(posedge CLK or negedge RST_N)begin
   if(!RST_N)begin 
    state <= IDLE;
    ERROR <= 0;
    reg_a <= 0;
    reg_b <= 0; 
   end
   else begin
    if(state == CALC) begin
       reg_a <= diff;
       reg_b <= data_b;
    end
	else begin
	   reg_a <= reg_a_next;
	   reg_b <= reg_b_next;
	end   
	state <= state_next;
	ERROR <= error_next;
   end
  end
  
  always@*begin
     case(state)
		IDLE:begin
		  DONE = 0;
		 if(!START) begin 
		  state_next = IDLE;
		 end
		 else begin 
		  state_next = LOAD;
		 end
		end
		LOAD:begin
		  state_next = CHECK;
		end
		CHECK:begin
		  state_next = CALC;
		end
		CALC:begin
		 if(!found && !ERROR)begin
		  state_next = CALC;
		 end
		 else begin
		  state_next = FINISH;  
		 end
		end
		FINISH:begin
		 state_next = FINISH2;
		 DONE = 1'b1;
		end
		FINISH2:begin
		 state_next = IDLE;
		 DONE = 1'b1; 
		end
		default:begin
		 state_next = IDLE;
		 DONE = 0;
		end
	endcase
  end  
  
  always@*begin
     case(state)
		IDLE:begin
		  error_next = 0;
		end
		LOAD:begin
		  error_next = 0;
		end
		CHECK:begin
		  error_next = {reg_a == 0 || reg_b == 0};
		end
		CALC:begin
		   error_next = ERROR;
		end
		FINISH:begin
		   error_next = ERROR;
		end
		FINISH2:begin
		   error_next = ERROR;
		end   
		default:begin
		   error_next = 0;
		end
	endcase
  end  
  
  always@*begin
  case(state)
		IDLE:begin
           Y = 8'dx;
		   if(START)begin
			reg_a_next = {A,8'd0};
			reg_b_next = {B,8'd0};
		   end		   
		end
		LOAD:begin
		    reg_a_next[7:0] = A;
		    reg_b_next[7:0] = B;
		end
		CHECK:begin
		    reg_a_next = reg_a;
		    reg_b_next = reg_b;
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
		   end
		end
		FINISH:begin
		   if(ERROR) Y = 8'dx;
		   else Y = data_a[15:8];
		end
		FINISH2:begin
		   if(ERROR) Y = 8'dx;
		   else Y = data_a[7:0];
		end
		default:begin
		   reg_a_next = 16'd0;
		   reg_b_next = 16'd0;
		   data_b     = 16'd0;
		   data_a     = 16'd0;
		   diff       = 16'd0;
		   Y          = 8'd0;
		end
	endcase
  end
  
  always @* begin
	swap  = (reg_b > reg_a)?1:0;
    found = (reg_a == reg_b)?1:0;	
  end
endmodule
