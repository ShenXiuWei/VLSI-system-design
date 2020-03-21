module filter (
  input wire clk,
  input wire rst_n,
  input wire fc_valid,
  input wire [7:0] working_pixel_a,
  input wire [7:0] working_pixel_b,
  input signed [7:0] fc,
  input wire start,
  output reg [7:0] out_pixel,
  output reg out_valid,
  output reg [15:0] addra,
  output reg [15:0] addrb,
  output reg wen,
  output reg en,
  output reg [7:0] d
);


reg signed[ 8:0] filter_coef [0:4][0:4];
reg       [ 3:0] coef_i,coef_i_next;
reg       [ 3:0] coef_j,coef_j_next;
reg signed[ 8:0] value_a [0:25];
reg signed[ 8:0] value_b [0:25];
reg       [ 7:0] value_index,value_index_next;

reg signed[ 7:0] i,j,i_next,j_next;
reg       [ 7:0] x,x_next;
reg       [ 7:0] y,y_next;
reg signed[16:0] result_a,result_a_next,result_b,result_b_next;

reg load_done;
reg all_done;


reg       [ 3:0] state, state_next;
parameter [ 3:0] IDLE    = 4'b0000;
parameter [ 3:0] COEF    = 4'b0001;
parameter [ 3:0] CENTER  = 4'b0010;
parameter [ 3:0] LOAD    = 4'b0011;
parameter [ 3:0] CATCH   = 4'b0100;
parameter [ 3:0] CONV    = 4'b0101;
parameter [ 3:0] OUT     = 4'b0110;
parameter [ 3:0] OFF     = 4'b0111;
parameter [ 3:0] OUT2    = 4'b1000;
 
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
    result_a <= result_a_next;
    result_b <= result_b_next;
    value_index <= value_index_next;
    
    if(state == COEF) begin 
      if(fc_valid)
        filter_coef[coef_i][coef_j] <= fc ; 
      else  
        filter_coef[coef_i][coef_j] <= 0;
    end

    if(state == CATCH) begin
      if( (i==-2 && x<2) || (i==-1 && x<1) || (i==1 && x>254) || (i==2 && x>253) || (j==-2 && y<2) || (j==-1 && y<1) || (j==1 && y>254) || (j==2 && y>253))
        value_a[value_index] <= 0;
      else
        value_a[value_index] <= {1'b0 , working_pixel_a}; 

      if( (i==-2 && x<1) || (i==-1 && x<0) || (i==1 && x>253) || (i==2 && x>252) || (j==-2 && y<2) || (j==-1 && y<1) || (j==1 && y>254) || (j==2 && y>253))
        value_b[value_index] <= 0;
      else
        value_b[value_index] <= {1'b0 , working_pixel_b}; 
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
           state_next = OUT;
     end

     OUT  : begin
         state_next = OFF; 
     end 
     
     OFF : begin
         state_next = OUT2;
     end

     OUT2 : begin
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
      x_next = x;
      y_next = y;
      i_next = i;
      j_next = j;
    end
   
    OFF : begin 
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = value_index;
      x_next = x;
      y_next = y;
      i_next = i;
      j_next = j;
    end

    OUT2 : begin 
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = value_index;
      if(x==254)begin
        x_next = 0;
        if(y==255)
          y_next = 255;   
        else
          y_next = y + 1;           
      end
      else begin
        x_next = x + 2;
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
      result_a_next = 0;
      result_b_next = 0;
      addra = 0;
      addrb = 0;
      load_done = 0;
      all_done  = 0;
      out_valid = 0;
      out_pixel = 0;
    end

    COEF : begin
      result_a_next = 0;
      result_b_next = 0;
      addra = 0;
      addrb = 0;
      load_done = 0;
      all_done  = 0;
      out_valid = 0;
      out_pixel = 0;  
    end

    CENTER : begin    
      result_a_next = 0;
      result_b_next = 0;
      addra = 0;
      addrb = 0;
      out_valid = 0;
      out_pixel = 0;
      load_done = 0;
      if(x==254 && y==255)
         all_done = 1;
      else
         all_done = 0;   
    end
        
    LOAD : begin
      result_a_next = 0;
      result_b_next = 0;
      out_valid = 0;
      out_pixel = 0;
      load_done = 0; 
      if(x==254 && y==255)
         all_done = 1;
      else
         all_done = 0;
      addra = {{y+j} , {8{1'b0}} } + {{8{1'b0}},{x+i}};
      addrb = {{y+j} , {8{1'b0}} } + {{8{1'b0}},{x+8'd1+i}};

    end
    
    CATCH  : begin 

      if(i == 2 && j == 2)
        load_done = 1;
      else 
        load_done = 0; 
      addra = 0;
      addrb = 0;
      result_a_next = 0;
      result_b_next = 0;
      all_done  = 0;
      out_valid = 0;
      out_pixel = 0;    

    end
    CONV : begin
      addra = 0;
      addrb = 0;
      load_done = 0;
      all_done  = 0;
      out_valid = 0;
      out_pixel = 0;  
      result_a_next  =    { {8{value_a[0][8]}}  , value_a[0]  } * { {8{filter_coef[0][0][8]}} , filter_coef[0][0] } 
                         +{ {8{value_a[1][8]}}  , value_a[1]  } * { {8{filter_coef[0][1][8]}} , filter_coef[0][1] } 
                         +{ {8{value_a[2][8]}}  , value_a[2]  } * { {8{filter_coef[0][2][8]}} , filter_coef[0][2] }
                         +{ {8{value_a[3][8]}}  , value_a[3]  } * { {8{filter_coef[0][3][8]}} , filter_coef[0][3] }
                         +{ {8{value_a[4][8]}}  , value_a[4]  } * { {8{filter_coef[0][4][8]}} , filter_coef[0][4] }
                         +{ {8{value_a[5][8]}}  , value_a[5]  } * { {8{filter_coef[1][0][8]}} , filter_coef[1][0] }
                         +{ {8{value_a[6][8]}}  , value_a[6]  } * { {8{filter_coef[1][1][8]}} , filter_coef[1][1] }
                         +{ {8{value_a[7][8]}}  , value_a[7]  } * { {8{filter_coef[1][2][8]}} , filter_coef[1][2] }
                         +{ {8{value_a[8][8]}}  , value_a[8]  } * { {8{filter_coef[1][3][8]}} , filter_coef[1][3] }
                         +{ {8{value_a[9][8]}}  , value_a[9]  } * { {8{filter_coef[1][4][8]}} , filter_coef[1][4] }
                         +{ {8{value_a[10][8]}} , value_a[10] } * { {8{filter_coef[2][0][8]}} , filter_coef[2][0] }
                         +{ {8{value_a[11][8]}} , value_a[11] } * { {8{filter_coef[2][1][8]}} , filter_coef[2][1] }
                         +{ {8{value_a[12][8]}} , value_a[12] } * { {8{filter_coef[2][2][8]}} , filter_coef[2][2] }
                         +{ {8{value_a[13][8]}} , value_a[13] } * { {8{filter_coef[2][3][8]}} , filter_coef[2][3] }
                         +{ {8{value_a[14][8]}} , value_a[14] } * { {8{filter_coef[2][4][8]}} , filter_coef[2][4] }
                         +{ {8{value_a[15][8]}} , value_a[15] } * { {8{filter_coef[3][0][8]}} , filter_coef[3][0] }
                         +{ {8{value_a[16][8]}} , value_a[16] } * { {8{filter_coef[3][1][8]}} , filter_coef[3][1] }
                         +{ {8{value_a[17][8]}} , value_a[17] } * { {8{filter_coef[3][2][8]}} , filter_coef[3][2] }
                         +{ {8{value_a[18][8]}} , value_a[18] } * { {8{filter_coef[3][3][8]}} , filter_coef[3][3] }
                         +{ {8{value_a[19][8]}} , value_a[19] } * { {8{filter_coef[3][4][8]}} , filter_coef[3][4] }
                         +{ {8{value_a[20][8]}} , value_a[20] } * { {8{filter_coef[4][0][8]}} , filter_coef[4][0] }
                         +{ {8{value_a[21][8]}} , value_a[21] } * { {8{filter_coef[4][1][8]}} , filter_coef[4][1] }
                         +{ {8{value_a[22][8]}} , value_a[22] } * { {8{filter_coef[4][2][8]}} , filter_coef[4][2] }
                         +{ {8{value_a[23][8]}} , value_a[23] } * { {8{filter_coef[4][3][8]}} , filter_coef[4][3] }
                         +{ {8{value_a[24][8]}} , value_a[24] } * { {8{filter_coef[4][4][8]}} , filter_coef[4][4] };

      result_b_next  =    { {8{value_b[0][8]}}  , value_b[0]  } * { {8{filter_coef[0][0][8]}} , filter_coef[0][0] } 
                         +{ {8{value_b[1][8]}}  , value_b[1]  } * { {8{filter_coef[0][1][8]}} , filter_coef[0][1] } 
                         +{ {8{value_b[2][8]}}  , value_b[2]  } * { {8{filter_coef[0][2][8]}} , filter_coef[0][2] }
                         +{ {8{value_b[3][8]}}  , value_b[3]  } * { {8{filter_coef[0][3][8]}} , filter_coef[0][3] }
                         +{ {8{value_b[4][8]}}  , value_b[4]  } * { {8{filter_coef[0][4][8]}} , filter_coef[0][4] }
                         +{ {8{value_b[5][8]}}  , value_b[5]  } * { {8{filter_coef[1][0][8]}} , filter_coef[1][0] }
                         +{ {8{value_b[6][8]}}  , value_b[6]  } * { {8{filter_coef[1][1][8]}} , filter_coef[1][1] }
                         +{ {8{value_b[7][8]}}  , value_b[7]  } * { {8{filter_coef[1][2][8]}} , filter_coef[1][2] }
                         +{ {8{value_b[8][8]}}  , value_b[8]  } * { {8{filter_coef[1][3][8]}} , filter_coef[1][3] }
                         +{ {8{value_b[9][8]}}  , value_b[9]  } * { {8{filter_coef[1][4][8]}} , filter_coef[1][4] }
                         +{ {8{value_b[10][8]}} , value_b[10] } * { {8{filter_coef[2][0][8]}} , filter_coef[2][0] }
                         +{ {8{value_b[11][8]}} , value_b[11] } * { {8{filter_coef[2][1][8]}} , filter_coef[2][1] }
                         +{ {8{value_b[12][8]}} , value_b[12] } * { {8{filter_coef[2][2][8]}} , filter_coef[2][2] }
                         +{ {8{value_b[13][8]}} , value_b[13] } * { {8{filter_coef[2][3][8]}} , filter_coef[2][3] }
                         +{ {8{value_b[14][8]}} , value_b[14] } * { {8{filter_coef[2][4][8]}} , filter_coef[2][4] }
                         +{ {8{value_b[15][8]}} , value_b[15] } * { {8{filter_coef[3][0][8]}} , filter_coef[3][0] }
                         +{ {8{value_b[16][8]}} , value_b[16] } * { {8{filter_coef[3][1][8]}} , filter_coef[3][1] }
                         +{ {8{value_b[17][8]}} , value_b[17] } * { {8{filter_coef[3][2][8]}} , filter_coef[3][2] }
                         +{ {8{value_b[18][8]}} , value_b[18] } * { {8{filter_coef[3][3][8]}} , filter_coef[3][3] }
                         +{ {8{value_b[19][8]}} , value_b[19] } * { {8{filter_coef[3][4][8]}} , filter_coef[3][4] }
                         +{ {8{value_b[20][8]}} , value_b[20] } * { {8{filter_coef[4][0][8]}} , filter_coef[4][0] }
                         +{ {8{value_b[21][8]}} , value_b[21] } * { {8{filter_coef[4][1][8]}} , filter_coef[4][1] }
                         +{ {8{value_b[22][8]}} , value_b[22] } * { {8{filter_coef[4][2][8]}} , filter_coef[4][2] }
                         +{ {8{value_b[23][8]}} , value_b[23] } * { {8{filter_coef[4][3][8]}} , filter_coef[4][3] }
                         +{ {8{value_b[24][8]}} , value_b[24] } * { {8{filter_coef[4][4][8]}} , filter_coef[4][4] };
    end

    OUT : begin
      result_a_next = result_a;
      result_b_next = result_b;
      addra = 0;
      addrb = 0;
      load_done = 0;
      all_done  = 0;
      out_valid = 1;  

      if(result_a > 255)
        out_pixel = 255;  
      else if(result_a < 0)  
        out_pixel = 0;
      else
        out_pixel = result_a[7:0];     
    end

    OFF : begin
      result_a_next = result_a;
      result_b_next = result_b;
      addra = 0;
      addrb = 0;
      load_done = 0;
      all_done  = 0;
      out_valid = 0;
      out_pixel = 0;
    end

    OUT2 : begin
      result_a_next = result_a;
      result_b_next = result_b;
      addra = 0;
      addrb = 0;
      load_done = 0;
      all_done  = 0;
      out_valid = 1;

      if(result_b > 255)
        out_pixel = 255;  
      else if(result_b < 0)  
        out_pixel = 0;
      else
        out_pixel = result_b[7:0];   
    end

    default : begin
      result_a_next = 0;
      result_b_next = 0;
      addra = 0;
      addrb = 0;
      load_done = 0;
      all_done  = 0;
      out_valid = 0;
      out_pixel = 0;
    end

  endcase
end


endmodule
