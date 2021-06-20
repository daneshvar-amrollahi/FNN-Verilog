module counter(
    clk,
    rst,
    cnt,
    cnten
);
    output reg [9 : 0] cnt;
    input clk, rst, cnten;

    always @(posedge clk, posedge rst)
    begin
        if (rst)
            cnt <= 10'b00000_00000;        
        else
        if (cnten)
            cnt <= cnt + 1;
    end

endmodule