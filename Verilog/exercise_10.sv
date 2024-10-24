module circuit (
    input logic clk,
    input logic rst,
    output logic trigger
  );

  parameter N = 2;

  logic trigger_ff;
  logic [7:0] cnt;
  logic finished;

  assign finished = (N-1) == cnt;

  always @ (posedge clk, negedge rst) begin
    if (~rst) begin
      trigger_ff <= 1'b0;
      cnt <= 8'b0;
    end
    else begin
      trigger_ff <= ~finished;
      if (~finished) cnt <= cnt + 1;
      else cnt <= 1'b0;
    end
  end

  assign trigger = trigger_ff;

endmodule
