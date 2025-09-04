module tb;
  reg [3:0]rs1,rs2,rd,func;
  reg clk1,clk2;
  reg [7:0]addr;
  wire [15:0]z_out;
  
  integer i;
  
  pipelining dut (.rs1(rs1),.rs2(rs2),.rd(rd),.func(func),.clk1(clk1),.clk2(clk2),.addr(addr),.z_out(z_out));
  
  initial begin
    clk1=0;
    clk2=0; 
    repeat(10) begin
    #5 clk1=1; #5 clk1=0;
    #5 clk2=1; #5 clk2=0;
    end
    #10 $finish;
  end
  
 initial begin
  #1 
  for(i=0;i<16;i=i+1) begin
   dut.regbank[i]=i;
  end
  
  for(i=0;i<256;i=i+1) begin
   dut.mem[i]=16'b0;
  end
  end
  
  initial begin
    rs1=0; rs2=1; rd=0; addr=8'h00; func=4'b0000; // ADD
    #20 rs1=5; rs2=1; rd=1; addr=8'h01; func=4'b0001; // SUB
    #20 rs1=5; rs2=2; rd=2; addr=8'h02; func=4'b0011; // AND
    #20 rs1=7; rs2=5; rd=3; addr=8'h03; func=4'b0111; // MOV B
    #20 rs1=2; rs2=7; rd=4; addr=8'h04; func=4'b1000; // NEG A
    #20 rs1=1; rs2=0; rd=5; addr=8'h05; func=4'b1010; // SHIFT RIGHT A
    
    end
 endmodule
  