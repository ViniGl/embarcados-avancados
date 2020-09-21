
module niosLab2 (
	clk_clk,
	dir_export,
	en_export,
	leds_export,
	motor_export);	

	input		clk_clk;
	input		dir_export;
	input		en_export;
	output	[5:0]	leds_export;
	output	[3:0]	motor_export;
endmodule
