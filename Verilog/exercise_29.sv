module circuit (
    input logic clka,
    input logic rsta,
    input logic clkb,
    input logic rstb,

    input logic dataa,
    output logic datab
  );

  logic ff_1;
  logic ff_2;
  logic ff_3;

  always @ (posedge clka, negedge rsta)
  begin
    if(~rsta)
      ff_1 <= 1'b0;
    else
      ff_1 <= dataa;
  end

  always @ (posedge clkb, negedge rstb) begin
    if(~rstb) begin
        ff_2 <= 1'b0;
        ff_3 <= 1'b0;
    end
    else begin
        ff_2 <= ff_1;
        ff_3 <= ff_2;
    end
  end

  assign datab = ff_3;
endmodule
