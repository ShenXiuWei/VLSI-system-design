module filter (
  input wire clk,
  input wire rst_n,
  input wire fc_valid,
  input wire [7:0] working_pixel,
  input signed [7:0] fc,
  input wire start,
  output reg [7:0] out_pixel,
  output reg out_valid,
  output reg [15:0] addr,
  output reg wen,
  output reg en,
  output reg [7:0] d
);


reg signed[ 8:0] filter_coef [0:4][0:4];
reg       [ 3:0] coef_i,coef_i_next;
reg       [ 3:0] coef_j,coef_j_next;

reg signed[ 8:0] value [0:25];
reg       [ 7:0] value_index,value_index_next;

reg signed[ 7:0] i,j,i_next,j_next;
reg       [ 7:0] x,x_next;
reg       [ 7:0] y,y_next;
reg signed[16:0] result,result_next ;

reg load_done;
reg conv_done;
reg all_done;


reg       [ 2:0] state, state_next;
parameter [ 2:0] IDLE    = 3'b000;
parameter [ 2:0] COEF    = 3'b001;
parameter [ 2:0] CENTER  = 3'b010;
parameter [ 2:0] LOAD    = 3'b011;
parameter [ 2:0] CATCH   = 3'b100;
parameter [ 2:0] CONV    = 3'b101;
parameter [ 2:0] OUT     = 3'b110;

 
always@ (posedge clk or negedge rst_n) begin
  if(!rst_n)begin
    state <= IDLE;
    en<=0;
  end  
  else begin
    state <= state_next;
    en <= 1;
    coef_i <= coef_i_next;
    coef_j <= coef_j_next;
    x <= x_next;
    y <= y_next;
    i <= i_next;
    j <= j_next;
    result <= result_next;
    value_index <= value_index_next;
    
    if(state == COEF) begin 
      if(fc_valid)
        filter_coef[coef_i][coef_j] <= fc ; 
      else  
        filter_coef[coef_i][coef_j] <= 0;
    end

    if(state == CATCH) begin
      if( (i==-2 && x<2) || (i==-1 && x<1) || (i==1 && x>254) || (i==2 && x>253) || (j==-2 && y<2) || (j==-1 && y<1) || (j==1 && y>254) || (j==2 && y>253))
        value[value_index] <= 0;
      else
        value[value_index] <= {1'b0 , working_pixel}; 
    end
  
  end
end

always@*begin 
  case(state)

     IDLE : begin
       if(start)
          state_next = COEF;
       else
          state_next = IDLE;   
     end

     COEF : begin
       if(fc_valid)
         state_next = COEF;
       else
         state_next = CENTER;
     end

     CENTER : begin
        if(all_done)
         state_next = IDLE;
        else 
         state_next = LOAD;
     end
    
     LOAD : begin
         state_next = CATCH;
     end

     CATCH : begin
         if(load_done)
          state_next = CONV;
         else 
          state_next = LOAD;
     end

     CONV : begin
        if(conv_done)
         state_next = OUT;
        else 
         state_next = CONV;
     end

     OUT  : begin
         state_next = CENTER;
     end 
     
     default : begin
         state_next = IDLE; 
     end
  endcase  
end


always@*begin 
  
  case(state)

    IDLE : begin
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = 0;
      x_next = 0;
      y_next = 0;
      i_next = -2;
      j_next = -2;
    end

    COEF : begin
      if(fc_valid) begin
        if(coef_j <4) begin
          coef_i_next = coef_i;
          coef_j_next = coef_j + 1 ;
        end   
        else begin
          coef_i_next = coef_i + 1;
          coef_j_next = 0;
        end
      end
      else begin
         coef_i_next = coef_i ;
         coef_j_next = coef_j ;
      end
      value_index_next = 0;
      x_next = 0;
      y_next = 0;
      i_next = -2;
      j_next = -2;
    end

    CENTER : begin    
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = 0;
      x_next = x;
      y_next = y;
      i_next = -2;
      j_next = -2;
    end
        
    LOAD : begin
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = value_index;
      x_next = x;
      y_next = y;
      i_next = i;
      j_next = j;
    end
    
    CATCH  : begin
      coef_i_next = 0;
      coef_j_next = 0;
      x_next = x;
      y_next = y;

      if(i == 2)begin
        if(j == 2)begin
          i_next = -2;
          j_next = -2;
          value_index_next = 0;
        end
        else begin
          i_next = -2;
          j_next = j + 1;
          value_index_next = value_index + 1;
        end
      end
      else begin
        i_next = i + 1; 
        j_next = j ;
        value_index_next = value_index + 1;
      end

      //$display("i=%4d j=%4d x=%4d y=%4d index=%4d value=%4d",i,j,x+i,y+j,value_index,value[value_index]);
    end

    CONV : begin
      coef_i_next = 0;
      coef_j_next = 0;
      x_next = x;
      y_next = y;
      if(i == 2)begin
        if(j == 2)begin
          i_next = -2;
          j_next = -2;
          value_index_next = 0;
        end
        else begin
          i_next = -2;
          j_next = j + 1;
          value_index_next = value_index + 1;
        end
      end
      else begin
        i_next = i + 1; 
        j_next = j ;
        value_index_next = value_index + 1;
      end
    end

    OUT : begin 
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = value_index;

      if(x==255)begin
        x_next = 0;
        if(y==255)
          y_next = 255;   
        else
          y_next = y + 1;           
      end
      else begin
        x_next = x + 1;
        y_next = y;
      end 
      i_next = i;
      j_next = j;
    end
    
    default : begin
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = 0;
      x_next = 0;
      y_next = 0;
      i_next = -2;
      j_next = -2;
    end

  endcase
end

always@*begin 
  
  case(state)

    IDLE : begin
      result_next = 0;
      addr = 0;
      load_done = 0;
      all_done  = 0;
      conv_done = 0;
      out_valid = 0;
      out_pixel = 0;
    end

    COEF : begin
      result_next = 0;
      addr = 0;
      load_done = 0;
      all_done  = 0;
      conv_done = 0;
      out_valid = 0;
      out_pixel = 0;  
    end

    CENTER : begin    
      result_next = 0;
      addr = 0;
      load_done = 0;
      conv_done = 0;
      out_valid = 0;
      out_pixel = 0;
      if(x==255 && y==255)
         all_done = 1;
      else
         all_done = 0;
    end
        
    LOAD : begin
      result_next = 0;
      conv_done = 0;
      out_valid = 0;
      out_pixel = 0;
      load_done = 0;
      if(x==255 && y==255)
         all_done = 1;
      else
         all_done = 0;
      addr = {{y+j} , {8{1'b0}} } + {{8{1'b0}},{x+i}};
    end
    
    CATCH  : begin 

      if(i == 2 && j == 2)
        load_done = 1;
      else 
        load_done = 0; 
      addr = 0;
      result_next = 0;
      all_done  = 0;
      conv_done = 0;
      out_valid = 0;
      out_pixel = 0;    

    end
    CONV : begin
      if(i == 2 && j == 2) begin
        conv_done = 1;
        load_done = 0;
      end
      else begin
        conv_done = 0;
        load_done = 1;
      end
      addr = 0;
      all_done  = 0;
      out_valid = 0;
      out_pixel = 0;  
      result_next = result  + {{8{value[value_index][8]}} , value[value_index] } * { {8{filter_coef[i+2][j+2][8]}} , filter_coef[i+2][j+2] };
    end

    OUT : begin
      result_next = result;
      addr = 0;
      load_done = 0;
      all_done  = 0;
      conv_done = 0; 
      out_valid = 1;
      if(result > 255)
        out_pixel = 255;  
      else if(result < 0)  
        out_pixel = 0;
      else
        out_pixel = result[7:0];  
    end
    
    default : begin
      result_next = 0;
      addr = 0;
      load_done = 0;
      all_done  = 0;
      conv_done = 0;
      out_valid = 0;
      out_pixel = 0;
    end

  endcase
end


endmodule
