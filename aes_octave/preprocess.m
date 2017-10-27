%preprocess.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%
function output=preprocess(text)
    %预处理下
    %长度不足32nibble的补足
    output=blanks(32);
    l = length(text);
    if l<32
        output = [blanks(32-l) text];
        output(1:32-l) = '0';
    %长度超过32nibble的取最右32nibble
    elseif l>32
        output = text(end-31:end);
    elseif l==32
        output = text;
    end
end
