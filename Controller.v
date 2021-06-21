module Controller(
    clk,
    rst,
    eq,
    addr_cnt,
    read_mem_inp,
    sel_inp,
    sel_reg,
    sel_w,
    sel_b,
    ld_reg,
    cnt_addr_en,
    read_mem_label,
    cnt_ac_en,
    done
);
    input clk,rst;
    input eq;
    input [9 : 0] addr_cnt;

    output reg read_mem_inp;
    output reg sel_inp, sel_reg;
    output reg [1 : 0] sel_w, sel_b;
    output reg [30 - 1 : 0] ld_reg;
    output reg cnt_addr_en, read_mem_label, cnt_ac_en;
    output reg done;

    

    reg [2 : 0] ps, ns;
	
	always @(posedge clk, posedge rst)
    begin
        if (rst)
            ps <= 3'd0;
        else
            ps <= ns;
    end
	
    always @(ps, addr_cnt)
    begin
	case(ps)
		3'd0: ns = 3'd1;
		3'd1: ns = 3'd2;
		3'd2: ns = 3'd3;
		3'd3: 
		begin
			if(addr_cnt < 10'd750)
			ns = 3'd0;
			else
			ns = 3'd4;
		end
         //end state
		 endcase
    end

    

    always @(ps, eq)
    begin
        read_mem_inp = 1'b0;
        sel_inp = 1'b0;
        sel_w = 2'd0;
        sel_b = 2'd0;
        ld_reg = 30'd0;
        read_mem_label = 1'b0;
        cnt_addr_en = 1'b0;
        cnt_ac_en = 1'b0;

        if (ps == 3'd0)
        begin
            read_mem_inp = 1'b1;
            sel_inp = 1'b1;
            sel_w = 2'd0;
            sel_b = 2'd0;
            ld_reg = {20'd0, 10'b11111_11111};
        end

        if (ps == 3'd1)
        begin
            sel_inp = 1'b1;
            sel_w = 2'd1;
            sel_b = 2'd1;
            ld_reg = {10'd0, 10'b11111_11111, 10'd0};
        end

        if (ps == 3'd2)
        begin
            sel_inp = 1'b1;
            sel_w = 2'd2;
            sel_b = 2'd2;
            ld_reg = {10'b11111_11111, 20'd0};
        end

        if (ps == 3'd3)
        begin
            sel_reg = 1'b1;
            sel_w = 2'd3;
            sel_b = 2'd3;
            read_mem_label = 1'b1;
            cnt_addr_en = 1'b1;
            cnt_ac_en = eq;
        end

        if (ps == 3'd4)
        begin
            done = 1'b1;
        end

    end

endmodule