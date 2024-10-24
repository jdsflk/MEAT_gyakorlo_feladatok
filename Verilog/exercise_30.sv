module circuit (
    input logic clka,
    input logic clkb,
    input logic rsta,
    input logic rstb,

    input logic pulsea,

    output logic pulseb
  );

  logic ff_1;
  logic ff_2;
  logic ff_3;
  logic ff_4;

  always @ (posedge clka, negedge rsta)
  begin
    if(~rsta)
      ff_1 <= 1'b0;
    else if (~ff_1)
      ff_1 <= pulsea;
  end

  always @ (posedge clkb, negedge rstb) begin
    if(~rstb) begin
      ff_2 <= 1'b0;
      ff_3 <= 1'b0;
      ff_4 <= 1'b0;
    end
    else begin
      ff_2 <= ff_1;
      ff_3 <= ff_2;
      ff_4 <= ff_3;
    end
  end

  assign pulseb = ff_3 ^ ff_4;

endmodule
