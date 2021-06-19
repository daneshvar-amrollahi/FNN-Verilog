`timescale 1ns/1ns

module Neuron(
    bias,
    weight,
    in,
    out
);
    input [7 : 0] bias;
    input [62 * 8 - 1 : 0] weight;
    input [62 * 8 - 1 : 0] in;
    output [7 : 0] out;

    wire [20 : 0] mac_out;

    MAC62 MAC62(
        .a(in),
        .w(weight),
        .out(mac_out)
    );

    reg [21 : 0] added;

    always @(bias, mac_out)
    begin
        if (bias[7] == 1'b1 && mac_out[20] == 1'b1)
            added = {1'b1, {13'b0, bias[6 : 0]} + mac_out[19 : 0]};

        if (bias[7] == 1'b1 && mac_out[20] == 1'b0)
        begin
            if (mac_out[19 : 0] > bias[6 : 0])
                added = {1'b0, mac_out[19 : 0] - {13'b0, bias[6 : 0]}};
            else
                added = {1'b1, {13'b0, bias[6 : 0]} - mac_out[19 : 0]};
        end


        if (bias[7] == 1'b0 && mac_out[20] == 1'b1)    
        begin
            if (mac_out[19 : 0] > bias[6 : 0]) //bias = 8   mac_out = -10
                added = {1'b1, mac_out[19 : 0] - {13'b0, bias[6 : 0]}}; 
            else
                added = {1'b0, {13'b0, bias[6 : 0]} - mac_out[19 : 0]};
        end

        if (bias[7] == 1'b0 && mac_out[20] == 1'b0)
            added = {1'b0, mac_out[19 : 0] + {13'b0, bias[6 : 0]}};
    end 

    wire[7 : 0] relu_inp;
    if (added[21] == 1'b0)
    begin
        if (added[20 : 0] > 21'd127)
            relu_inp = {1'b0, 127};
        else
            relu_inp = {1'b0, added[6 : 0]};
    end
    else    
    begin
        if (added[20 : 0] > 21'd127)
            relu_inp = {1'b1, 127};
        else
            relu_inp = {1'b1, added[6 : 0]};
    end

    assign out = (relu_inp[7] == 1'b1) ? 7'b0 : relu_inp;

);

endmodule