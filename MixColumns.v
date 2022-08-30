module MixColumns #(
    parameter  BUS_WIDTH = 128
) (
    input  wire Clk, 
    input  wire Rst,
    input  wire [BUS_WIDTH-1:0] Data_Raw,
    output reg  [BUS_WIDTH-1:0] Data_Mix_Columns
);
wire [BUS_WIDTH-1:0] Data_Mix_Columns_Comb;
////////////////////////*************************************//////////////////////////////////
wire [7:0] mul_operand_1_1;     // (1,1)*(1,1)
wire [7:0] mul_operand_2_1;     // (1,1)*(4,1)
wire [7:0] mul_operand_3_1;     // (2,1)*(1,2)
wire [7:0] mul_operand_4_1;     // (2,1)*(2,2)
wire [7:0] mul_operand_5_1;     // (3,1)*(2,3)
wire [7:0] mul_operand_6_1;     // (3,1)*(3,3)
wire [7:0] mul_operand_7_1;     // (4,1)*(3,4)
wire [7:0] mul_operand_8_1;     // (4,1)*(4,4)

wire [7:0] mul_operand_1_2;     // (1,2)*(1,1)
wire [7:0] mul_operand_2_2;     // (1,2)*(4,1)
wire [7:0] mul_operand_3_2;     // (2,2)*(1,2)
wire [7:0] mul_operand_4_2;     // (2,2)*(2,2)
wire [7:0] mul_operand_5_2;     // (3,2)*(2,3)
wire [7:0] mul_operand_6_2;     // (3,2)*(3,3)
wire [7:0] mul_operand_7_2;     // (4,2)*(3,4)
wire [7:0] mul_operand_8_2;     // (4,2)*(4,4)

wire [7:0] mul_operand_1_3;     // (1,3)*(1,1)
wire [7:0] mul_operand_2_3;     // (1,3)*(4,1)
wire [7:0] mul_operand_3_3;     // (2,3)*(1,2)
wire [7:0] mul_operand_4_3;     // (2,3)*(2,2)
wire [7:0] mul_operand_5_3;     // (3,3)*(2,3)
wire [7:0] mul_operand_6_3;     // (3,3)*(3,3)
wire [7:0] mul_operand_7_3;     // (4,3)*(3,4)
wire [7:0] mul_operand_8_3;     // (4,3)*(4,4)

wire [7:0] mul_operand_1_4;     // (1,4)*(1,1)
wire [7:0] mul_operand_2_4;     // (1,4)*(4,1)
wire [7:0] mul_operand_3_4;     // (2,4)*(1,2)
wire [7:0] mul_operand_4_4;     // (2,4)*(2,2)
wire [7:0] mul_operand_5_4;     // (3,4)*(2,3)
wire [7:0] mul_operand_6_4;     // (3,4)*(3,3)
wire [7:0] mul_operand_7_4;     // (4,4)*(3,4)
wire [7:0] mul_operand_8_4;     // (4,4)*(4,4)

////////////////////////*************************************//////////////////////////////////

//First Column
Mul_2 U0 (.Data_nipple(Data_Raw[31:24])  ,.Data_out(mul_operand_1_1));
Mul_3 U1 (.Data_nipple(Data_Raw[31:24])  ,.Data_out(mul_operand_2_1));
Mul_2 U2 (.Data_nipple(Data_Raw[63:56])  ,.Data_out(mul_operand_4_1));
Mul_3 U3 (.Data_nipple(Data_Raw[63:56])  ,.Data_out(mul_operand_3_1));
Mul_2 U4 (.Data_nipple(Data_Raw[95:88])  ,.Data_out(mul_operand_6_1));
Mul_3 U5 (.Data_nipple(Data_Raw[95:88])  ,.Data_out(mul_operand_5_1));
Mul_2 U6 (.Data_nipple(Data_Raw[127:120]),.Data_out(mul_operand_8_1));
Mul_3 U7 (.Data_nipple(Data_Raw[127:120]),.Data_out(mul_operand_7_1));

//Second Column
Mul_2 U8(.Data_nipple(Data_Raw[23:16])  ,.Data_out(mul_operand_1_2));
Mul_3 U9(.Data_nipple(Data_Raw[23:16])  ,.Data_out(mul_operand_2_2));
Mul_2 U10(.Data_nipple(Data_Raw[55:48])  ,.Data_out(mul_operand_4_2));
Mul_3 U11(.Data_nipple(Data_Raw[55:48])  ,.Data_out(mul_operand_3_2));
Mul_2 U12(.Data_nipple(Data_Raw[87:80])  ,.Data_out(mul_operand_6_2));
Mul_3 U13(.Data_nipple(Data_Raw[87:80])  ,.Data_out(mul_operand_5_2));
Mul_2 U14(.Data_nipple(Data_Raw[119:112]),.Data_out(mul_operand_8_2));
Mul_3 U15(.Data_nipple(Data_Raw[119:112]),.Data_out(mul_operand_7_2));

