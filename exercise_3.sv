module circuit (
    input logic clk,
    input logic nul,
    input logic reset,
    input logic signal_in,
    output logic [7:0] counter_out
  );

  logic [7:0] counter;
  logic signal_in_1;
  logic incoming_pos_edge;

  assign incoming_pos_edge = signal_in & ~signal_in_1;

  always @ (posedge clk, negedge reset)
  begin
    if (~reset)
    begin
      counter <= 8'b0;
      signal_in_1 <= 1'b0;
    end
    else
    begin
      signal_in_1 <= signal_in;
      if (nul)
        counter <= 8'b0;
      else if (incoming_pos_edge)
        if (counter < 255)
          counter <= counter + 1;
    end
  end
  assign counter_out = counter;
endmodule
