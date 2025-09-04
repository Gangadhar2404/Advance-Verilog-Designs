module pipelining(
  input [3:0]rs1,rs2,rd,func,
  input clk1,clk2,
  input [7:0]addr,
  output [15:0]z_out,
  output [15:0] mem_out_signal
  );
  
  reg [3:0]L12_rd,L23_rd,L12_func;
  reg [7:0]L12_addr,L23_addr,L34_addr;
  reg [15:0]L12_a,L12_b,L23_z,L34_z;
  
  reg [15:0] regbank [0:15];
  reg [15:0] mem [0:255];
  
  assign mem_out_signal = mem[L34_addr];


  assign z_out=L34_z;
  
  always @(posedge clk1) begin
    L12_a<= #2 regbank[rs1];
    L12_b<= #2 regbank[rs2];
    L12_rd<= #2 rd;
    L12_func<= #2 func;
    L12_addr<= #2 addr;
  end
  always @(posedge clk2)begin
    L23_rd<= #2 L12_rd;
    L23_addr<= #2 L12_addr;
    case(L12_func)
      4'b0000: L23_z= #2  L12_a + L12_b;
      4'b0001: L23_z= #2  L12_a - L12_b;
      4'b0010: L23_z= #2  L12_a * L12_b;
      4'b0011: L23_z= #2  L12_a & L12_b;
      4'b0100: L23_z= #2  L12_a | L12_b;
      4'b0101: L23_z= #2  L12_a ^ L12_b;
      4'b0110: L23_z= #2  L12_a;
      4'b0111: L23_z= #2  L12_b;
      4'b1000: L23_z= #2  -L12_a;
      4'b1001: L23_z= #2  -L12_b;
      4'b1010: L23_z= #2  L12_a>>1;
      4'b1011: L23_z= #2  L12_b>>1;
      default:  L23_z= #2  16'hx;
    endcase
  end
  
  always @(posedge clk1) begin
    L34_addr<= #2 L23_addr;
    regbank[L23_rd]<= #2 L23_z;
    L34_z<=L23_z;
  end
  
  always @(posedge clk2) begin
    mem[L34_addr]<= #2 L34_z;
  end
endmodule
      
    
    
    
    
    
    
    
    
    
    
    
    