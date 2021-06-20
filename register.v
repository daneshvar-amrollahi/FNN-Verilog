module register8(
    in,
    out,
    clk,
    rst,
    ld
);
    input [7 : 0] in;
    output reg [7 : 0] out;
    input clk, rst;
    input ld;

    always @(posedge clk, posedge rst) begin
        if (rst)
            out <= 8'b0000_0000;
        else
            if (ld)
                out <= in;
    end

endmodule