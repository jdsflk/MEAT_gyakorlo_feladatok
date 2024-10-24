module circuit (
    input logic clk,
    input logic reset,
    input logic signal_in,
    output logic new_data,
    output logic [7:0] dout
  );

  logic signal_in_ff_1;
  logic signal_in_ff_2;
  logic signal_in_ff_3;

  logic [7:0] counter_ff;
  logic [7:0] dout_ff;

  assign new_data = signal_in_ff_3 & ~signal_in_ff_2;

  always @ (posedge clk, negedge reset)
  begin
    if(~reset)
    begin
      signal_in_ff_1 <= 8'b0;
      signal_in_ff_2 <= 8'b0;
      signal_in_ff_3 <= 8'b0;

      counter_ff <= 8'b0;
      dout_ff <= 8'b0;
    end
    else
    begin
      signal_in_ff_1 <= signal_in;
      signal_in_ff_2 <= signal_in_ff_1;
      signal_in_ff_3 <= signal_in_ff_2;
      if(new_data)
      begin
        dout_ff <= counter_ff;
        counter_ff <= 8'b0;
      end
      else
        counter_ff <= counter_ff + 1;
    end
  end

  assign dout = dout_ff;
endmodule
