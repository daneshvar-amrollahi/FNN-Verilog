module GetMax(
    in,    
    enable,
    max 
);
    input [80 - 1 : 0] in;
    input enable;
    output reg [3 : 0] max; //0 to 9

    wire [7 : 0] n0 = in[7 : 0];
    wire [7 : 0] n1 = in[15 : 8];
    wire [7 : 0] n2 = in[23 : 16];
    wire [7 : 0] n3 = in[31 : 24];
    wire [7 : 0] n4 = in[39 : 32];
    wire [7 : 0] n5 = in[47 : 40];
    wire [7 : 0] n6 = in[55 : 48];
    wire [7 : 0] n7 = in[63 : 56];
    wire [7 : 0] n8 = in[71 : 64];
    wire [7 : 0] n9 = in[79 : 72];

    
    always @(*)
    begin

    $display("%d", n0);
    $display("%d", n1);
    $display("%d", n2);
    $display("%d", n3);
    $display("%d", n4);
    $display("%d", n5);
    $display("%d", n6);
    $display("%d", n7);
    $display("%d", n8);
    $display("%d", n9);

        if (enable == 1'b0)
            max = 4'bZ;
        else
        
        if (n1 >= n0 && n1 >= n2 && n1 >= n3 && n1 >= n4 && n1 >= n5 && n1 >= n6 && n1 >= n7 && n1 >= n8 && n1 >= n9)
            max = 4'b0001;
        else
        if (n0 >= n1 && n0 >= n2 && n0 >= n3 && n0 >= n4 && n0 >= n5 && n0 >= n6 && n0 >= n7 && n0 >= n8 && n0 >= n9)
            max = 4'b0000;
        else
        if (n2 >= n0 && n2 >= n1 && n2 >= n3 && n2 >= n4 && n2 >= n5 && n2 >= n6 && n2 >= n7 && n2 >= n8 && n2 >= n9)
            max = 4'b0010;
        else

        if (n3 >= n0 && n3 >= n1 && n3 >= n2 && n3 >= n4 && n3 >= n5 && n3 >= n6 && n3 >= n7 && n3 >= n8 && n3 >= n9)
            max = 4'b0011;
        else

        if (n4 >= n0 && n4 >= n1 && n4 >= n2 && n4 >= n3 && n4 >= n5 && n4 >= n6 && n4 >= n7 && n4 >= n8 && n4 >= n9)
            max = 4'b0100;

        else
        if (n5 >= n0 && n5 >= n1 && n5 >= n2 && n5 >= n3 && n5 >= n4 && n5 >= n6 && n5 >= n7 && n5 >= n8 && n5 >= n9)
            max = 4'b0101;

        else
        if (n6 >= n0 && n6 >= n1 && n6 >= n2 && n6 >= n3 && n6 >= n4 && n6 >= n5 && n6 >= n7 && n6 >= n8 && n6 >= n9)
            max = 4'b0110;

        else
        if (n7 >= n0 && n7 >= n1 && n7 >= n2 && n7 >= n3 && n7 >= n4 && n7 >= n5 && n7 >= n6 && n7 >= n8 && n7 >= n9)
            max = 4'b0111;

        else
        if (n8 >= n0 && n8 >= n1 && n8 >= n2 && n8 >= n3 && n8 >= n4 && n8 >= n5 && n8 >= n6 && n8 >= n7 && n8 >= n9)
            max = 4'b1000;

        else
        if (n9 >= n0 && n9 >= n1 && n9 >= n2 && n9 >= n3 && n9 >= n4 && n9 >= n5 && n9 >= n6 && n9 >= n7 && n9 >= n8)
            max = 4'b1001;
    end

endmodule

module getMax_TB();


    reg [80 - 1 : 0] in = {8'd2, 8'd1, 8'd7, 8'd20, 8'd17, 8'd13, 8'd15, 8'd6, 8'd7 , 8'd9};

    wire [3 : 0] max;
    reg enable = 1'b1;
    GetMax GetMax(
        .in(in),    
        .enable(enable),
        .max(max)
    );


    initial begin
        #100;
        $stop;
    end
endmodule   