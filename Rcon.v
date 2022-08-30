module Rcon (
    output wire [7:0] out_1,
    output wire [7:0] out_2,
    output wire [7:0] out_3,
    output wire [7:0] out_4,
    output wire [7:0] out_5,
    output wire [7:0] out_6,
    output wire [7:0] out_7,
    output wire [7:0] out_8,
    output wire [7:0] out_9,
    output wire [7:0] out_10
); 

assign out_1  = 8'h01 ;
assign out_2  = 8'h02 ;
assign out_3  = 8'h04 ;
assign out_4  = 8'h08 ;
assign out_5  = 8'h10 ;
assign out_6  = 8'h20 ;
assign out_7  = 8'h40 ;
assign out_8  = 8'h80 ;
assign out_9  = 8'h1b ;
assign out_10 = 8'h36 ;

endmodule