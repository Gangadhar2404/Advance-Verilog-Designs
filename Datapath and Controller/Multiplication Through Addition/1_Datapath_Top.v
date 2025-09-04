module datapath(data_in,clk,ld_a,ld_b,ld_d,dec,clr_d,equal);
  input clk,ld_a,ld_b,ld_d,clr_d,dec;
  input [15:0]data_in;
  output equal;
  
  wire [15:0]x,y,z,bout,bus;
  
  Pipo P1 (bus,clk,ld_a,x);
  Pipo1 P2(z,clk,clr_d,ld_d,y);
  decrement B1(bus,clk,ld_b,dec,bout);
  adder A1(x,y,z);
  eqz E1(bout,equal);
  
endmodule