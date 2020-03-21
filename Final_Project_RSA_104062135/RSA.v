module MM(
  input wire clk,
  input wire rst_n,
  input wire [2047:0] in_temp_key,
  input wire [31:0] in_text,
  input wire [31:0] in_answer,
  input wire [2047:0] in_N,
  output reg [2047:0] MM_temp_key,
  output reg [31:0] MM_text,
  output reg [31:0] MM_answer
);
always@ (posedge clk or negedge rst_n) begin
  if(in_temp_key % 2 == 0) begin
    MM_text <= in_text ** 2 % in_N;
    MM_answer <= in_answer;
    MM_temp_key <= in_temp_key/2;
  end
  else begin
    MM_text   <= in_text;
    MM_answer <= in_answer * in_text % in_N;
    MM_temp_key <= in_temp_key-1;
  end
end
endmodule

module SBPRSA (
  input wire clk,
  input wire rst_n,
  input wire exe,
  input wire mode,
  input wire wen,
  input wire [31:0]data,
  input wire [2047:0] MM_temp_key,
  input wire [31:0] MM_text,
  input wire [31:0] MM_answer,
  output reg en,
  output reg [7:0] addr,
  output reg [31:0]result,
  output reg [1:0]status,
  output reg o_en,
  output reg [2047:0] in_temp_key,
  output reg [31:0] in_text,
  output reg [31:0] in_answer,
  output reg [2047:0] in_N
);

  reg       [ 3:0] state, state_next;
  parameter [ 3:0] IDLE       = 4'b0000;
  parameter [ 3:0] LOAD_KEY   = 4'b0001;
  parameter [ 3:0] CATCH_KEY  = 4'b0010;
  parameter [ 3:0] GET_KEY    = 4'b0011;
  parameter [ 3:0] LOAD_DATA  = 4'b0100;
  parameter [ 3:0] CATCH_DATA = 4'b0101;
  parameter [ 3:0] CALC       = 4'b0110;
  parameter [ 3:0] CALC2      = 4'b1010;
  parameter [ 3:0] OUT        = 4'b0111;
  parameter [ 3:0] OUT2       = 4'b1000;
  parameter [ 3:0] FINISH     = 4'b1001;
  integer idx;
  reg [7:0] i,i_next;
  reg [31:0] kkk,kkk_next;
  reg [31:0] nnn,nnn_next;
  reg [31:0] text,text_next; 
  reg [31:0] answer,answer_next;
  reg [2047:0] key,key_next;
  reg [2047:0] temp_key,temp_key_next;
  reg [2047:0] N,N_next; 
always@ (posedge clk or negedge rst_n) begin
  if(!rst_n)begin
    state <= IDLE;
    en    <= 1'b0;
  end  
  else begin
    state <= state_next;
    en    <= 1'b1;
    i     <= i_next;
    key   <= key_next;
    N     <= N_next;
    kkk   <= kkk_next; 
    nnn   <= nnn_next;
    text   <= text_next;
    answer <= answer_next;
    temp_key <= temp_key_next;
  end
  // $display("state = %d ",state);
  // $display("status = %b ",status);
end

