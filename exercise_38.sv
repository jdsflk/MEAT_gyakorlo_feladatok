module circuit (
    input logic clk,
    input logic as_reset_n,
    input logic signal_in,
    input logic [1:0] edge_type,
    output logic [19:0] counter_out
  );

  parameter counter_max = 100000;

  logic in_ff_1;
  logic in_ff_2;
  logic in_ff_3;

  logic [19:0] counter;

  logic [19:0] counter_out_ff;

  logic signal_in_falling_edge;
  logic signal_in_rising_edge;
  logic signal_in_edge;

  logic selected_edge;

  assign signal_in_falling_edge = ~in_ff_2 & in_ff_3;
  assign signal_in_rising_edge = in_ff_2 & ~in_ff_3;
  assign signal_in_edge = in_ff_2 ^ in_ff_3;

  always @ (edge_type, signal_in_edge, signal_in_falling_edge, signal_in_rising_edge)
  begin
    case(edge_type)
      2'b0:
        selected_edge <= signal_in_rising_edge;
      2'b01:
        selected_edge <= signal_in_falling_edge;
      2'b10:
        selected_edge <= signal_in_edge;
      default:
        selected_edge <= 1'b0;
    endcase
  end

  always @ (posedge clk, negedge as_reset_n)
  begin
    if (~as_reset_n)
    begin
      in_ff_1 <= 1'b0;
      in_ff_2 <= 1'b0;
      in_ff_3 <= 1'b0;
      counter <= 20'b0;
      counter_out_ff <= 20'b0;
    end
    else
    begin
      in_ff_1 <= signal_in;
      in_ff_2 <= in_ff_1;
      in_ff_3 <= in_ff_2;
      if (selected_edge)
      begin
        counter <= 20'b0;
        counter_out_ff <= counter;
      end
      else if (counter < counter_max)
        counter <= counter + 1;
    end
  end

  assign counter_out = counter_out_ff;

endmodule
