module get_max(
    in,    
    enable,

    out 
);
    input [80 - 1 : 0] in;

    wire n0 = in[7 : 0];
    wire n1 = in[15 : 8];
    wire n2 = in[23 : 16];
    wire n3 = in[31 : 24];
    wire n4 = in[39 : 32];
    wire n5 = in[47 : 40];
    wire n6 = in[55 : 48];
    wire n7 = in[63 : 56];
    wire n8 = in[71 : 64];
    wire n9 = in[79 : 72];

    output [3 : 0] out; //0 to 9
    always @(*)
    begin
        if (n0 >= n1 && n0 >= n2 && n0 >= n3 && n0 >= n4 && n0 >= n5 && n0 >= n6 && n0 >= n7 && n0 >= n8 && n0 >= n9)
            out = 4'd0;
        else

        if (n1 >= n0 && n1 >= n2 && n1 >= n3 && n1 >= n4 && n1 >= n5 && n1 >= n6 && n1 >= n7 && n1 >= n8 && n1 >= n9)
            out = 4'd1;
        else

        if (n2 >= n0 && n2 >= n1 && n2 >= n3 && n2 >= n4 && n2 >= n5 && n2 >= n6 && n2 >= n7 && n2 >= n8 && n2 >= n9)
            out = 4'd2;
        else

        if (n3 >= n0 && n3 >= n1 && n3 >= n2 && n3 >= n4 && n3 >= n5 && n3 >= n6 && n3 >= n7 && n3 >= n8 && n3 >= n9)
            out = 4'd3;
        else

        if (n4 >= n0 && n4 >= n1 && n4 >= n2 && n4 >= n3 && n4 >= n5 && n4 >= n6 && n4 >= n7 && n4 >= n8 && n4 >= n9)
            out = 4'd4;

        else
        if (n5 >= n0 && n5 >= n1 && n5 >= n2 && n5 >= n3 && n5 >= n4 && n5 >= n6 && n5 >= n7 && n5 >= n8 && n5 >= n9)
            out = 4'd5;

        else
        if (n6 >= n0 && n6 >= n1 && n6 >= n2 && n6 >= n3 && n6 >= n4 && n6 >= n5 && n6 >= n7 && n6 >= n8 && n6 >= n9)
            out = 4'd6;

        else
        if (n7 >= n0 && n7 >= n1 && n7 >= n2 && n7 >= n3 && n7 >= n4 && n7 >= n5 && n7 >= n6 && n7 >= n8 && n7 >= n9)
            out = 4'd7;

        else
        if (n8 >= n0 && n8 >= n1 && n8 >= n2 && n8 >= n3 && n8 >= n4 && n8 >= n5 && n8 >= n6 && n8 >= n7 && n8 >= n9)
            out = 4'd8;

        else
        if (n9 >= n0 && n9 >= n1 && n9 >= n2 && n9 >= n3 && n9 >= n4 && n9 >= n5 && n9 >= n6 && n9 >= n7 && n9 >= n8)
            out = 4'd9;
    end

endmodule