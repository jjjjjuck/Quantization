% 长度为3的格雷码为：000、001、011、010、110、111、101、100。
% 对于10进制为：0，1，3，2，6，7，5，4

% 此脚本展示MAQ的m =3 的情况：
clear
samples = 10*rand(1,50);
m = 3;
K=2^(m+2);

%% 确定各个量化门限的值
samples_sort = sort(samples);

for k=1:K
    % 确保各个量化区域有相等数量的sample
    eta(k)= samples_sort(ceil(length(samples)*k/K)); % 此是否能完成CDF的效果？
end

%% 确定各个sample的量化大小 (根据落入的量化区域)
for i=1:length(samples)
    for j=1:K
        if samples(i) <= eta(j)
            smaple_quantized(i) = j;
            break
        end
    end
end
%% 生成e
for k=1:K
    if (mod(k,4)) >= 2
        e(k)=1;
    else
        e(k)=0;
    end
end

%% 生成相应格雷码
d_m3 = [0 1 3 2 6 7 5 4]; % 表示3bit格雷码

for k = 1:K
    f0(k) = floor( mod(k+1,K) ./4 ) + 1;
    f1(k) = floor( (k-1) ./4) + 1;
    d0(k) = d_m3(f0(k));
    d1(k) = d_m3(f1(k));
end

%% 双方根据e,d0,d1编码key
for i=1:length(samples)
    if e(smaple_quantized(i))==0
        key(i) = d0(smaple_quantized(i));
    else
        key(i) = d1(smaple_quantized(i));
    end
end

%% 将key中10进制数，转化为bit（一个数对应m个bit）
key_bit = zeros(1,length(samples)*m);
% key_bit = [];

for i = 1:length(samples)
    % 如果第一个 case 语句为 true，则 MATLAB 不会执行其他 case 语句
   switch(key(i))
       case 0
           key_tmp = [0,0,0];
           key_bit(3*(i-1)+1 : 3*i) = key_tmp;
       case 1
           key_tmp = [0,0,1];
           key_bit(3*(i-1)+1 : 3*i) = key_tmp;
       case 2
           key_tmp = [0,1,1];
           key_bit(3*(i-1)+1 : 3*i) = key_tmp;
       case 3
           key_tmp = [0,1,0];
           key_bit(3*(i-1)+1 : 3*i) = key_tmp;
       case 4
           key_tmp = [1,1,0];
           key_bit(3*(i-1)+1 : 3*i) = key_tmp;
       case 5
           key_tmp = [1,1,1];
           key_bit(3*(i-1)+1 : 3*i) = key_tmp;
       case 6
           key_tmp = [1,0,1];
           key_bit(3*(i-1)+1 : 3*i) = key_tmp;
       case 7
           key_tmp = [1,0,0];
           key_bit(3*(i-1)+1 : 3*i) = key_tmp;
   end
end


        
