module Mul_2 (
input  wire [7:0] Data_nipple,
output wire [7:0] Data_out
);

assign Data_out = (Data_nipple << 1) ^ (8'h1b & {8{Data_nipple[7]}} );

endmodule