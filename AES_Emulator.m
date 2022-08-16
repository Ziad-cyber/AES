clc;
clear all;
%AES-128 cipher
%Impliments FIBS-197, key is a 128 hexidecimal input
%Text is 128-bit hexidecimal.
%Application does not check lengths of keys or Text input
%Ziad Tarek
%16 - 8 - 2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Key   = ['2b28ab09';...
         '7eaef7cf';...
         '15d2154f';...
         '16a6883c'];

str = 'I`m Ziad Tarek!!';    %%%%must be 128 bit 
State = Create_State (str)

% State = ['328831e0';...
%          '435a3137';...
%          'f6309807';...
%          'a88da234'];
cipher = Cipher_Text (State , Key)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function cipher_text = Cipher_Text (state , key)
state  = Add_Round_Key (state,key);
for  i = 1 :9
state  = Sub_Bytes (state);
state  = Shift_Rows(state);
state  = Mix_Columns(state);
key    = Key_Expansion(key,i);
state  = Add_Round_Key(state,key);
end
state  = Sub_Bytes (state);
state  = Shift_Rows(state);
key    = Key_Expansion(key,10);
state  = Add_Round_Key(state,key);  %%Cipher Text
cipher_text =  state;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function key_out = Key_Expansion(key,i)
temp_temp = reshape(dec2hex(zeros(16,2)),4,8);
Sbox=['637c777bf26b6fc53001672bfed7ab76';...
      'ca82c97dfa5947f0add4a2af9ca472c0';...
      'b7fd9326363ff7cc34a5e5f171d83115';...
      '04c723c31896059a071280e2eb27b275';...
      '09832c1a1b6e5aa0523bd6b329e32f84';...
      '53d100ed20fcb15b6acbbe394a4c58cf';...
      'd0efaafb434d338545f9027f503c9fa8';...
      '51a3408f929d38f5bcb6da2110fff3d2';...
      'cd0c13ec5f974417c4a77e3d645d1973';...
      '60814fdc222a908846eeb814de5e0bdb';...
      'e0323a0a4906245cc2d3ac629195e479';...
      'e7c8376d8dd54ea96c56f4ea657aae08';...
      'ba78252e1ca6b4c6e8dd741f4bbd8b8a';...
      '703eb5664803f60e613557b986c11d9e';...
      'e1f8981169d98e949b1e87e9ce5528df';...
      '8ca1890dbfe6426841992d0fb054bb16'];
Kbox   = ['01';'02';'04';'08';'10';'20';'40';'80';'1b';'36'];
sample = reshape(dec2hex(zeros(4,2)),4,2);
sample = key (: , 7:8);
sample = circshift(sample,[-1 0]);
row    = reshape(dec2hex(zeros(1,1)),1,1);
column = reshape(dec2hex(zeros(1,1)),1,1);
Temp   = reshape(dec2hex(zeros(1,2)),1,2);
for j=1:4
        row            = sample (j,1);
        column         = sample (j,2);
        row_dec        = hex2dec(row);
        column_dec     = hex2dec(column);
        Temp           = Sbox(row_dec+1,(column_dec*2)+1:(column_dec*2)+2);
        sample (j,1)   = Temp (1,1) ;
        sample (j,2)   = Temp (1,2) ;
end
Rcon      = reshape(dec2hex(zeros(4,2)),4,2);
Rcon(1,:) = Kbox(i,:); 
Binary_Sample = hexToBinaryVector(sample,8,'MSBFirst');
Binary_Rcon   = hexToBinaryVector(Rcon,8,'MSBFirst');
Binary_Key    = hexToBinaryVector(key,32,'MSBFirst');
Binary_temp_temp = zeros(4,32);
Binary_temp_temp(: , 1:8)  = bitxor(bitxor(Binary_Sample,Binary_Rcon),Binary_Key(:,1:8));
Binary_temp_temp(: , 9:16) = bitxor(Binary_temp_temp(: , 1:8),Binary_Key(:,9:16))       ;
Binary_temp_temp(: , 17:24)= bitxor(Binary_temp_temp(: , 9:16),Binary_Key(:,17:24))     ;   
Binary_temp_temp(: , 25:32)= bitxor(Binary_temp_temp(: , 17:24),Binary_Key(:,25:32))    ;
for i=1:4
temp_temp (i,:) = binaryVectorToHex (Binary_temp_temp(i , :));
end
key_out   = temp_temp;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function state_out = Mix_Columns(state)
    temp = reshape(dec2hex(zeros(16,2)),4,8);
    for i=1:2:8
        temp(1,i:i+1) = binaryVectorToHex ( bitxor(bitxor(bitxor(Mult_Two(state(1,i:i+1))  ,Mult_Three(state(2,i:i+1))),Mult_One(state(3,(i:i+1))))  ,Mult_One(state(4,(i:i+1)))))  ;
        temp(2,i:i+1) = binaryVectorToHex ( bitxor(bitxor(bitxor(Mult_One(state(1,i:i+1))  ,Mult_Two(state(2,i:i+1)))  ,Mult_Three(state(3,(i:i+1)))),Mult_One(state(4,(i:i+1)))))  ;
        temp(3,i:i+1) = binaryVectorToHex ( bitxor(bitxor(bitxor(Mult_One(state(1,i:i+1))  ,Mult_One(state(2,i:i+1)))  ,Mult_Two(state(3,(i:i+1))))  ,Mult_Three(state(4,(i:i+1)))));   
        temp(4,i:i+1) = binaryVectorToHex ( bitxor(bitxor(bitxor(Mult_Three(state(1,i:i+1)),Mult_One(state(2,i:i+1)))  ,Mult_One(state(3,(i:i+1))))  ,Mult_Two(state(4,(i:i+1)))))  ;
    end
 state_out = temp;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = Mult_One(Hex_Value)
