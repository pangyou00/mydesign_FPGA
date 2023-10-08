module HC595(
				clk,
				rst_n,
				DS,
				SHCP,
				STCP,
				dat
				);
				
input clk;
input rst_n;
input [7:0]dat;

output reg SHCP;      //绉讳綅瀵勫瓨鍣ㄨ緭鍏ユ椂閽
output reg STCP;		//瀛樺偍瀵勫瓨鍣ㄨ緭鍏ユ椂閽
output reg DS;			//涓茶鏁版嵁杈撳嚭

parameter MAX_CNT = 2;

reg[7:0]dat_temp;
always@(posedge clk)
	dat_temp <= dat;			//閿佸瓨

reg[7:0]CLK_CNT;
always@(posedge clk or negedge rst_n)
	if(!rst_n)
		CLK_CNT <= 1'b0;
	else if(CLK_CNT >= MAX_CNT - 1'b1)
		CLK_CNT <= 1'b0;
	else
		CLK_CNT <= CLK_CNT + 1'b1;

wire EDGE_CLK;
assign EDGE_CLK = (CLK_CNT == 1'b1)? 1'b1:1'b0;

reg[4:0] EDGE_CNT;
always@(posedge clk or negedge rst_n)
	if(!rst_n)
		EDGE_CNT <= 1'b0;
	else if(EDGE_CLK)
		if(EDGE_CNT >= 16)
			EDGE_CNT <= 1'b0;
		else
			EDGE_CNT <= EDGE_CNT + 1'b1;
	else
		EDGE_CNT <= EDGE_CNT;
		
always@(posedge clk or negedge rst_n)
	if(!rst_n)begin
		SHCP <= 1'b0;
		STCP <= 1'b0;
		DS <= 1'b0;
	end
	else case(EDGE_CNT)
		0 : begin SHCP <= 0;STCP <= 0;DS <= dat_temp[7];end
		1 : begin SHCP <= 1;end
 		2 : begin SHCP <= 0;STCP <= 0;DS <= dat_temp[6];end
		3 : begin SHCP <= 1;end
		4 : begin SHCP <= 0;STCP <= 0;DS <= dat_temp[5];end
		5 : begin SHCP <= 1;end	
		6 : begin SHCP <= 0;STCP <= 0;DS <= dat_temp[4];end
		7 : begin SHCP <= 1;end
		8 : begin SHCP <= 0;STCP <= 0;DS <= dat_temp[3];end
		9 : begin SHCP <= 1;end
		10 : begin SHCP <= 0;STCP <= 0;DS <= dat_temp[2];end
		11 : begin SHCP <= 1;end
		12 : begin SHCP <= 0;STCP <= 0;DS <= dat_temp[1];end
		13 : begin SHCP <= 1;end
		14 : begin SHCP <= 0;STCP <= 0;DS <= dat_temp[0];end
		15 : begin SHCP <= 1;end
		16 : begin STCP <= 1;end
		default begin SHCP <= 0;STCP <= 0;DS <= 0;end
	endcase
	
endmodule

		