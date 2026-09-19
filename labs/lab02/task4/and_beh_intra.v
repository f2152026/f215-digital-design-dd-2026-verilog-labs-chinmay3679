// and_beh_intra.v
// 2-input AND gate, BEHAVIORAL style, with an INTRA-assignment delay:
// a & b is evaluated now, only the write into y is delayed.

module and_beh_intra (
  input      a,
  input      b,
  output reg y
);

  always @(*) begin
    y = #5 a & b;
  end

endmodule



