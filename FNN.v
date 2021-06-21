module FNN(
    clk,
    rst,
    done,
    accuracy
);
    input clk, rst;
    output done;
    output [9 : 0] accuracy;

    wire eq, read_mem_inp, sel_inp, sel_reg, cnt_addr_en, cnt_ac_en, read_mem_label;
    wire [1 : 0] sel_w, sel_b;
    wire [30 - 1 : 0] ld_reg;
    wire [9 : 0] addr_cnt;

    wire [62 * 8 - 1 : 0] inp_data;

    wire [3 : 0] expected;
    Controller Controller(
        .clk(clk),
        .rst(rst),
        .eq(eq),
        .addr_cnt(addr_cnt),
        .read_mem_inp(read_mem_inp),
        .sel_inp(sel_inp),
        .sel_reg(sel_reg),
        .sel_w(sel_w),
        .sel_b(sel_b),
        .ld_reg(ld_reg),
        .cnt_addr_en(cnt_addr_en),
        .read_mem_label(read_mem_label),
        .cnt_ac_en(cnt_ac_en),
        .done(done)
    );

    
    Datapath Datapath(  
        .inp_data(inp_data),
        .sel_inp(sel_inp),
        .sel_reg(sel_reg),
        .sel_w(sel_w),
        .sel_b(sel_b),
        .clk(clk),
        .rst(rst),
        .ldreg(ld_reg),
        .addr_cnt(addr_cnt),
        .cntAdrEn(cnt_addr_en),
        .accuracy(accuracy),
        .cntAcEn(cnt_ac_en),
        .eq(eq),
        .expected(expected)
    );

    Data_Mem Data_Mem(
        .adr(addr_cnt),
        .mem_read(read_mem_inp),
        .out(inp_data)
    );  

    Label_Mem Label_Mem(
        .adr(addr_cnt),
        .mem_read(read_mem_label),
        .out(expected)
    );   

endmodule

module TB();
    reg clk, rst;
    wire done;
    wire [9 : 0] accuracy;
    FNN FNN(clk, rst, done, accuracy);

    initial begin
        rst = 1'b1;
        clk = 0;
        #15
        rst = 1'b0;
        repeat(200000)
            #10 clk = ~clk;
            #10000
        $stop;
    end

endmodule