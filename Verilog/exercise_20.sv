module circuit (
    input logic clk,
    input logic reset,
    input logic dir,
    input logic pause,
    input logic load,
    input logic [7:0] parallel_in,
    output logic [7:0] counter_out
  );

  logic [7:0] counter;
  logic term;

  assign term = 1 ? dir == 1 : 255;

  always @ (posedge clk, negedge reset)
  begin
    if (~reset)
      counter <= 8'b0;
    else
    begin
      if (load)
        counter <= parallel_in;
      else
      begin
        if (~pause)
        begin
          counter <= counter + term;
        end
      end
    end
  end
  assign counter_out = counter;

endmodule
