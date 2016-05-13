module FIR_Gaussian_Lowpass(Data_out, Data_in, clock, reset)

	parameter	order = 8,
				word_size_in  = 8,
				word_size_out = 2 * word_size_in + 2,
				b0 = 8'd7,
				b1 = 8'd17,
				b2 = 8'd32,
				b3 = 8'd46,
				b4 = 8'd52,
				b5 = 8'd46,
				b6 = 8'd32,
				b7 = 8'd17,
				b8 = 8'd7;	
	
	output	[word_size_out-1:0]	Data_out;
	input	[word_size_in -1:0]	Data_in;
	input	clock, reset;
	
	reg		[word_size_in -1:0]	Sample[1:order];
	integer	k;
	
	assign	Data_out = b0 * Data_in + b1 * Sample[1] + b2 * Sample[2]
						+ b3 * Sample[3] + b4 * Sample[4]
						+ b5 * Sample[5] + b6 * Sample[6]
						+ b7 * Sample[7] + b8 * Sample[8];
	
	always @(posedge clock)
		if(reset==1)
		begin
			for(k=1;k<=orger;k=k+1)
				Sample[k]	<= 0;
		end
		
		alse
		begin
			Sample[1]	<= Data_in;
			for(k=2;k<=order;k=k+1)
				Sample[k]	<= Sample[k-1];
		end
endmodule
