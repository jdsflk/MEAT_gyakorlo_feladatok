module circuit (
    input logic clk,
    input logic rst,
    input logic nul,
    output logic trigger
  );

  parameter N = 2;

  logic trigger_ff;
  logic [7:0] cnt;
  logic finished;

  assign finished = (N - 1) == cnt;

  always @ (posedge clk, negedge rst)
  begin
    if (~rst)
    begin
      cnt <= 8'b0;
      trigger_ff <= 1'b0;
    end
    else
    begin
      trigger_ff <= ~finished;
      if (~nul)
        cnt <= 8'b0;
      else
      begin
        if (finished)
          cnt <= 8'b0;
        else
          cnt <= cnt + 1;
      end
    end
  end

  assign trigger = trigger_ff;

endmodule
