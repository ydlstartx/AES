%main.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%

%输入为16进制形式的字符串
%主函数，对数据预处理，调用aes加密或解密
plaintext = '6bc1bee22e409f96e93d7e117393172a';                %明文
key = '2b7e151628aed2a6abf7158809cf4f3c';                      %密钥
ciphertext = '';               %密文
enc_or_dec = 'enc';            %加密or解密？

%存储加解密结果
enc_output = blanks(32);
dec_output = blanks(32);

%预处理下,确保都为32位字符串
plaintext = preprocess(plaintext);
key = preprocess(key);
ciphertext = preprocess(ciphertext);

if strcmp(enc_or_dec,'enc')
    text = plaintext;
elseif strcmp(enc_or_dec,'dec')
    text = ciphertext;
end

t1 = clock;
%总函数,根据enc_or_dec,text可为明文可为密文
%相应的output位密文或明文
enc_output = aes_top(text,key,enc_or_dec);
fprintf("加密时间为：%ds\n",etime(clock,t1));

enc_or_dec = 'dec';
t1 = clock;
dec_output = aes_top(enc_output,key,enc_or_dec);
fprintf("解密时间为：%ds\n",etime(clock,t1));

sprintf("明文:    %s",plaintext)
sprintf("加密结果:%s",enc_output)
sprintf("解密结果:%s",dec_output)
