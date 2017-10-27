%multiply2.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%
%有限域GF(2^8)上乘2，不可约多项式为：m(x) = x^8 + x^4 + x^3 + x +1
%x默认输入范围0~255
function result=multiply2(x)
    result = bitshift(x,1);
    if bitget(result,9)
        result = bitxor(result,0x11b);
    end
end
