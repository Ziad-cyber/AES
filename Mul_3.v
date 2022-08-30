module Mul_3 (
input  wire  [7:0] Data_nipple,
output wire  [7:0] Data_out
);

wire [7:0] Data_out_2;

Mul_2  U_Mul2 ( 
.Data_nipple (Data_nipple),
.Data_out  (Data_out_2)
);

assign Data_out = Data_out_2 ^ Data_nipple;

endmodule