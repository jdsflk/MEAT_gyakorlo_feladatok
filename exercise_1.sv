module circuit (
	input logic signal_in,
	input logic clk,
	input logic nul,
	input logic reset,
  	output logic [7:0] counter_out
);

	logic signal_in_d;
	logic signal_in_dd;
	logic signal_in_ddd;
  
  	logic [7:0] counter;

	logic increment;

	assign increment = ~signal_in_ddd & signal_in_dd;

	always @ (posedge clk, negedge reset)
	begin
		if (reset == 1'b0)
		begin
			signal_in_d <= 1'b0;
			signal_in_dd <= 1'b0;
			signal_in_ddd <= 1'b0;
			counter <= 8'b0;
		end
		else 
		begin
			signal_in_d <= signal_in;
			signal_in_dd <= signal_in_d;
			signal_in_ddd <= signal_in_dd;
			if (nul) counter <= 0;
			else begin
				if(increment) begin
					if(counter < 255) counter <= counter + 1;
				end          
			end
		end
	end
	
	assign counter_out = counter;
endmodule