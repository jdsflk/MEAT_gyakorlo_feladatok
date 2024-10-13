module circuit (
    input logic clka,
    input logic rsta,
    input logic clkb,
    input logic rstb,
    input logic pulsea,

    output logic pulseb,
    output logic busy
  );

  logic ff_1;
  logic ff_2;
  logic ff_3;
  logic ff_4;
  logic ff_5;
  logic ff_6;

  always @ (posedge clka, negedge rsta)
  begin
    if(~rsta)
    begin
      ff_1 <= 1'b0;
      ff_5 <= 1'b0;
      ff_6 <= 1'b0;
    end
    else
    begin
      ff_5 <= ff_3;
      ff_6 <= ff_5;

      if (pulsea)
        ff_1 <= 1'b1;
      else if (ff_6)
        ff_1 <= 1'b0;
    end
  end

  always @ (posedge clkb, negedge rstb)
  begin
    if (~rstb)
    begin
      ff_2 <= 1'b0;
      ff_3 <= 1'b0;
      ff_4 <= 1'b0;
    end
    else
    begin
      ff_2 <= ff_1;
      ff_3 <= ff_2;
      ff_4 <= ff_3;
    end
  end

  assign busy = ff_6 & ff_1;
  assign pulseb = ff_3 & ~ff_4;

endmodule
