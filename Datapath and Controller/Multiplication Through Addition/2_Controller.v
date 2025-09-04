module controller(ld_a,ld_b,ld_d,clk,clr_d,dec,done,eqz,start);
  input start,eqz,clk;
  output reg ld_a,ld_b,ld_d,clr_d,dec,done;
  
  reg [2:0]state;
  
  parameter S0=3'b000;
  parameter S1=3'b001;
  parameter S2=3'b010;
  parameter S3=3'b011;
  parameter S4=3'b100;
  
  always @(posedge clk) begin
    case(state)
    S0: begin
      if(start)
        state<=1;
     end
     S1:begin
       state<=S2;
     end
     S2: begin
       state<=S3;
     end
     S3: begin
       #2 if(eqz)
         state<=S4;
     end
     S4: begin
       state<=S4;
     end
     default : state<=S0;
     endcase
   end
   
   always @(*) begin
     case(state)
     S0: begin
       #1 ld_a=0;
       ld_b=0;
       ld_d=0;
       clr_d=0;
       dec=0;
       done=0;
     end
     S1: begin
       #1 ld_a=1;
     end
     S2: begin
       #1 ld_a=0;
       ld_b=1;
       clr_d=1;
     end
     S3: begin
       #1 ld_b=0;
       clr_d=0;
       ld_d=1;
       dec=1;
     end
     S4: begin
       #1 ld_b=0;
       ld_d=0;
       dec=0;
       done=1;
     end
     default: begin
       #1 ld_a=0;
       ld_b=0;
       ld_d=0;
       clr_d=0;
       dec=0;
     end
     endcase
   end
 endmodule
  
  