Binary = hexToBinaryVector(Hex_Value,8,'MSBFirst');
result = Binary;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = Mult_Three(Hex_Value)
Binary = hexToBinaryVector(Hex_Value,8,'MSBFirst');
Mult_Two(Hex_Value);
r= bitxor(Mult_Two(Hex_Value),Binary);
result = r;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = Mult_Two(Hex_Value)
Binary = hexToBinaryVector(Hex_Value,8,'MSBFirst');
Binary_Shift = [Binary(1,2:8),0];
XOR_1B=[0,0,0,1,1,0,1,1];
if (Binary(1,1)==0)
    r= Binary_Shift;
else
    r=bitxor(Binary_Shift,XOR_1B);
end
result = r;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function state_out = Shift_Rows(state)
state(2,:)=circshift(state(2,:),[0 -2]);
state(3,:)=circshift(state(3,:),[0 -4]);
state(4,:)=circshift(state(4,:),[0 -6]);
state_out = state;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function state_out = Sub_Bytes(state)
Sbox=['637c777bf26b6fc53001672bfed7ab76';...
      'ca82c97dfa5947f0add4a2af9ca472c0';...
      'b7fd9326363ff7cc34a5e5f171d83115';...
      '04c723c31896059a071280e2eb27b275';...
      '09832c1a1b6e5aa0523bd6b329e32f84';...
      '53d100ed20fcb15b6acbbe394a4c58cf';...
      'd0efaafb434d338545f9027f503c9fa8';...
      '51a3408f929d38f5bcb6da2110fff3d2';...
      'cd0c13ec5f974417c4a77e3d645d1973';...
      '60814fdc222a908846eeb814de5e0bdb';...
      'e0323a0a4906245cc2d3ac629195e479';...
      'e7c8376d8dd54ea96c56f4ea657aae08';...
      'ba78252e1ca6b4c6e8dd741f4bbd8b8a';...
      '703eb5664803f60e613557b986c11d9e';...
      'e1f8981169d98e949b1e87e9ce5528df';...
      '8ca1890dbfe6426841992d0fb054bb16'];
row    = reshape(dec2hex(zeros(1,1)),1,1);
column = reshape(dec2hex(zeros(1,1)),1,1);
Temp   = reshape(dec2hex(zeros(1,2)),1,2);
for i=1:4
    for j=1:2:8
        row           = state (i,j);
        column        = state (i,j+1);
        row_dec       = hex2dec(row);
        column_dec    = hex2dec(column);
        Temp          = Sbox(row_dec+1,(column_dec*2)+1:(column_dec*2)+2);
        state (i,j)   = Temp (1,1) ;
        state (i,j+1) = Temp (1,2) ;
    end
end
state_out = state;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function state_out = Add_Round_Key (state_data,key)
binVal_K = hexToBinaryVector(key,32,'MSBFirst');
binVal_S = hexToBinaryVector(state_data,32,'MSBFirst');
for m=1:32
    binVal_S(:,m)=bitxor(binVal_S(:,m),binVal_K(:,m));
end
hexVal_S  = reshape(dec2hex(zeros(16,2)),4,8);
for i=1:4
    m=1;
    for j=1:4:32
        hexVal_S(i,m) = binaryVectorToHex(binVal_S(i,j:j+3),'MSBFirst');
        m=m+1;
    end
end
state_out = hexVal_S;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function state_out = Create_State(data)
hex = dec2hex(double(data));
hex_r =[];
state_r=reshape(dec2hex(zeros(16,2)),4,8);
for i = 1:16
    for j= 1:2
        hex_r = [hex_r , hex(i,j)] ;
    end
end
hex_r;
for i=1:8:32
        if (i<9)
           m=i;
           for j=1:4
               state_r(j,1)   = hex_r (1,m);
               state_r(j,2)   = hex_r (1,m+1);
               m=m+2;
           end
        elseif (i>=9 && i<17)
           m=i;
           for j=1:4
               state_r(j,3)   = hex_r (1,m);
               state_r(j,4)   = hex_r (1,m+1);
               m=m+2;
           end
        elseif (i>=17 && i<25)
           m=i;
           for j=1:4
               state_r(j,5)   = hex_r (1,m);
               state_r(j,6)   = hex_r (1,m+1);
               m=m+2;
           end
        else
           m=i;
           for j=1:4
               state_r(j,7)   = hex_r (1,m);
               state_r(j,8)   = hex_r (1,m+1);
               m=m+2;
           end
        end
end
state_out =  state_r;
end

