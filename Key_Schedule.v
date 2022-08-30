module Key_Schedule #(
    parameter  BUS_WIDTH = 128
) (
    input  wire Clk, 
    input  wire Rst,
    input  wire [7:0] Rcon_iteration_value,
    input  wire [BUS_WIDTH-1:0] Data_Raw,
    output reg  [BUS_WIDTH-1:0] Key_New
);


wire [31:0] first_column_out_shifter;
wire [31:0] first_column_out_sbox ;
wire [31:0] Rcon_iteration_value_expand;
wire [31:0] Rcon_xor_Subkeys;

wire [31:0] Fourth_Column;
wire [31:0] Third_Column;
wire [31:0] Second_Column;
wire [31:0] First_Column;

wire [31:0] Fourth_New_Column; 
wire [31:0] Third_New_Column; 
wire [31:0] Second_New_Column; 
wire [31:0] First_New_Column; 

wire [31:0] Fourth_New_Row; 
wire [31:0] Third_New_Row; 
wire [31:0] Second_New_Row; 
wire [31:0] First_New_Row;

wire [BUS_WIDTH-1:0] Key_New_Comb;
////////////////////////////////////////////////////////////////////////////////////////////
assign Fourth_Column = {Data_Raw[31:24],Data_Raw[63:56],Data_Raw[95:88],Data_Raw[127:120]};
assign Third_Column  = {Data_Raw[23:16],Data_Raw[55:48],Data_Raw[87:80],Data_Raw[119:112]};
assign Second_Column = {Data_Raw[15:8],Data_Raw[47:40],Data_Raw[79:72],Data_Raw[111:104]};
assign First_Column  = {Data_Raw[7:0],Data_Raw[39:32],Data_Raw[71:64],Data_Raw[103:96]};
///////////////////////////////////////////////////////////////////////////////////////////
assign first_column_out_shifter = {Data_Raw[39:32],Data_Raw[71:64],Data_Raw[103:96],Data_Raw[7:0]};

genvar i ;
generate
    for ( i=0 ; i< 32 ; i = i + 8 )
        begin
            sbox U0 (.data(first_column_out_shifter [i+7 : i]),.dout(first_column_out_sbox [i+7 : i]) );
        end
endgenerate

assign Rcon_iteration_value_expand = {Rcon_iteration_value,8'h00,8'h00,8'h00};

assign Rcon_xor_Subkeys = first_column_out_sbox ^ Rcon_iteration_value_expand ;

assign  Fourth_New_Column = Rcon_xor_Subkeys  ^ Fourth_Column   ;
assign  Third_New_Column  = Fourth_New_Column ^ Third_Column    ;
assign  Second_New_Column = Third_New_Column  ^ Second_Column   ;
assign  First_New_Column  = Second_New_Column  ^ First_Column   ;

assign  Fourth_New_Row = {Fourth_New_Column[31:24],Third_New_Column[31:24],Second_New_Column[31:24],First_New_Column[31:24]};
assign  Third_New_Row  = {Fourth_New_Column[23:16],Third_New_Column[23:16],Second_New_Column[23:16],First_New_Column[23:16]};    
assign  Second_New_Row = {Fourth_New_Column[15:8],Third_New_Column[15:8],Second_New_Column[15:8],First_New_Column[15:8]};    
assign  First_New_Row  = {Fourth_New_Column[7:0],Third_New_Column[7:0],Second_New_Column[7:0],First_New_Column[7:0]};    


assign Key_New_Comb = {First_New_Row,Second_New_Row,Third_New_Row,Fourth_New_Row};
///////////////////////////////////////////////////////////////////////////////////////////
always @ (posedge Clk or negedge Rst)
    begin
        if (!Rst)
            Key_New <= 'd0;
        else 
            Key_New <= Key_New_Comb;
    end
endmodule