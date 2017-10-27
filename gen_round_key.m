%gen_round_key.m
%Author: YU DONG LEI
%Email: ydl_startx@163.com
%Date: 2017/10/19
%Version: 0.1
%
%
%
%一次全部生成
function round_key = gen_round_key(key_matrix,sbox)
    round_key = zeros(4,4,11);
    %对rcon这个处理是为了下面异或的方便
    rcon = [0x01,00,00,00; 0x02,00,00,00; 0x04,00,00,00; 0x08,00,00,00; 0x10,00,00,00;
            0x20,00,00,00; 0x40,00,00,00; 0x80,00,00,00; 0x1b,00,00,00; 0x36,00,00,00];
    round_key(:,:,1) = key_matrix;

    shift_top1 =[0 1 0 0;
                 0 0 1 0;
                 0 0 0 1;
                 1 0 0 0];

    for z = 1:10
        shift_col = shift_top1 * round_key(:,4,z);    %字循环
        for i = 1:4                                   %字节代换
            tmp = dec2hex(shift_col(i),2);
            r = hex2dec(tmp(1)) + 1;    %因sbox的行列起始坐标为1，所以这里加1
            l = hex2dec(tmp(2)) + 1;    %这里坐标1是高位，2是低位
            shift_col(i) = sbox(r,l);
        end
        shift_col = bitxor(shift_col,rcon(z,:)');         %轮常量异或
        round_key(:,1,z+1) = bitxor(round_key(:,1,z),shift_col);
        round_key(:,2,z+1) = bitxor(round_key(:,2,z),round_key(:,1,z+1));
        round_key(:,3,z+1) = bitxor(round_key(:,3,z),round_key(:,2,z+1));
        round_key(:,4,z+1) = bitxor(round_key(:,4,z),round_key(:,3,z+1));
    end

end
