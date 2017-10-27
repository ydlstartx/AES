%add_round_key.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%
%轮密钥加
function state = add_round_key(state,round_key,round_n)
    state = bitxor(state,round_key(:,:,round_n));
end
