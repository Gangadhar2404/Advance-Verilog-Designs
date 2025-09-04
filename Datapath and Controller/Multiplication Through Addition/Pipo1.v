module Pipo1(in,clk,clr,ld,out);
  input [15:0]in;
  input clk,clr,ld;
  output reg [15:0]out;
  always @(posedge clk) begin
    if(clr)
      out<=0;
    else if(ld)
      out<=in;
  end
endmodule
  