module bo_mem(
    bo0, bo1, bo2, bo3, bo4, bo5, bo6, bo7, bo8, bo9
);
    output [7 : 0] bo0, bo1, bo2, bo3, bo4, bo5, bo6, bo7, bo8, bo9;

    assign bo0 = 8'b10000011;
    assign bo1 = 8'b10101110;
    assign bo2 = 8'b00100011;
    assign bo3 = 8'b00000010;
    assign bo4 = 8'b00010101;
    assign bo5 = 8'b00000011;
    assign bo6 = 8'b10011111;
    assign bo7 = 8'b11000110;
    assign bo8 = 8'b01010110;
    assign bo9 = 8'b00000111;
endmodule