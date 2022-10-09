module segment_4bit(clk, rst, in, seg_data, seg_sel);
input clk, rst;
input in;
wire button;
reg [3:0] state_bin;
wire [7:0] state_bcd;
reg [3:0] bcd;
output reg [7:0] seg_sel;
output reg [7:0] seg_data;

oneshot U1(clk, rst, in, button);
bin2bcd_4bit B1(clk, rst, state_bin, state_bcd);

always @(posedge clk or negedge rst) begin // counter module
    if(!rst)
        state_bin <= 4'b0000;
    else if(button) begin
        if(state_bin == 4'b1111)
            state_bin <= 4'b0000;
        else
            state_bin <= state_bin + 1;
    end
end

always @(*) begin // segment module
    if(!rst)
        seg_data <= 8'b00000000;
    else
        case(bcd)
            0 : seg_data <= 8'b11111100;
            1 : seg_data <= 8'b01100000;
            2 : seg_data <= 8'b11011010;
            3 : seg_data <= 8'b11110010;
            4 : seg_data <= 8'b01100110;
            5 : seg_data <= 8'b10110110;
            6 : seg_data <= 8'b10111110;
            7 : seg_data <= 8'b11100100;
            8 : seg_data <= 8'b11111110;
            9 : seg_data <= 8'b11110110;
        endcase
end

always @(posedge clk or negedge rst) begin // segment array transition
    if(!rst)
        seg_sel <= 8'b11111110;
    else begin
        seg_sel <= {seg_sel[6:0], seg_sel[7]};
    end
end

always @(*) begin // segment array 한개만 돌림
    if(!rst)
        bcd <= 4'b0000;
    else
        case(seg_sel)
            8'b11111110 : bcd <= state_bcd[3:0];
            8'b11111101 : bcd <= state_bcd[7:4];
            8'b11111011 : bcd <= 4'b0000;
            8'b11110111 : bcd <= 4'b0000;
            8'b11101111 : bcd <= 4'b0000;
            8'b11011111 : bcd <= 4'b0000;
            8'b10111111 : bcd <= 4'b0000;
            8'b01111111 : bcd <= 4'b0000;
            default : bcd <= 4'b0000;
        endcase
end
endmodule

