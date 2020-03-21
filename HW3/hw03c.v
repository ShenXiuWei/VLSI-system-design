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
  output reg ena,
  output reg enb,
  output reg [7:0] d
);


reg signed[ 8:0] filter_coef [0:4][0:4];
reg       [ 3:0] coef_i,coef_i_next;
reg       [ 3:0] coef_j,coef_j_next;
reg signed[ 8:0] value_a [0:25];
reg signed[ 8:0] value_b [0:25];
reg       [ 7:0] value_index,value_index_next;

reg signed[ 7:0] i,j,i_next,j_next;
reg       [ 7:0] x,x_next,center_x;
reg       [ 7:0] y,y_next,center_y;
reg signed[16:0] result_a,result_a_next,result_b,result_b_next;

reg load_done;
reg conv_done;
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
    ena <= 0;
    enb <= 0;

  end  
  else begin
    state <= state_next;
    ena <= 1;
    enb <= 1;
    case(state)

        IDLE : begin
          coef_i <= 0;
          coef_j <= 0;
          x<=0;
          y<=0;
          i<=-2;
          j<=-2;
          result_a <= 0;
          result_b <= 0;
          value_index <= 0;
        end

        COEF : begin
          if(fc_valid)
            filter_coef[coef_i][coef_j] <= fc ; 
          else  
            filter_coef[coef_i][coef_j] <= 0;
          coef_i <= coef_i_next;
          coef_j <= coef_j_next;
          x<=0;
          y<=0;
          i<=-2;
          j<=-2;
          result_a <= 0;
          result_b <= 0;
          value_index <= 0;
        end 
      
        CENTER : begin
          coef_i <= coef_i_next;
          coef_j <= coef_j_next;
          x<=x_next;
          y<=y_next;
          i<=-2;
          j<=-2;
          result_a <= 0;
          result_b <= 0;
          value_index <= 0;  
        end

        LOAD : begin
          coef_i <= coef_i_next;
          coef_j <= coef_j_next;
          x<=x_next;
          y<=y_next;
          i<=i_next;
          j<=j_next;
          result_a <= 0;
          result_b <= 0;
          value_index <= value_index_next;
        end

        CATCH :begin

          if( (i==-2 && center_x<2) || (i==-1 && center_x<1) || (i==1 && center_x>254) || (i==2 && center_x>253) || (j==-2 && center_y<2) || (j==-1 && center_y<1) || (j==1 && center_y>254) || (j==2 && center_y>253))
            value_a[value_index] <= 0;
          else
            value_a[value_index] <= {1'b0 , working_pixel_a}; 

          if( (i==-2 && center_x<1) || (i==-1 && center_x<0) || (i==1 && center_x>253) || (i==2 && center_x>252) || (j==-2 && center_y<2) || (j==-1 && center_y<1) || (j==1 && center_y>254) || (j==2 && center_y>253))
            value_b[value_index] <= 0;
          else
            value_b[value_index] <= {1'b0 , working_pixel_b}; 

          coef_i <= coef_i_next;
          coef_j <= coef_j_next;
          x<=x_next;
          y<=y_next;
          i<=i_next;
          j<=j_next;
          result_a <= 0;
          result_b <= 0;
          value_index <= value_index_next;
        end

        CONV : begin
          coef_i <= coef_i_next;
          coef_j <= coef_j_next;
          x<=x_next;
          y<=y_next;
          i<=i_next;
          j<=j_next;
          result_a <= result_a_next;
          result_b <= result_b_next;
          value_index <= value_index_next;
        end

        OUT : begin
          coef_i <= coef_i_next;
          coef_j <= coef_j_next;
          x<=x_next;
          y<=y_next;
          i<=i_next;
          j<=j_next;
          result_a <= result_a_next;
          result_b <= result_b_next;
          value_index <= value_index_next;

        end

        OFF : begin
          coef_i <= coef_i_next;
          coef_j <= coef_j_next;
          x<=x_next;
          y<=y_next;
          i<=i_next;
          j<=j_next;
          result_a <= result_a_next;
          result_b <= result_b_next;
          value_index <= value_index_next;
        end

        OUT2 : begin
          coef_i <= coef_i_next;
          coef_j <= coef_j_next;
          x<=x_next;
          y<=y_next;
          i<=i_next;
          j<=j_next;
          result_a <= result_a_next;
          result_b <= result_b_next;
          value_index <= value_index_next;
        end
        
        default : begin
          coef_i <= 0;
          coef_j <= 0;
          result_a <= 0;
          result_b <= 0;
          value_index <= 0;
          x<=0;
          y<=0;
          i<=-2;
          j<=-2;
        end
    endcase    
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
         if(i==2&&j==2)
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
      center_x = 0;
      center_y = 0;
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
      center_x = 0;
      center_y = 0;
      x_next = 0;
      y_next = 0;
      i_next = -2;
      j_next = -2;
    end

    CENTER : begin    
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = 0;
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
      center_x = x;
      center_y = y;
      i_next = -2;
      j_next = -2;
    end
        
    LOAD : begin
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = value_index;
     
      if(x == 0 && y != 0) begin
        center_x = 254;
        center_y = y-1;
      end
      else begin
        center_x = x-2;
        center_y = y;
      end

      x_next = x;
      y_next = y;
      i_next = i;
      j_next = j;
    end
    
    CATCH  : begin
      coef_i_next = 0;
      coef_j_next = 0;

      if(x == 0 && y != 0) begin
        center_x = 254;
        center_y = y-1;
      end
      else begin
        center_x = x-2;
        center_y = y;
      end
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
      if(x == 0 && y != 0) begin
        center_x = 254;
        center_y = y-1;
      end
      else begin
        center_x = x-2;
        center_y = y;
      end
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
      if(x == 0 && y != 0) begin
        center_x = 254;
        center_y = y-1;
      end
      else begin
        center_x = x-2;
        center_y = y;
      end
      x_next = x;
      y_next = y;
      i_next = i;
      j_next = j;
    end
   
    OFF : begin 
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = value_index;
      if(x == 0 && y != 0) begin
        center_x = 254;
        center_y = y-1;
      end
      else begin
        center_x = x-2;
        center_y = y;
      end
      x_next = x;
      y_next = y;
      i_next = i;
      j_next = j;
    end

    OUT2 : begin 
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = value_index;
      if(x == 0 && y != 0) begin
        center_x = 254;
        center_y = y-1;
      end
      else begin
        center_x = x-2;
        center_y = y;
      end
      x_next = x;
      y_next = y;
      i_next = i;
      j_next = j;
    end
    
    default : begin
      coef_i_next = 0;
      coef_j_next = 0;
      value_index_next = 0;
      center_x = 0;
      center_y = 0;
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
      conv_done = 0;
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
      conv_done = 0;
      out_valid = 0;
      out_pixel = 0;  
    end

    CENTER : begin    
      result_a_next = result_a;
      result_b_next = result_b;
      addra = 0;
      addrb = 0;
      out_valid = 0;
      out_pixel = 0;
      load_done = 0;
      conv_done = 0;
      if(x==254 && y==255)
         all_done = 1;
      else
         all_done = 0;   
    end
        
    LOAD : begin
      result_a_next = 0;
      result_b_next = 0;
      conv_done = 0;
      out_valid = 0;
      out_pixel = 0;
      load_done = 0; 
      if(x==254 && y==255)
         all_done = 1;
      else
         all_done = 0;
      addra = {{center_y+j} , {8{1'b0}} } + {{8{1'b0}},{center_x+i}};
      addrb = {{center_y+j} , {8{1'b0}} } + {{8{1'b0}},{center_x+8'd1+i}};

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
      addra = 0;
      addrb = 0;
      all_done  = 0;
      out_valid = 0;
      out_pixel = 0;  
      result_a_next = result_a  + {{8{value_a[value_index][8]}} , value_a[value_index] } * { {8{filter_coef[i+2][j+2][8]}} , filter_coef[i+2][j+2] };
      result_b_next = result_b  + {{8{value_b[value_index][8]}} , value_b[value_index] } * { {8{filter_coef[i+2][j+2][8]}} , filter_coef[i+2][j+2] };
    end

    OUT : begin
      result_a_next = result_a;
      result_b_next = result_b;
      addra = 0;
      addrb = 0;
      load_done = 0;
      all_done  = 0;
      conv_done = 0; 
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
      conv_done = 0; 
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
      conv_done = 0; 
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
      conv_done = 0;
      out_valid = 0;
      out_pixel = 0;
    end

  endcase
end


endmodule
