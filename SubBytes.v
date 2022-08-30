module SubBytes#(
    parameter  BUS_WIDTH = 128
) (
    input  wire Clk, 
    input  wire Rst,
    input  wire [BUS_WIDTH-1:0] Data_Raw,
    output reg  [BUS_WIDTH-1:0] Data_Sub
);

wire [BUS_WIDTH-1:0]  Data_Sub_Comb;

    genvar i ;
    generate
        for ( i=0 ; i< BUS_WIDTH ; i = i + 8 )
            begin
                sbox U0 (.data(Data_Raw [i+7 : i]),.dout(Data_Sub_Comb [i+7 : i]) );
            end
    endgenerate

always @ (posedge Clk or negedge Rst)
    begin
        if (!Rst)
            Data_Sub <= 'd0;
        else 
            Data_Sub <= Data_Sub_Comb;
    end

endmodule