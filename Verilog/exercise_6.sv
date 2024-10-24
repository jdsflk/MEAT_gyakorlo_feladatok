module circuit (
    input logic clk,
    input logic rst,
    input logic nul,
    input logic signal_in,
    output logic [7:0] counter_out
  );

  logic [7:0] counter;
  logic signal_in_ff_1;
  logic signal_in_ff_2;
  logic signal_in_ff_3;

  logic incoming_neg_edge;

  assign incoming_neg_edge = ~signal_in_ff_2 & signal_in_ff_3;

  always @ (posedge clk, negedge rst)
  begin
    if (~rst)
    begin
      counter <= 8'b0;
      signal_in_ff_1 <= 1'b0;
      signal_in_ff_2 <= 1'b0;
      signal_in_ff_3 <= 1'b0;
    end
    else
    begin
      signal_in_ff_1 <= signal_in;
      signal_in_ff_2 <= signal_in_ff_1;
      signal_in_ff_3 <= signal_in_ff_2;
      if (~nul)
        counter <= 8'b0;
      else if (incoming_neg_edge)
        counter <= counter + 1;
    end
  end

  assign counter_out = counter;

endmodule