//Third Column
Mul_2 U16(.Data_nipple(Data_Raw[15:8])  ,.Data_out(mul_operand_1_3));
Mul_3 U17(.Data_nipple(Data_Raw[15:8])  ,.Data_out(mul_operand_2_3));
Mul_2 U18(.Data_nipple(Data_Raw[47:40])  ,.Data_out(mul_operand_4_3));
Mul_3 U19(.Data_nipple(Data_Raw[47:40])  ,.Data_out(mul_operand_3_3));
Mul_2 U20(.Data_nipple(Data_Raw[79:72])  ,.Data_out(mul_operand_6_3));
Mul_3 U21(.Data_nipple(Data_Raw[79:72])  ,.Data_out(mul_operand_5_3));
Mul_2 U22(.Data_nipple(Data_Raw[111:104]),.Data_out(mul_operand_8_3));
Mul_3 U23(.Data_nipple(Data_Raw[111:104]),.Data_out(mul_operand_7_3));

//Fourth Column
Mul_2 U24(.Data_nipple(Data_Raw[7:0])   ,.Data_out(mul_operand_1_4));
Mul_3 U25(.Data_nipple(Data_Raw[7:0])   ,.Data_out(mul_operand_2_4));
Mul_2 U26(.Data_nipple(Data_Raw[39:32]) ,.Data_out(mul_operand_4_4));
Mul_3 U27(.Data_nipple(Data_Raw[39:32]) ,.Data_out(mul_operand_3_4));
Mul_2 U28(.Data_nipple(Data_Raw[71:64]) ,.Data_out(mul_operand_6_4));
Mul_3 U29(.Data_nipple(Data_Raw[71:64]) ,.Data_out(mul_operand_5_4));
Mul_2 U30(.Data_nipple(Data_Raw[103:96]),.Data_out(mul_operand_8_4));
Mul_3 U31(.Data_nipple(Data_Raw[103:96]),.Data_out(mul_operand_7_4));

////////////////////////*************************************//////////////////////////////////

assign Data_Mix_Columns_Comb [31:24]   = mul_operand_1_1 ^  mul_operand_3_1 ^ Data_Raw[95:88] ^ Data_Raw[127:120];
assign Data_Mix_Columns_Comb [63:56]   = Data_Raw [31:24] ^ mul_operand_4_1 ^ mul_operand_5_1 ^ Data_Raw[127:120];
assign Data_Mix_Columns_Comb [95:88]   = Data_Raw [31:24] ^ Data_Raw [63:56] ^ mul_operand_6_1 ^ mul_operand_7_1;
assign Data_Mix_Columns_Comb [127:120] = mul_operand_2_1 ^ Data_Raw [63:56] ^ Data_Raw [95:88] ^mul_operand_8_1; 


assign Data_Mix_Columns_Comb [23:16]   = mul_operand_1_2 ^  mul_operand_3_2 ^ Data_Raw[87:80] ^ Data_Raw[119:112];
assign Data_Mix_Columns_Comb [55:48]   = Data_Raw [23:16] ^ mul_operand_4_2 ^ mul_operand_5_2 ^ Data_Raw[119:112];
assign Data_Mix_Columns_Comb [87:80]   = Data_Raw [23:16] ^ Data_Raw [55:48] ^ mul_operand_6_2 ^ mul_operand_7_2;
assign Data_Mix_Columns_Comb [119:112] = mul_operand_2_2 ^ Data_Raw [55:48] ^ Data_Raw [87:80] ^mul_operand_8_2; 

assign Data_Mix_Columns_Comb [15:8]    = mul_operand_1_3 ^  mul_operand_3_3 ^ Data_Raw[79:72] ^ Data_Raw[111:104];
assign Data_Mix_Columns_Comb [47:40]   = Data_Raw [15:8] ^ mul_operand_4_3 ^ mul_operand_5_3 ^ Data_Raw[111:104];
assign Data_Mix_Columns_Comb [79:72]   = Data_Raw [15:8] ^ Data_Raw [47:40] ^ mul_operand_6_3 ^ mul_operand_7_3;
assign Data_Mix_Columns_Comb [111:104] = mul_operand_2_3 ^ Data_Raw [47:40] ^ Data_Raw [79:72] ^mul_operand_8_3;

assign Data_Mix_Columns_Comb [7:0]     = mul_operand_1_4 ^  mul_operand_3_4 ^ Data_Raw[71:64] ^ Data_Raw[103:96];
assign Data_Mix_Columns_Comb [39:32]   = Data_Raw [7:0] ^ mul_operand_4_4 ^ mul_operand_5_4 ^ Data_Raw[103:96];
assign Data_Mix_Columns_Comb [71:64]   = Data_Raw [7:0] ^ Data_Raw [39:32] ^ mul_operand_6_4 ^ mul_operand_7_4;
assign Data_Mix_Columns_Comb [103:96]  = mul_operand_2_4 ^ Data_Raw [39:32] ^ Data_Raw [71:64] ^mul_operand_8_4;
////////////////////////*************************************//////////////////////////////////
always @ (posedge Clk or negedge Rst)
    begin
        if (!Rst)
            Data_Mix_Columns <= 'd0;
        else
            Data_Mix_Columns <= Data_Mix_Columns_Comb;
    end
////////////////////////*************************************//////////////////////////////////
endmodule