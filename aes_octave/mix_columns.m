%mix_columns.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%

%列混合
function output = mix_columns(state,enc_or_dec)
    output = zeros(4,4);
    box = [0x02 0x03 0x01 0x01;
           0x01 0x02 0x03 0x01;
           0x01 0x01 0x02 0x03;
           0x03 0x01 0x01 0x02];
    rbox = [0x0e 0x0b 0x0d 0x09;
            0x09 0x0e 0x0b 0x0d;
            0x0d 0x09 0x0e 0x0b;
            0x0b 0x0d 0x09 0x0e];

    if strcmp(enc_or_dec,'enc')
        for j = 1:4
            for i = 1:4
                s1 = multiply_GF256(state(1,j),box(i,1));
                s2 = multiply_GF256(state(2,j),box(i,2));
                s3 = multiply_GF256(state(3,j),box(i,3));
                s4 = multiply_GF256(state(4,j),box(i,4));
                output(i,j) = bitxor(bitxor(s1,s2),bitxor(s3,s4));
            end
        end
    elseif strcmp(enc_or_dec,'dec')
        for j = 1:4
            for i = 1:4
                s1 = multiply_GF256(state(1,j),rbox(i,1));
                s2 = multiply_GF256(state(2,j),rbox(i,2));
                s3 = multiply_GF256(state(3,j),rbox(i,3));
                s4 = multiply_GF256(state(4,j),rbox(i,4));
                output(i,j) = bitxor(bitxor(s1,s2),bitxor(s3,s4));
            end
        end
    end
end
