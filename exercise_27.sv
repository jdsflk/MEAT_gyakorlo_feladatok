module circuit (
    input logic clk,
    input logic reset,

    input logic [7:0] din,
    input logic intr_ack,

    output logic intr,
    output logic [7:0] dout
  );

  logic [7:0] din_ff;
  logic [7:0] dout_ff;
  logic intr_ff;

  logic is_in_interval;

  assign is_in_interval = din_ff > 34 & din_ff < 220;

  always @ (posedge clk, negedge reset)
  begin
    if(~reset)
    begin
      din_ff <= 8'b0;
      dout_ff <= 8'b0;
      intr_ff <= 1'b0;
    end
    else
    begin
      din_ff <= din;
      if (intr_ack)
        intr_ff <= 1'b0;
      else if (is_in_interval & ~intr)
        intr_ff <= 1'b1;
      if (is_in_interval & ~intr)
        dout_ff <= din_ff;
    end
  end

  assign dout = dout_ff;
  assign intr = intr_ff;

endmodule
