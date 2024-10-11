module circuit (
    input logic clk,
    input logic rst,
    input logic reset,
    input logic nul,
    output logic trigger
  );

  parameter N = 2;

  logic trigger_ff;
  logic nul_f;
  logic nul_ff;
  logic [7:0] cnt;

  logic finished;

  assign finished = (N - 1) == cnt;

  always @ (posedge clk, negedge reset) begin
    if (~reset) begin
      nul_f <= 1'b0;
      nul_ff <= 1'b0;
    end
    else begin
      nul_f <= nul;
      nul_ff <= nul_f;
    end
  end

  always @ (posedge clk, posedge rst)
  begin
    if(rst)
    begin
      trigger_ff <= 1'b0;
      cnt <= 8'b0;
    end
    else
    begin
      trigger_ff <= finished;
      if (nul_ff)
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
