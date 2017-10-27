%con2mat.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%

%将输入的32长度的16进制字符串转为4x4十进制矩阵形式
function mat=con2mat(strings)
    for j = 1:4
        for i = 1:4
            row = (j-1)*8 + (i-1)*2 + 1;
            mat(i,j) = hex2dec(strings(row:row+1));
        end
    end
end
