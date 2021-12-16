% 此脚本展示MAQ的m =1 的情况：

samples = 10*rand(1,20);
m = 1;
K=2^(m+2);

%% 确定各个量化门限的值
% 先排序
samples_sort = sort(samples);
for k=1:K
    % 确保区各个量化区域有相等数量的sample，K是量化间数，eta相当于是partition
    eta(k)= samples_sort(ceil(length(samples)*k/K));  % ceil向上取整，k/K看成权重
end

%% 确定各个sample的量化大小 (根据落入的量化区域)
for i=1:length(samples)
    for j=1:K
        if samples(i) <= eta(j)  % 因为partition是由样本确定的，所以一定要加=号
            smaple_quantized(i) = j; % 或者说 “=” 号一定会用到
            break
        end
    end
end

for k=1:K
    if (mod(k,4)) >= 2
        e(k)=1;
    else
        e(k)=0;
    end
end

% 格雷码
d0=[0 0 1 1 1 1 0 0];
d1=[0 0 0 0 1 1 1 1];

for i=1:length(samples)
    if e(smaple_quantized(i))==0
        key(i) = d0(smaple_quantized(i));
    else
        key(i) = d1(smaple_quantized(i));
    end
end


        
