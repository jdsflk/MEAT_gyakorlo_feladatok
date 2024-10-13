module circuit (
    input logic clka,
    input logic rsta,
    input logic clkb,
    input logic rstb,

    input logic [7:0] dataa,
    input logic new_dataa,

    output logic [7:0] datab,
    output logic new_datab
  );

  logic [7:0] b_1;
  logic [7:0] b_2;

  logic ff_1;
  logic ff_2;
  logic ff_3;
  logic ff_4;

  assign new_datab = ff_3 & ~ff_4;

  always @ (posedge clka, negedge rsta)
  begin
    if (~rsta)
    begin
      b_1 <= 8'b0;
      ff_1 <= 1'b0;
    end
    else
    begin
      b_1 <= dataa;
      ff_1 <= new_dataa;
    end
  end

  always @ (posedge clkb, negedge rstb)
  begin
    if (~rstb)
    begin
      ff_2 <= 8'b0;
      ff_3 <= 8'b0;
      ff_4 <= 8'b0;
      b_2 <= 8'b0;
    end
    else
    begin
      ff_2 <= ff_1;
      ff_3 <= ff_2;
      ff_4 <= ff_3;
      if (new_datab)
        b_2 <= b_1;
    end
  end

  assign datab = b_2;

endmodule
