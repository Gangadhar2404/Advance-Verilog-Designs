module pipelining #(parameter N=10)(
  input [N-1:0]a,b,c,d,
  input clk,
  output [N-1:0]f
  );
  reg [N-1:0]L12_x1,L12_x2,L12_d,L23_x3,L23_d,L34_f;
  assign f=L34_f;
  always @(posedge clk) begin
    L12_x1<=a+b;
    L12_x2<=c-d;
    L12_d<=d;
    
    L23_x3<=L12_x1+L12_x2;
    L23_d<=L12_d;
    
    L34_f<=L23_x3*L23_d;
    
    end
endmodule