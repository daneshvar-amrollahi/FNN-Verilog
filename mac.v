`timescale 1ns/1ns


module MAC62(
    a,
    w,
    out
);
    input [62 * 8 - 1 : 0] a, w;
    
    //a[0]: a[7 : 0]  
    //      a[15 : 8]
    //      a[]
    output [20 : 0] out;  

    reg [20 : 0] negs = 20'b0, pos = 20'b0;
	integer i;
	always @(a, w) begin
		
		for (i = 0 ; i < 62 ; i = i + 1)
		begin
			if (a[8 * i + 7] ^ w[8 * i + 7] == 1'b1) //negative
            begin
				negs = negs + a[8 * i +: 7] * w[8 * i +: 7];
                $display("i = %d, neg: %d %d    ", i, a[8 * i +: 7], w[8 * i +: 7]);
            end
			else
            begin
				pos = pos + a[8 * i +: 7] * w[8 * i +: 7];  
                $display("i = %d, pos %d %d", i, a[8 * i +: 7], w[8 * i +: 7]);      
            end
		end
	end

    wire [19 : 0] pn = pos - negs, np = negs - pos;
    assign out = (pos > negs) ? {1'b0, pn} : {1'b1, np};

endmodule

module MAC30(
    a,
    w,
    out
);
    input [30 * 8 - 1 : 0] a, w;
    
    output [19 : 0] out;  

    reg [19 : 0] negs = 19'b0, pos = 19'b0;
	integer i;
	always @(a, w) begin
		
		for (i = 0 ; i < 30 ; i = i + 1)
		begin
			if (a[8 * i + 7] ^ w[8 * i + 7] == 1'b1) //negative
            begin
				negs = negs + a[8 * i +: 7] * w[8 * i +: 7];
                $display("i = %d, neg: %d %d    ", i, a[8 * i +: 7], w[8 * i +: 7]);
            end
			else
            begin
				pos = pos + a[8 * i +: 7] * w[8 * i +: 7];  
                $display("i = %d, pos %d %d", i, a[8 * i +: 7], w[8 * i +: 7]);      
            end
		end
	end

    wire [18 : 0] pn = pos - negs, np = negs - pos;
    assign out = (pos > negs) ? {1'b0, pn} : {1'b1, np};


module MAC4(
    a,
    w,
    out
);
    input [31 : 0] a, w;
    
    output [17 : 0] out;  

    reg [17 : 0] negs = 18'b0, pos = 18'b0;
	integer i;
	always @(a, w) begin
		
		for (i = 0 ; i < 4 ; i = i + 1)
		begin
			if (a[8 * i + 7] ^ w[8 * i + 7] == 1'b1) //negative
            begin
				negs = negs + a[8 * i +: 7] * w[8 * i +: 7];
                $display("i = %d, neg: %d %d    ", i, a[8 * i +: 7], w[8 * i +: 7]);
            end
			else
            begin
				pos = pos + a[8 * i +: 7] * w[8 * i +: 7];  
                $display("i = %d, pos %d %d", i, a[8 * i +: 7], w[8 * i +: 7]);      
            end
		end
	end

    wire [16 : 0] pn = pos - negs, np = negs - pos;
    assign out = (pos > negs) ? {1'b0, pn} : {1'b1, np};


endmodule  

module MAC4TB();


    reg [31 : 0] a, w;
    wire [17 : 0] out;

    MAC4 mac4(
        .a(a),
        .w(w),
        .out(out)
    );

    initial begin

        //-500 + 372 + 309 - 254
        //(100 * (-5)) + (93 * (4)) + ((-103) * (-3)) + ((-127 * (2))) 
        a = { {1'b1, 7'd127}, {1'b1, 7'd103}, {1'b0, 7'd93}, {1'b0, 7'd100} };

        w = { {1'b0, 7'd2}, {1'b1, 7'd3}, {1'b0, 7'd4}, {1'b1, 7'd5} };
        #1000
        $stop;
        //-2 + 1 + 5 - 2
    end
endmodule


