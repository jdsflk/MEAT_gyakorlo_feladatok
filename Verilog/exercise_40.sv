module circuit (
    input logic clk,
    input logic as_reset_n,
    input logic fsk_input,

    output logic fsk_input_present,
    output logic logic_output
  );

  parameter counter_max_0 = 127;
  parameter counter_max_1 = 31;

  logic in_ff_1;
  logic in_ff_2;
  logic in_ff_3;

  logic fsk_input_rising;

  logic [19:0] counter;
  logic [19:0] counter_reached;

  logic fsk_input_present_ff;
  logic logic_output_ff;

  assign fsk_input_rising = in_ff_2 & ~in_ff_3;

  always @ (posedge clk, negedge as_reset_n)
  begin
    if (~as_reset_n)
    begin
      in_ff_1 <= 1'b0;
      in_ff_2 <= 1'b0;
      in_ff_3 <= 1'b0;
      counter <= 20'b0;
      counter_reached <= 20'b0;
      fsk_input_present_ff <= 1'b0;
      logic_output_ff <= 1'b0;
    end
    else
    begin
      in_ff_1 <= fsk_input;
      in_ff_2 <= in_ff_1;
      in_ff_3 <= in_ff_2;
      if (fsk_input_rising)
      begin
        counter <= 20'b0;
        counter_reached <= counter;
      end
      else if (counter < counter_max_0)
        counter <= counter + 1;
        fsk_input_present_ff <= ~(counter == counter_max_0);
        logic_output_ff <= ~(counter_reached >= counter_max_1);
    end
  end

  assign fsk_input_present = fsk_input_present_ff;
  assign logic_output = logic_output_ff;

endmodule
