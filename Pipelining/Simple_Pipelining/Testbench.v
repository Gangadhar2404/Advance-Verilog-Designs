`timescale 1ns/1ps

module tb_pipelining;

  parameter N = 10;

  // Testbench signals
  reg clk;
  reg [N-1:0] a, b, c, d;
  wire [N-1:0] f;

  // Instantiate the DUT
  pipelining #(N) dut (
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .clk(clk),
    .f(f)
  );

  // Clock generation: 10ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Toggle every 5ns → 10ns clock period
  end

  // Stimulus
  initial begin
    // Initialize inputs
    a = 0; b = 0; c = 0; d = 0;

    // Dump for GTKWave
    $dumpfile("pipelining_tb.vcd");
    $dumpvars(0, tb_pipelining);

    // Apply different sets of inputs
    #10 a = 10; b = 5; c = 20; d = 2;
    #10 a = 15; b = 25; c = 12; d = 4;
    #10 a = 30; b = 10; c = 18; d = 3;
    #10 a = 8;  b = 7;  c = 6;  d = 5;
    #10 a = 50; b = 40; c = 35; d = 10;

    // Wait for pipeline to flush
    #50 $finish;
  end

  // Monitor outputs
  initial begin
    $monitor("Time=%0t | a=%d b=%d c=%d d=%d | f=%d", 
              $time, a, b, c, d, f);
  end

endmodule
