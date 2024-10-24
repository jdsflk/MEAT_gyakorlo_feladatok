module circuit (
    input logic clk,
    input logic as_reset_n,
    input logic logic_input,
    output logic fsk_output
  );

  parameter counter_max_0 = 127;
  parameter counter_max_1 = 31;

  logic [19:0] counter;
  logic fsk_ff;

  always @ (posedge clk, negedge as_reset_n)
  begin
    if (~as_reset_n)
    begin
      counter <= 20'b0;
      fsk_ff <= 1'b0;
    end
    else
    begin
      if (~logic_input)
      begin
        if (counter >= counter_max_1)
        begin
          counter <= 20'b0;
          fsk_ff <= ~fsk_ff;
        end
        else
          counter <= counter + 1;
      end
      else
      begin
        if (counter >= counter_max_0)
        begin
          counter <= 20'b0;
          fsk_ff <= ~fsk_ff;
        end
        else
          counter <= counter + 1;
      end
    end
  end

  assign fsk_output = fsk_ff;

endmodule
