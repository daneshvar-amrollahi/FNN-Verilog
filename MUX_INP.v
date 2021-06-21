module MUX_INP(
    sel_inp,
    sel_reg,
    inp,
    reg_h,
    out
);
    input sel_inp, sel_reg;
    input [62 * 8 - 1:0] inp;
    input [30 * 8 - 1:0] reg_h;

    output reg[62 * 8 - 1:0] out;

    always @(*)
    begin
        if (sel_inp)
            out = inp;
        else
        if (sel_reg)
            out = {256'b0 ,reg_h};
        else
            out = 496'bZ;
    end

endmodule