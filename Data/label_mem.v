module label_mem(
    adr,
    mem_read,
    out
);
    input [9 : 0] addr;
    input mem_read;
    output reg [4 - 1 : 0] out;
    reg[4 - 1 : 0] mem[0 : 749];

    
    $readmemb("te_lable.txt", mem);


    always @(*)
    begin
        if (mem_read == 1'b1)
            out = mem[addr];
        else
            out = 4'bZ;
    end

endmodule   