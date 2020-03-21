module PE (
  input wire clk,
  input wire rst_n,
  input wire [7:0]in_a,
  input wire [7:0]in_b,
  input wire reset_PE,
  output reg [7:0]out_a,
  output reg [7:0]out_b,
  output reg [7:0]out_c
);
reg [7:0] temp_c;
always @(posedge clk or negedge rst_n)begin 
  if(!rst_n)begin
    out_c  <= 0;
    out_a  <= 0;
    out_b  <= 0;
  end  
  else if(reset_PE) begin
    out_c  <= 0;
    out_a  <= 0;
    out_b  <= 0;
  end
  else begin
      out_c  <= out_c + in_a*in_b;
      out_a  <= in_a;
      out_b  <= in_b;
  end    
end
endmodule


module controller (
  input wire clk,
  input wire rst_n,
  input wire start,
  input wire [7:0] value_a,
  input wire [7:0] value_b,
  output reg [10:0] addr_a,
  output reg [10:0] addr_b,
  output reg en_a,
  output reg en_b,
  output reg [7:0] in_a0,
  output reg [7:0] in_a1,
  output reg [7:0] in_a2,
  output reg [7:0] in_a3,
  output reg [7:0] in_b0,
  output reg [7:0] in_b1,
  output reg [7:0] in_b2,
  output reg [7:0] in_b3,
  output reg reset_PE,
  output reg out_valid
);

  reg [7:0] a [0:15];
  reg [7:0] b [0:15];
  reg [7:0] k;
  reg [7:0] i,i_next;
  reg [7:0] j,j_next;
  reg       [ 3:0] state, state_next;
  parameter [ 3:0] IDLE    = 4'b0000;
  parameter [ 3:0] LOAD    = 4'b0001;
  parameter [ 3:0] CATCH   = 4'b0010;
  parameter [ 3:0] RST_PE  = 4'b0011;
  parameter [ 3:0] stage1  = 4'b0100;
  parameter [ 3:0] stage2  = 4'b0101;
  parameter [ 3:0] stage3  = 4'b0110;
  parameter [ 3:0] stage4  = 4'b0111;
  parameter [ 3:0] stage5  = 4'b1000;
  parameter [ 3:0] stage6  = 4'b1001;
  parameter [ 3:0] stage7  = 4'b1010;
  parameter [ 3:0] stage8  = 4'b1011;
  parameter [ 3:0] stage9  = 4'b1100;
  parameter [ 3:0] stage10 = 4'b1101;
  parameter [ 3:0] stage11 = 4'b1110;
  parameter [ 3:0] OUT     = 4'b1111;


always@ (posedge clk or negedge rst_n) begin
  if(!rst_n)begin
    state <= IDLE;
    en_a <= 0;
    en_b <= 0;
  end  
  else begin
    en_a <= 1;
    en_b <= 1;
    state <= state_next;
    i <= i_next;
    j <= j_next;

    if(state == CATCH) begin
       a[j] <= value_a;
       b[j] <= value_b;
    end

  end
  //$display("state = %d ",state);
end

always@* begin
  case(state)
      IDLE:begin
        if(start)
          state_next = LOAD;
        else
          state_next = IDLE;
      end

      LOAD:begin
          state_next = CATCH;
      end

      CATCH:begin
        if(j!=15)
          state_next = LOAD;
        else
          state_next = RST_PE; 
      end
      
      RST_PE:begin
         state_next = stage1;
      end

      stage1:begin
         state_next = stage2;
      end

      stage2:begin
         state_next = stage3;
      end

      stage3:begin
         state_next = stage4;
      end

      stage4:begin
         state_next = stage5;
      end

      stage5:begin
         state_next = stage6;
      end

      stage6:begin
         state_next = stage7;
      end
      
      stage7:begin
         state_next = stage8;
      end

      stage8:begin
         state_next = stage9;
      end

      stage9:begin
         state_next = stage10;
      end

      stage10:begin
         state_next = stage11;
      end

      stage11:begin
         state_next = OUT;
      end

      OUT :begin

         state_next = LOAD;
      end
  endcase 
end  

always@* begin
  case(state)
      IDLE:begin
       addr_a = 0;
       addr_b = 0;
       out_valid = 0;
       reset_PE = 0;
       i_next=0;
       j_next=0;
      end

      LOAD:begin
       addr_a = {i ,{4{1'b0}}}  + j;
       addr_b = {i ,{4{1'b0}}}  + j;
       out_valid = 0;
       reset_PE = 1;
       i_next=i;
       j_next=j;
      end
      
      CATCH:begin
       addr_a = {i ,{4{1'b0}}}  + j;
       addr_b = {i ,{4{1'b0}}}  + j;
       out_valid = 0;
       reset_PE = 1;
       if(j!=15)begin
         i_next = i;
         j_next = j+1;
       end
       else begin
         i_next = i+1;
         j_next = 0;
       end
      end
      
      RST_PE:begin
         addr_a = 0;
         addr_b = 0;
         out_valid = 0;
         reset_PE = 0;
         i_next=i;
         j_next=0;
      end 

      OUT:begin
         addr_a = 0;
         addr_b = 0;
         out_valid = 1;
         reset_PE = 0;
         i_next=i;
         j_next=0;
      end

      default:begin
         addr_a = 0;
         addr_b = 0;
         out_valid = 0;
         reset_PE = 0;
         i_next=i;
         j_next=0;
      end
  endcase 
end  


always@* begin
  case(state)
      stage1:begin
         in_a0 = a[0];
         in_a1 = 0; 
         in_a2 = 0;
         in_a3 = 0;
         in_b0 = b[0];
         in_b1 = 0;
         in_b2 = 0;
         in_b3 = 0;
      end
      stage2:begin
         in_a0 = a[1];
         in_a1 = a[4]; 
         in_a2 = 0;
         in_a3 = 0;
         in_b0 = b[4];
         in_b1 = b[1];
         in_b2 = 0;
         in_b3 = 0;
      end
      stage3:begin
         in_a0 = a[2];
         in_a1 = a[5]; 
         in_a2 = a[8];
         in_a3 = 0;
         in_b0 = b[8];
         in_b1 = b[5];
         in_b2 = b[2];
         in_b3 = 0;
      end
      stage4:begin
         in_a0 = a[3];
         in_a1 = a[6]; 
         in_a2 = a[9];
         in_a3 = a[12];
         in_b0 = b[12];
         in_b1 = b[9];
         in_b2 = b[6];
         in_b3 = b[3];
      end
      stage5:begin
         in_a0 = 0;
         in_a1 = a[7]; 
         in_a2 = a[10];
         in_a3 = a[13];
         in_b0 = 0;
         in_b1 = b[13];
         in_b2 = b[10];
         in_b3 = b[7];
      end
      stage6:begin
         in_a0 = 0;
         in_a1 = 0; 
         in_a2 = a[11];
         in_a3 = a[14];
         in_b0 = 0;
         in_b1 = 0;
         in_b2 = b[14];
         in_b3 = b[11];
      end
      stage7:begin
         in_a0 = 0;
         in_a1 = 0; 
         in_a2 = 0;
         in_a3 = a[15];
         in_b0 = 0;
         in_b1 = 0;
         in_b2 = 0;
         in_b3 = b[15];
      end
      default : begin
         in_a0 = 0;
         in_a1 = 0; 
         in_a2 = 0;
         in_a3 = 0;
         in_b0 = 0;
         in_b1 = 0;
         in_b2 = 0;
         in_b3 = 0;
      end
  endcase 
end  

endmodule

