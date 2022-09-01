`timescale 1ns/10ps

module ELA(clk, rst, in_data, data_rd, req, wen, addr, data_wr, done);

	input					clk;
	input					rst;
	input			[7:0]	in_data;
	input			[7:0]	data_rd;

	output	reg				req;
	output	reg				wen;
	output	reg		[9:0]	addr;
	output	reg		[7:0]	data_wr;
	output	reg				done;

reg					[7:0]	S_buffer	[31:0];
reg					[7:0]	L_buffer	[2:0];
reg					[8:0]	result;

reg					[1:0]	control;
reg					[5:0]	timer_s;

wire				[8:0]	d11;
wire				[8:0]	d22;
wire				[8:0]	d33;
wire				[7:0]	d1;
wire				[7:0]	d2;
wire				[7:0]	d3;

assign 				d11 = (L_buffer[2] - S_buffer[0]);
assign				d22 = (L_buffer[1] - S_buffer[1]);
assign				d33 = (L_buffer[0] - S_buffer[2]);

assign 				d1 = d11[8] ? -d11[7:0] : d11[7:0];
assign				d2 = d22[8] ? -d22[7:0] : d22[7:0];
assign				d3 = d33[8] ? -d33[7:0] : d33[7:0];


reg					[1:0]	min;

reg         		[1:0]	state;
reg         		[1:0]	next_state;

parameter   		Rowf      	= 2'd0;
parameter   		comp      	= 2'd1;
parameter   		read       	= 2'd2;
parameter   		fish       	= 2'd3;



always @(posedge clk or posedge rst)
begin
	if (rst)
	begin
		timer_s <= 6'd0;
	end

	else if ((control == 2'd0 && timer_s == 6'd34) || (control == 2'd1 && timer_s == 6'd35) ||(control == 2'd2 && timer_s == 6'd32))
	begin
		timer_s <= 6'd0;
	end

	else
	begin
		timer_s <= timer_s + 6'd1;
	end
end

always @(posedge clk or posedge rst)
begin
	if (rst)
	begin
		req <= 1'd0;
	end

	else if (timer_s == 6'd0 && !(control == 2'd2))
	begin
		req <= 1'd1;
	end

	else
	begin
		req <= 1'd0;
	end
end

always @(posedge clk or posedge rst)
begin
	if (rst)
	begin
		S_buffer[0] <= 8'd0;
		S_buffer[1] <= 8'd0;
		S_buffer[2] <= 8'd0;
		S_buffer[3] <= 8'd0;
		S_buffer[4] <= 8'd0;
		S_buffer[5] <= 8'd0;
		S_buffer[6] <= 8'd0;
		S_buffer[7] <= 8'd0;
		S_buffer[8] <= 8'd0;
		S_buffer[9] <= 8'd0;
		S_buffer[10] <= 8'd0;
		S_buffer[11] <= 8'd0;
		S_buffer[12] <= 8'd0;
		S_buffer[13] <= 8'd0;
		S_buffer[14] <= 8'd0;
		S_buffer[15] <= 8'd0;
		S_buffer[16] <= 8'd0;
		S_buffer[17] <= 8'd0;
		S_buffer[18] <= 8'd0;
		S_buffer[19] <= 8'd0;
		S_buffer[20] <= 8'd0;
		S_buffer[21] <= 8'd0;
		S_buffer[22] <= 8'd0;
		S_buffer[23] <= 8'd0;
		S_buffer[24] <= 8'd0;
		S_buffer[25] <= 8'd0;
		S_buffer[26] <= 8'd0;
		S_buffer[27] <= 8'd0;
		S_buffer[28] <= 8'd0;
		S_buffer[29] <= 8'd0;
		S_buffer[30] <= 8'd0;
		S_buffer[31] <= 8'd0;
	end

	else if ((control == 2'd0 && timer_s >= 6'd33) || (control == 2'd1 && timer_s == 6'd0) || (control == 2'd2 && timer_s == 6'd32))
	begin
		S_buffer[0] <= S_buffer[0];
		S_buffer[1] <= S_buffer[1];
		S_buffer[2] <= S_buffer[2];
		S_buffer[3] <= S_buffer[3];
		S_buffer[4] <= S_buffer[4];
		S_buffer[5] <= S_buffer[5];
		S_buffer[6] <= S_buffer[6];
		S_buffer[7] <= S_buffer[7];
		S_buffer[8] <= S_buffer[8];
		S_buffer[9] <= S_buffer[9];
		S_buffer[10] <= S_buffer[10];
		S_buffer[11] <= S_buffer[11];
		S_buffer[12] <= S_buffer[12];
		S_buffer[13] <= S_buffer[13];
		S_buffer[14] <= S_buffer[14];
		S_buffer[15] <= S_buffer[15];
		S_buffer[16] <= S_buffer[16];
		S_buffer[17] <= S_buffer[17];
		S_buffer[18] <= S_buffer[18];
		S_buffer[19] <= S_buffer[19];
		S_buffer[20] <= S_buffer[20];
		S_buffer[21] <= S_buffer[21];
		S_buffer[22] <= S_buffer[22];
		S_buffer[23] <= S_buffer[23];
		S_buffer[24] <= S_buffer[24];
		S_buffer[25] <= S_buffer[25];
		S_buffer[26] <= S_buffer[26];
		S_buffer[27] <= S_buffer[27];
		S_buffer[28] <= S_buffer[28];
		S_buffer[29] <= S_buffer[29];
		S_buffer[30] <= S_buffer[30];
		S_buffer[31] <= S_buffer[31];
	end

	else if (control == 2'd2)
	begin
		S_buffer[0] <= S_buffer[31];
		S_buffer[1] <= S_buffer[0];
		S_buffer[2] <= S_buffer[1];
		S_buffer[3] <= S_buffer[2];
		S_buffer[4] <= S_buffer[3];
		S_buffer[5] <= S_buffer[4];
		S_buffer[6] <= S_buffer[5];
		S_buffer[7] <= S_buffer[6];
		S_buffer[8] <= S_buffer[7];
		S_buffer[9] <= S_buffer[8];
		S_buffer[10] <= S_buffer[9];
		S_buffer[11] <= S_buffer[10];
		S_buffer[12] <= S_buffer[11];
		S_buffer[13] <= S_buffer[12];
		S_buffer[14] <= S_buffer[13];
		S_buffer[15] <= S_buffer[14];
		S_buffer[16] <= S_buffer[15];
		S_buffer[17] <= S_buffer[16];
		S_buffer[18] <= S_buffer[17];
		S_buffer[19] <= S_buffer[18];
		S_buffer[20] <= S_buffer[19];
		S_buffer[21] <= S_buffer[20];
		S_buffer[22] <= S_buffer[21];
		S_buffer[23] <= S_buffer[22];
		S_buffer[24] <= S_buffer[23];
		S_buffer[25] <= S_buffer[24];
		S_buffer[26] <= S_buffer[25];
		S_buffer[27] <= S_buffer[26];
		S_buffer[28] <= S_buffer[27];
		S_buffer[29] <= S_buffer[28];
		S_buffer[30] <= S_buffer[29];
		S_buffer[31] <= S_buffer[30];
	end

	else if (timer_s <= 6'd32)
	begin
		S_buffer[0] <= in_data;
		S_buffer[1] <= S_buffer[0];
		S_buffer[2] <= S_buffer[1];
		S_buffer[3] <= S_buffer[2];
		S_buffer[4] <= S_buffer[3];
		S_buffer[5] <= S_buffer[4];
		S_buffer[6] <= S_buffer[5];
		S_buffer[7] <= S_buffer[6];
		S_buffer[8] <= S_buffer[7];
		S_buffer[9] <= S_buffer[8];
		S_buffer[10] <= S_buffer[9];
		S_buffer[11] <= S_buffer[10];
		S_buffer[12] <= S_buffer[11];
		S_buffer[13] <= S_buffer[12];
		S_buffer[14] <= S_buffer[13];
		S_buffer[15] <= S_buffer[14];
		S_buffer[16] <= S_buffer[15];
		S_buffer[17] <= S_buffer[16];
		S_buffer[18] <= S_buffer[17];
		S_buffer[19] <= S_buffer[18];
		S_buffer[20] <= S_buffer[19];
		S_buffer[21] <= S_buffer[20];
		S_buffer[22] <= S_buffer[21];
		S_buffer[23] <= S_buffer[22];
		S_buffer[24] <= S_buffer[23];
		S_buffer[25] <= S_buffer[24];
		S_buffer[26] <= S_buffer[25];
		S_buffer[27] <= S_buffer[26];
		S_buffer[28] <= S_buffer[27];
		S_buffer[29] <= S_buffer[28];
		S_buffer[30] <= S_buffer[29];
		S_buffer[31] <= S_buffer[30];
	end
end

always @(posedge clk or posedge rst) 
begin
	if (rst) 
	begin
		L_buffer[0] <= 8'd0;
		L_buffer[2] <= 8'd0;
		L_buffer[1] <= 8'd0;
	end

	else if ((control == 2'd0 && timer_s >= 6'd33) || (control == 2'd1 && timer_s == 6'd0) || (control == 2'd2 && timer_s == 6'd32))
	begin
		L_buffer[0] <= L_buffer[0];
		L_buffer[2] <= L_buffer[2];
		L_buffer[1] <= L_buffer[1];
	end

	else if (control == 2'd2)
	begin
		L_buffer[0] <= L_buffer[2];
		L_buffer[2] <= L_buffer[1];
		L_buffer[1] <= L_buffer[0];
	end

	else if (timer_s <= 6'd32)
	begin
		L_buffer[0] <= S_buffer[31];
		L_buffer[2] <= L_buffer[1];
		L_buffer[1] <= L_buffer[0];
	end
end

always @(*)
begin
	if (rst)
	begin
		min = 2'd0;
	end

	else
	begin
		if (timer_s == 6'd3)
		begin
			min = 2'd2;
		end

		else if(d1 <= d3)
		begin
			if(d2 <= d1)
			begin
				min = 2'd2;
			end

			else 
			begin
				min = 2'd1;
			end
		end

		else 
		begin
			if(d2 <= d3)
			begin
				min = 2'd2;
			end

			else 
			begin
				min = 2'd3;
			end
		end
	end
end

always @(posedge clk or posedge rst)
begin
	if (rst) 
	begin
		result <= 9'd2;
	end

	else if (control == 2'd1)
	begin
		if (timer_s == 6'd34)
		begin
			result <= ((S_buffer[0] + L_buffer[0]) >> 1);
		end

		else
		begin
			case(min)

			2'd0: result <= 9'd0;
			2'd1: result <= ((S_buffer[0] + L_buffer[2]) >> 1);
			2'd2: result <= ((S_buffer[1] + L_buffer[1]) >> 1);
			2'd3: result <= ((S_buffer[2] + L_buffer[0]) >> 1);

			endcase
		end
	end
end

always @(posedge clk or posedge rst)
 begin
	if (rst) 
	begin
		wen <= 1'd0;
	end

	else if (control == 2'd3)
	begin
		wen <= 1'd0;
	end

	else
	begin
		wen <= 1'd1;
	end
end

always @(posedge clk or posedge rst) 
begin
	if (rst) 
	begin
		addr <= 10'd0;
	end

	else if((control == 2'd0 && timer_s <= 6'd2) || (control == 2'd1 && timer_s <= 6'd4))
	begin
		addr <= addr;
	end

	else 
	begin
		addr <= addr + 10'd1;	
	end
end

always @(posedge clk or posedge rst) 
begin
	if (rst) 
	begin
		data_wr <= 8'd0;
	end

	else if (control == 2'd0)
	begin
		data_wr <= S_buffer[0];
	end

	else if (control == 2'd1)
	begin
		data_wr <= result;
	end

	else
	begin
		data_wr <= S_buffer[31];
	end
end

always @(posedge clk or posedge rst) 
begin
	if (rst) 
	begin
		done <= 1'd0;
	end

	else if (control == 2'd3) 
	begin
		done <= 1'd1;
	end
end

// state register
always @(posedge clk or posedge rst)
begin
    if (rst)	state <= Rowf;

    else 		state <= next_state;
end

// next state logic
always @(*) 
begin
    case(state)

    	Rowf :
    	begin
    		if(timer_s == 6'd34) next_state = comp;
    		else                 next_state = Rowf;
    	end
    	comp :
    	begin
    		if(timer_s == 6'd35) next_state = read;
    		else                 next_state = comp;
    	end
    	read :
    	begin
    		if(addr == 10'd990)      next_state = fish;
    		else if(timer_s == 6'd32)next_state = comp;
    		else                     next_state = read;
    	end
    	fish : next_state = fish;

    endcase
end

// output logic
always @(*) 
begin
    case(state)

    	Rowf : control = 2'd0;
    	comp : control = 2'd1;
    	read : control = 2'd2;
    	fish : control = 2'd3;

    endcase
end

endmodule