module MUX_B(
    a0,
    a1,
    a2,
    a3,
    out,
    sel
);
    input [8 - 1: 0] a0, a1, a2, a3;
    input [1 : 0] sel;

    output [8 - 1 : 0] out;

    assign out =    sel == 2'b00 ? a0 :
                    sel == 2'b01 ? a1 :
                    sel == 2'b10 ? a2 :
                    sel == 2'b11 ? a3 :
                    8'bZ;    

endmodule