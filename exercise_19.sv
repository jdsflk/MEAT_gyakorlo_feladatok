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
          if (dir)
            counter <= counter + 255;
          else
            counter <= counter + 1;
        end
      end
    end
  end

  assign counter_out = counter;

endmodule
