%multiply_GF256.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%
%有限域GF(2^8)的乘法，不可约多项式为：m(x) = x^8 + x^4 + x^3 + x +1
%x,y默认输入范围0~255
function result=multiply_GF256(x,y)
    x0 = x;
    x1 = multiply2(x0);
    x2 = multiply2(x1);
    x3 = multiply2(x2);
    x4 = multiply2(x3);
    x5 = multiply2(x4);
    x6 = multiply2(x5);
    x7 = multiply2(x6);
    list = [x7 x6 x5 x4 x3 x2 x1 x0];

    ybit = bitget(y,8:-1:1);   %y7 y6 y5 y4 y3 y2 y1 y0

    result = 0;

    for i = find(ybit==1)
        result = bitxor(result,list(i));
    end

end
