%con2mat.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%

%将4x4矩阵转为32长度16进制字符串
function str=con2str(mat)
    str = blanks(32);
    for j = 1:4
        for i = 1:4
            tmp = dec2hex(mat(i,j),2);
            t = (j-1)*8 + (i*2-1);
            str(t:t+1) = tmp;
        end
    end
end
