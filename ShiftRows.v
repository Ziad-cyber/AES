module ShiftRows #(
   parameter  BUS_WIDTH = 128
)(
    input  wire Clk, 
    input  wire Rst,
    input  wire [BUS_WIDTH-1:0] Data_Raw,
    output reg  [BUS_WIDTH-1:0] Data_Shift 
);
wire [31 : 0] Data_Raw_0;
wire [31 : 0] Data_Raw_1;
wire [31 : 0] Data_Raw_2;
wire [31 : 0] Data_Raw_3;


assign  Data_Raw_0 = Data_Raw [31:0];
assign  Data_Raw_1 = Data_Raw [63:32] <<8  | {8'h00,8'h00,8'h00,Data_Raw  [63:56]};
assign  Data_Raw_2 = Data_Raw [95:64] <<16 | {8'h00,8'h00,Data_Raw [95:88],Data_Raw [87:80]} ;
assign  Data_Raw_3 = Data_Raw [127:96]<<24 | {8'h00,Data_Raw [127:120],Data_Raw [119:112],Data_Raw [111:104]};

always @ (posedge Clk or negedge Rst)
    begin
        if (!Rst)
            Data_Shift <= 'd0;
        else 
            Data_Shift <= {Data_Raw_3,Data_Raw_2,Data_Raw_1,Data_Raw_0};
    end

endmodule