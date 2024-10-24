module circuit (
    input logic clk,
    input logic as_reset_n,
    input logic signal_in,
    output logic signal_present
  );

  parameter counter_max = 10000;

  logic in_ff_1;
  logic in_ff_2;
  logic in_ff_3;
  logic [19:0] counter;
  logic presence_edge;

  assign presence_edge = in_ff_3 ^ in_ff_2;

  always @ (posedge clk, negedge as_reset_n)
  begin
    if(~as_reset_n)
    begin
      in_ff_1 <= 1'b0;
      in_ff_2 <= 1'b0;
      in_ff_3 <= 1'b0;
      counter <= 20'b0;
    end
    else
    begin
      in_ff_1 <= signal_in;
      in_ff_2 <= in_ff_1;
      in_ff_3 <= in_ff_2;
      if (presence_edge)
        counter <= counter_max;
      else if (counter > 0)
        counter <= counter + 1048575;
    end
  end

  assign signal_present = counter != 20'b0;

endmodule
