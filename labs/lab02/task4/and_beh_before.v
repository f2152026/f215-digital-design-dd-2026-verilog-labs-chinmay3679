// and_beh_before.v
// 2-input AND gate, BEHAVIORAL style, with the delay placed BEFORE the
// assignment: the statement waits, then evaluates a & b

module and_beh_before (
  input      a,
  input      b,
  output reg y
);

  always @(*) begin
    #5 y = a & b;
  end

endmodule

