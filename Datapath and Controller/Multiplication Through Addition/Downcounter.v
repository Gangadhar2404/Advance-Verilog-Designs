module decrement(in,clk,ld,dec,out);
  input [15:0]in;
  input clk,ld,dec;
  output reg [15:0]out;
  always @(posedge clk) begin
    if(ld) begin
      out <= in;
    end
    else if(dec) begin
      out<=out-1;
    end
  end
endmodule