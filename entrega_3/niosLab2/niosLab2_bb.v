
module niosLab2 (
	clk_clk,
	leds_name,
	pio_1_switchs_export,
	pio_2_button_export,
	reset_reset_n,
	motor_phase_writeresponsevalid_n);	

	input		clk_clk;
	output	[3:0]	leds_name;
	input	[3:0]	pio_1_switchs_export;
	input		pio_2_button_export;
	input		reset_reset_n;
	output	[3:0]	motor_phase_writeresponsevalid_n;
endmodule
