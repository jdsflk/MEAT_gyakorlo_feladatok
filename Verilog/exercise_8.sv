module circuit (
    input logic clk,
    input logic reset,
    input logic nul,
    input logic signal_in,
    output logic [7:0] counter_out
  );

  logic [7:0] counter;
  logic signal_in_ff;
  logic incoming_neg_edge;

  assign incoming_neg_edge = ~signal_in & signal_in_ff;

  always @ (posedge clk, negedge reset)
  begin
    if (~reset)
    begin
      counter <= 8'b0;
      signal_in_ff <= 1'b0;
    end
    else
    begin
      signal_in_ff <= signal_in;
      if (~nul)
        counter <= 8'b0;
      else if(incoming_neg_edge)
        counter <= counter + 1;
    end
  end

  assign counter_out = counter;

endmodule
