module MUL_test;
  reg [15:0] data_in;
  reg clk, start;
  wire done, eqz;
  wire ld_a, ld_b, ld_d, clr_d, dec;

  // Instantiate datapath
  datapath DP (
    .data_in(data_in),
    .clk(clk),
    .ld_a(ld_a),
    .ld_b(ld_b),
    .ld_d(ld_d),
    .dec(dec),
    .clr_d(clr_d),
    .equal(eqz)
  );

  // Instantiate controller
  controller CON (
    .ld_a(ld_a),
    .ld_b(ld_b),
    .ld_d(ld_d),
    .clk(clk),
    .clr_d(clr_d),
    .dec(dec),
    .done(done),
    .eqz(eqz),
    .start(start)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns period clock
  end

  // Stimulus
  initial begin
    start = 0;
    data_in = 0;
    
    #5 start = 1;        // start signal
    #12 data_in = 17;    // first input
    #10 data_in = 5;     // second input
    
    #200 $finish;        // stop simulation
  end

  // Monitor & Dump
  initial begin
    $monitor("Time=%0t | data_in=%d | done=%b | eqz=%b | ld_a=%b ld_b=%b ld_d=%b dec=%b clr_d=%b",
             $time, data_in, done, eqz, ld_a, ld_b, ld_d, dec, clr_d);
    $dumpfile("mul.vcd");
    $dumpvars(0, MUL_test);
  end
endmodule
