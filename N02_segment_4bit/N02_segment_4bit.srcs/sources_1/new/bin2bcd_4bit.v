module bin2bcd_4bit(clk, rst, binary, bcd);
input clk, rst;
input [3:0] binary;
output reg [7:0] bcd;

always @(posedge clk or negedge rst) begin
    if(!rst)
        bcd <= 8'b00000000;
    else
        case(binary)
            0 : bcd <= 8'b00000000;
            1 : bcd <= 8'b00000001;
            2 : bcd <= 8'b00000010;
            3 : bcd <= 8'b00000011;
            4 : bcd <= 8'b00000100;
            5 : bcd <= 8'b00000101;
            6 : bcd <= 8'b00000110;
            7 : bcd <= 8'b00000111;
            8 : bcd <= 8'b00001000;
            9 : bcd <= 8'b00001001;
            10 : bcd <= 8'b00010000;
            11 : bcd <= 8'b00010001;
            12 : bcd <= 8'b00010010;
            13 : bcd <= 8'b00010011;
            14 : bcd <= 8'b00010100;
            15 : bcd <= 8'b00010101;
        endcase
end


endmodule
