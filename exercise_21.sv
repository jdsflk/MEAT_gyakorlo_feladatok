module circuit (
    input logic clk,
    input logic reset,
    input logic pause,
    input logic dir,
    input logic load,
    input logic [7:0] parallel_in,

    output logic [7:0] counter_out
  );

  logic [7:0] counter;

  logic pause_ff_1;
  logic pause_ff_2;
  logic dir_ff_1;
  logic dir_ff_2;
  logic load_ff_1;
  logic load_ff_2;

  always @ (posedge clk, negedge reset)
  begin
    if (~reset)
    begin
      counter <= 8'b0;
      pause_ff_1 <= 1'b0;
      pause_ff_2 <= 1'b0;
      dir_ff_1 <= 1'b0;
      dir_ff_2 <= 1'b0;
      load_ff_1 <= 1'b0;
      load_ff_2 <= 1'b0;
    end
    else
    begin
      pause_ff_1 <= pause;
      pause_ff_2 <= pause_ff_1;
      dir_ff_1 <= dir;
      dir_ff_2 <= dir_ff_1;
      load_ff_1 <= load;
      load_ff_2 <= load_ff_1;
      if (load_ff_2)
        counter <= parallel_in;
      else if (~pause_ff_2)
      begin
        if (dir_ff_2)
          counter <= counter + 255;
        else
          counter <= counter + 1;
      end
    end
  end

  assign counter_out = counter;

endmodule
