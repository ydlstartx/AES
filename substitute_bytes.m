%substitute_bytes.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%
%对128位每8位进行字节替换
function state = substitute_bytes(state,sbox,rsbox,enc_or_dec)
    [rows cols] = size(state);    %state应为4x4矩阵，矩阵中每个元素的值不超过255
    tmp = blanks(2);              %暂存
    if strcmp(enc_or_dec,'enc')
        for j = 1:cols
            for i = 1:rows
                tmp = dec2hex(state(i,j),2);
                r = hex2dec(tmp(1)) + 1;    %因sbox的行列起始坐标为1，所以这里加1
                l = hex2dec(tmp(2)) + 1;    %这里坐标1是高位，2是低位
                state(i,j) = sbox(r,l);
            end
        end
    elseif strcmp(enc_or_dec,'dec')
        for j = 1:cols
            for i = 1:rows
                tmp = dec2hex(state(i,j),2);
                r = hex2dec(tmp(1)) + 1;    %因rsbox的行列起始坐标为1，所以这里加1
                l = hex2dec(tmp(2)) + 1;
                state(i,j) = rsbox(r,l);
            end
        end
    end
end
