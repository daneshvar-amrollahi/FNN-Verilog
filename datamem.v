module Data_Mem(
    adr,
    mem_read,
    out
);
    input [9 : 0] adr;
    input mem_read;
    output reg [62 * 8 - 1 : 0] out;
    reg[62 * 8 - 1 : 0] mem[0 : 749];

    initial 
	begin
		$readmemb("te_data.txt", mem);
	end


    always @(*)
    begin
        if (mem_read == 1'b1)
            out = mem[adr];
        else
            out = 496'bZ;
    end

endmodule   