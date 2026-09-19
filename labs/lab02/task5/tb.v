// tb.v
// Self-checking testbench for alu.v.

module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] expected;

  integer i, j;
  integer errors;

  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  task check;
    begin
      #5;
      expected = t_op ? (t_a - t_b) : (t_a + t_b);
      if (t_result !== expected) begin
        $display("FAIL at time %0t: a=%b b=%b op=%b  got result=%b  expected %b",
                 $time, t_a, t_b, t_op, t_result, expected);
        errors = errors + 1;
      end
    end
  endtask

  initial begin
    errors = 0;

    t_a = 4'd9; t_b = 4'd4; t_op = 1'b0;
    check;
    t_op = 1'b1;
    check;
    t_op = 1'b0;
    check;

    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        t_a = i[3:0];
        t_b = j[3:0];
        t_op = 1'b0;
        check;
        t_op = 1'b1;
        check;
      end
    end

    $write("Summary: %0d of 515 checks passed", 515 - errors);
    $display(" (%0d errors)", errors);
    $finish;
  end

endmodule