always@* begin
  case(state)
      IDLE:begin
        if(exe)
          state_next = LOAD_KEY;
        else
          state_next = IDLE;
      end

      LOAD_KEY:begin
          state_next = CATCH_KEY;
      end

      CATCH_KEY:begin
          state_next = GET_KEY;
      end

      GET_KEY:begin
        if(i != 191)
            state_next = LOAD_KEY;
        else  
            state_next = LOAD_DATA;
      end

      LOAD_DATA:begin
          state_next = CATCH_DATA;
      end

      CATCH_DATA:begin
          state_next = CALC;
      end

      CALC:begin
          state_next = CALC2;
      end

      CALC2:begin
        if(mode == 1'b0 && temp_key > 0)
          state_next = CALC;
        else 
          state_next = OUT;  
      end


      OUT :begin
          state_next = OUT2;
      end   
      OUT2:begin
        if(i<64)
          state_next = LOAD_DATA;
        else
          state_next = FINISH;     
      end
      FINISH:begin
          state_next = FINISH;
      end
      default:begin
        state_next = IDLE;
      end
  endcase 
end  

always@* begin
  case(state)
      IDLE:begin
        status   = 2'b00;
        addr     = 8'd0;
        i_next   = 8'd64;
        key_next = 2048'd0;
        temp_key_next = 2048'd0;
        N_next   = 2048'd0;
        o_en     = 1'b0;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        text_next = 32'd0;
        answer_next = 32'd1;
        result   = 32'd0;

        in_text = 32'd0;
        in_N    = 64'd0;
        in_answer = 32'd0;
        in_temp_key = 32'd0;
      end
      LOAD_KEY:begin
        status   = 2'b01;
        addr     =  i;
        i_next   =  i; 
        key_next = key;
        temp_key_next = 2048'd0;
        N_next   = N;
        o_en     = 1'b0;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        text_next = 32'd0;
        answer_next = 32'd1;   
        result   = 32'd0;

        in_text = 32'd0;
        in_N    = 2048'd0;
        in_answer = 32'd0;
        in_temp_key = 2048'd0;               
      end
      CATCH_KEY:begin
        status   = 2'b01;
        addr     = i;
        i_next   = i;
        key_next = key;
        temp_key_next = 2048'd0;
        N_next   = N;
        o_en     = 1'b0;
        text_next = 32'd0;
        answer_next = 32'd1;
        result   = 32'd0;

        if(i>=64 && i<128)  begin
          kkk_next = data; 
          nnn_next = 32'd0;
        end 
        else begin
          kkk_next = 32'd0;
          nnn_next = data;
        end  

        in_text = 32'd0;
        in_N    = 2048'd0;
        in_answer = 32'd0;
        in_temp_key = 2048'd0;
        //$display("i : %d  data : %b",i,data); 
      end
      GET_KEY:begin
        status   = 2'b01;
        addr     = i;
        o_en     = 1'b0;
        kkk_next = kkk;
        temp_key_next = 2048'd0;
        nnn_next = nnn;
        text_next = 32'd0;
        answer_next = 32'd1;
        result   = 32'd0;  

        if(i != 191)
          i_next = i + 8'd1;
        else
          i_next = 8'd0;

        if(i>=64 && i<128)  begin
          key_next = key + kkk<<((127-i)<<5); 
          N_next   = N;
        end  
        else begin
          key_next = key;
          N_next   = N   + nnn<<((191-i)<<5); 
        end  

        in_text = 32'd0;
        in_N    = 2048'd0;
        in_answer = 32'd0;
        in_temp_key = 2048'd0;
      end
      LOAD_DATA:begin
        status   = 2'b01;
        addr     = i;
        i_next   = i;
        key_next = key;
        temp_key_next = key;
        N_next   = N;
        o_en     = 1'b0;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        text_next = 32'd0;
        answer_next = 32'd1;
        result   = 32'd0;

        in_text = 32'd0;
        in_N    = 2048'd0;
        in_answer = 32'd0;
        in_temp_key = 2048'd0;

        // if(i == 0)
        // $display("%d\n",key);
        // if(i == 0)
        // $display("%d\n",N);  
      end
      CATCH_DATA:begin
        status   = 2'b01;
        addr     = i;
        i_next   = i;
        key_next = key;
        temp_key_next = key;
        N_next   = N;
        o_en     = 1'b0;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        text_next = data ;
        answer_next = 32'd1;
        result   = 32'd0;

        in_text = 32'd0;
        in_N    = 2048'd0;
        in_answer = 32'd0;
        in_temp_key = 2048'd0;
      end
      CALC:begin
        status   = 2'b01;
        addr     = i;
        i_next   = i;
        key_next = key;
        N_next   = N;
        o_en     = 1'b0;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        result   = 32'd0;

        in_text = text;
        in_N    = N;
        in_answer = answer;
        in_temp_key = temp_key;
        text_next = text;
        answer_next = answer;
        temp_key_next = temp_key;
      end
      CALC2:begin
        status   = 2'b01;
        addr     = i;
        i_next   = i;
        key_next = key;
        N_next   = N;
        o_en     = 1'b0;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        result   = 32'd0;

        in_text = text;
        in_N    = N;
        in_answer = answer;
        in_temp_key = temp_key;
        text_next = MM_text;
        answer_next = MM_answer;
        temp_key_next = MM_temp_key;
      end
      OUT:begin
        status   = 2'b01;
        addr     = i;
        i_next   = i;
        key_next = key;
        temp_key_next = key;
        N_next   = N;
        o_en     = 1'b1;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        text_next = 32'd0;
        answer_next = answer;
        result   = answer;
        // $display("before = %d\n",text);
        // $display("after  = %d\n",answer);
        
        in_text = 32'd0;
        in_N    = 2048'd0;
        in_answer = 32'd0;
        in_temp_key = 2048'd0;
      end
      OUT2:begin
        status   = 2'b01; 
        addr     = i;
        i_next   = i+8'd1;
        key_next = key;
        temp_key_next = key;
        N_next   = N;
        o_en     = 1'b0;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        text_next = 32'd0;
        answer_next   = answer;
        result   = 32'd0;
        
        in_text = 32'd0;
        in_N    = 2048'd0;
        in_answer = 32'd0;
        in_temp_key = 2048'd0;
      end
      FINISH:begin
        status   = 2'b11;
        addr     = 8'd0;
        i_next   = 8'd64;
        key_next = 2048'd0;
        temp_key_next = 2048'd0;
        N_next   = 2048'd0;
        o_en     = 1'b0;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        text_next = 32'd0;
        answer_next = 32'd1;
        result   = 32'd0;

        in_text = 32'd0;
        in_N    = 2048'd0;
        in_answer = 32'd0;
        in_temp_key = 2048'd0;
      end
      default:begin
        status   = 2'b00;
        addr     = 8'd0;
        i_next   = 8'd64;
        key_next = 2048'd0;
        temp_key_next = 2048'd0;
        N_next   = 2048'd0;
        o_en     = 1'b0;
        kkk_next = 32'd0;
        nnn_next = 32'd0;
        text_next = 32'd0;
        answer_next = 32'd1;
        result   = 32'd0;

        in_text = 32'd0;
        in_N    = 2048'd0;
        in_answer = 32'd0;
        in_temp_key = 2048'd0;
      end
  endcase 
end   

endmodule


