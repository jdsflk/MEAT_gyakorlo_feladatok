module circuit (
    input logic clk,
    input logic as_reset_n,
    input logic input_signal,
    output logic debounced_output
  );

  parameter counter_max = 10000;
  logic [19:0] counter;
  logic out_ff;
  logic in_ff_1;
  logic in_ff_2;
  logic in_ff_3;
  logic input_edge;

  assign input_edge = in_ff_3 ^ in_ff_2;

  always @ (posedge clk, negedge as_reset_n)
  begin
    if (~as_reset_n)
    begin
      out_ff <= 1'b0;
      in_ff_1 <= 1'b0;
      in_ff_2 <= 1'b0;
      in_ff_3 <= 1'b0;
      counter <= 20'b0;
    end
    else
    begin
      in_ff_1 <= input_signal;
      in_ff_2 <= in_ff_1;
      in_ff_3 <= in_ff_2;
      if (input_edge)
        counter <= 19'b0;
      else if (counter < counter_max)
        counter <= counter + 1;
      if (counter == counter_max)
        out_ff <= in_ff_3;
    end
  end

  assign debounced_output = out_ff;

endmodule
