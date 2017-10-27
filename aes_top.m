%aes_top.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%
%128位密钥
%总函数,根据enc_or_dec,text可为明文可为密文
%相应的output为密文或明文
function output = aes_top(text,key,enc_or_dec)
    key_matrix = zeros(4,4);        %密钥转为4x4矩阵形式，存储的是初始密钥

    state_matrix = zeros(4,4);      %存储各轮结果和初始的text
    round_key = zeros(4,4,11);      %存储round key,提前生成，

    total_round = 10;
    output = blanks(32);            %存储输出结果

    %将text存为状态矩阵中，以待后续处理
    %将key存入round_key(:,:,1)中
    state_matrix = con2mat(text);
    key_matrix = con2mat(key);
%    for j = 1:4
%        for i = 1:4
%            row = (j-1)*8 + (i-1)*2 + 1;
%            state_matrix(i,j) = hex2dec(text(row:row+1));
%            key_matrix(i,j) = hex2dec(key(row:row+1));
%        end
%    end

    %从文件中load sbox和rsbox
    load('sbox.txt');
    load('rsbox.txt');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%以下为加解密过程
    %首先生成所有轮密钥
    round_key = gen_round_key(key_matrix,sbox);

    if strcmp(enc_or_dec,'enc') %加密
        round_n = 0;
        %加初始轮密钥
        state_matrix = add_round_key(state_matrix,round_key,round_n+1);
        for round_n = 1:total_round-1
            %sbox字节替换
            state_matrix = substitute_bytes(state_matrix,sbox,rsbox,enc_or_dec);
            %行移位
            state_matrix = shift_rows(state_matrix,enc_or_dec);
            %列混合
            state_matrix = mix_columns(state_matrix,enc_or_dec);
            %加轮密钥
            state_matrix = add_round_key(state_matrix,round_key,round_n+1);
        end
        %sbox字节替换
        state_matrix = substitute_bytes(state_matrix,sbox,rsbox,enc_or_dec);
        %行移位
        state_matrix = shift_rows(state_matrix,enc_or_dec);
        %加轮密钥,此时round_n=total_round-1
        state_matrix = add_round_key(state_matrix,round_key,round_n+2);

    elseif strcmp(enc_or_dec,'dec') %解密
        round_n = total_round;
        %加初始轮密钥
        state_matrix = add_round_key(state_matrix,round_key,round_n+1);
        for round_n = total_round-1:-1:1
            %行逆移位
            state_matrix = shift_rows(state_matrix,enc_or_dec);
            %sbox字节逆替换
            state_matrix = substitute_bytes(state_matrix,sbox,rsbox,enc_or_dec);
            %加轮密钥
            state_matrix = add_round_key(state_matrix,round_key,round_n+1);
            %列逆混合
            state_matrix = mix_columns(state_matrix,enc_or_dec);
        end
        %行逆移位
        state_matrix = shift_rows(state_matrix,enc_or_dec);
        %sbox字节逆替换
        state_matrix = substitute_bytes(state_matrix,sbox,rsbox,enc_or_dec);
        %加轮密钥,此时round_n=1
        state_matrix = add_round_key(state_matrix,round_key,round_n);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%加解密结束，结果转换
    output = con2str(state_matrix);
%    for j = 1:4
%        for i = 1:4
%            tmp = dec2hex(state_matrix(i,j),2);
%            t = (j-1)*8 + (i*2-1);
%            output(t:t+1) = tmp;
%        end
%    end

end
