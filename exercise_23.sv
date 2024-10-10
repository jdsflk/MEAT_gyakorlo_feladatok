module circuit (
    input logic clk,
    input logic reset,

    input logic load,
    input logic [7:0] parallel_in,
    input logic pause,
    input logic dir,

    output logic [7:0] shreg_out
  );

  logic [7:0] shreg;

  always @ (posedge clk, negedge reset)
  begin
    if (~reset)
      shreg <= 8'b0;
    else
    begin
      if(load)
        shreg <= parallel_in;
      else if (~pause)
      begin
        if (dir)
          shreg <= {shreg[6:0], 1'b1};
        else
          shreg <= {1'b1, shreg[7:1]};
      end
    end
  end

  assign shreg_out = shreg;

endmodule
