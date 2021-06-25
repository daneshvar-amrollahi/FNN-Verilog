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
    reg [20:0] tof;
    always @(bias, mac_out)
    begin
        if (bias[7] == 1'b1 && mac_out[20] == 1'b1)
        begin
            tof = bias[6 : 0] * 7'd127 + mac_out[19 : 0];
            added = {1'b1, tof};
        end
        if (bias[7] == 1'b1 && mac_out[20] == 1'b0)
        begin
            if (mac_out[19 : 0] > bias[6 : 0])
              begin
                tof = mac_out[19 : 0] - bias[6 : 0] * 7'd127;
                added = {1'b0, tof};
              end
            else 
            begin
                tof =  bias[6 : 0] * 7'd127 - mac_out[19 : 0];
                added = {1'b1,tof};
              end
        end


        if (bias[7] == 1'b0 && mac_out[20] == 1'b1)    
        begin
            if (mac_out[19 : 0] > bias[6 : 0]) begin
            //bias = 8   mac_out = -10
                tof = mac_out[19 : 0] - bias[6 : 0] * 7'd127;
                added = {1'b1, tof}; 
              end
            else begin
                tof = bias[6 : 0] * 7'd127 - mac_out[19 : 0];
                added = {1'b0, tof};
              end
        end

        if (bias[7] == 1'b0 && mac_out[20] == 1'b0)begin
            tof = mac_out[19 : 0] + bias[6 : 0] * 7'd127;
            added = {1'b0, tof};
          end
    end 


    wire [21 : 0] added_sh;
    assign added_sh = {added[21], 9'b0, added[20 : 9]};


    reg [21 : 0] relu_out;

    always @(added_sh)
    begin
        if (added_sh[21] == 1'b0)
        begin
            relu_out = added_sh;
        end
        else    
        begin
            relu_out = 22'd0;
        end
    end
    
    assign out = (relu_out > 21'd127) ? {1'b0, 7'b1111111} : {1'b0, relu_out[6 : 0]};
   // $display("out = %d", out);

endmodule


module neuron_tb();
    reg [62 * 8 - 1 : 0] in, weight;
    reg [7 : 0] bias;
    wire [7 : 0] out;

    Neuron Neuron(
        bias,
        weight,
        in,
        out
    );

    initial begin
        in = { {464'b0},  {1'b1, 7'd127}, {1'b1, 7'd103}, {1'b0, 7'd93}, {1'b0, 7'd100} };

        weight = { {464'b0}, {1'b0, 7'd2}, {1'b1, 7'd3}, {1'b0, 7'd4}, {1'b1, 7'd5} };

        bias = {1'b0, 7'd100}; 

        //out = 100*127 - 73 -> 127
        #500
        in = {496'b0 };

        weight = { {464'b0}, {1'b0, 7'd2}, {1'b1, 7'd3}, {1'b0, 7'd4}, {1'b1, 7'd5} };

        bias = {8'b0}; 
        //out = 0
        #1000;
        $stop;
    end
endmodule