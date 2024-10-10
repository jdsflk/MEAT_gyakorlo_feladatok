module circuit (
    input logic clk,
    input logic signal_in,
    input logic reset,
    input logic nul,
    output logic [7:0] counter_out
  );

  logic [7:0] counter;
  logic signal_in_1;
  logic signal_in_2;
  logic signal_in_3;

  logic incoming_neg_edge;

  assign incoming_neg_edge = ~signal_in_2 & signal_in_3;

  always @ (posedge clk, negedge reset)
  begin
    if (~reset)
    begin
      signal_in_1 <= 1'b0;
      signal_in_2 <= 1'b0;
      signal_in_3 <= 1'b0;
      counter <= 8'b0;
    end
    else
    begin
      signal_in_1 <= signal_in;
      signal_in_2 <= signal_in_1;
      signal_in_3 <= signal_in_2;
      if (~nul)
        counter <= 8'b0;
      else if (incoming_neg_edge)
        if (counter < 255)
          counter <= counter + 1;
    end
  end

  assign counter_out = counter;
endmodule
