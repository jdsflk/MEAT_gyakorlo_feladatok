module circuit (
    input logic clka,
    input logic rsta,
    input logic clkb,
    input logic clkb,

    input logic [7:0] dataa,
    input logic new_dataa,

    output logic [7:0] datab,
    output logic new_datab,
    output logic acka
  );

  logic [7:0] b_1;
  logic [7:0] b_2;

  logic ff_1;
  logic ff_2;
  logic ff_3;
  logic ff_4;
  logic ff_5;
  logic ff_6;

  logic ackb;

  assign ackb = ff_3;

  always @ (posedge clka, negedge rsta)
  begin
    if (~rsta)
    begin
      ff_1 <= 1'b0;
      ff_5 <= 1'b0;
      ff_6 <= 1'b0;
      b_1 <= 8'b0;
    end
    else
    begin
      b_1 <= dataa;
      ff_5 <= ff_3;
      ff_6 <= ff_5;
      if (new_dataa)
        ff_1 <= 1'b1;
      else if (ff_6)
        ff_1 <= 1'b0;
    end
  end

  always @ (posedge clkb, negedge rstb)
  begin
    if(~rstb)
    begin
      ff_2 <= 1'b0;
      ff_3 <= 1'b0;
      ff_4 <= 1'b0;
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

  assign new_datab = ackb & ~ff_4;
  assign acka = ff_1 | ff_6;
  assign datab = b_2;
endmodule
