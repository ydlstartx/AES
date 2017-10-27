%shift_rows.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%
%行移位,根据enc_or_dec来左移或右移
function state = shift_rows(state,enc_or_dec)
%左移时，2、3、4行分别左乘下列矩阵
%右移时，2、3、4行分别左乘下列矩阵的转置
    shiftl1=[0 0 0 1;
             1 0 0 0;
             0 1 0 0;
             0 0 1 0];
    shiftl2=[0 0 1 0;
             0 0 0 1;
             1 0 0 0;
             0 1 0 0];
    shiftl3=[0 1 0 0;
             0 0 1 0;
             0 0 0 1;
             1 0 0 0];

    if strcmp(enc_or_dec,'enc')
        state(2,:) = state(2,:) * shiftl1;
        state(3,:) = state(3,:) * shiftl2;
        state(4,:) = state(4,:) * shiftl3;
    elseif strcmp(enc_or_dec,'dec')
        state(2,:) = state(2,:) * shiftl1';
        state(3,:) = state(3,:) * shiftl2';
        state(4,:) = state(4,:) * shiftl3';
    end
end
