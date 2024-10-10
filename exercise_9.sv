module circuit (
    input logic clk,
    input logic rst,
    output logic trigger
);

parameter N = 2;

logic [7:0] cnt;
logic trigger_ff;
logic finished;

assign finished = (N-1) == cnt;

always @ (posedge clk, negedge rst) begin
    if(~rst) begin
        cnt <= 8'b0;
        trigger_ff <= 1'b0;
    end
    else begin
        trigger_ff <= finished;
        if (finished) cnt <= 1'b0;
        else cnt <= cnt + 1;
    end 
end

assign trigger = trigger_ff;

endmodule