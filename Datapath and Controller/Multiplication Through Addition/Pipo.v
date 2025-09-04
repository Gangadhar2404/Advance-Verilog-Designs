module Pipo(in,clk,ld,out);
  input [15:0]in;
  input ld,clk;
  output reg [15:0]out;
  always @(posedge clk) begin
    if(ld)
      out<=in;
  end
endmodule