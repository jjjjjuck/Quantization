% %% icdf的基本操作
% % 定义（确定）样本分布
% mu = 1;
% sigma = 5;
% pd = makedist('normal','mu',mu,'sigma',sigma);
% 
% % 确定概率（与各区间的概率有关，其长度与分位点数量一致，分位点数量等于门限数）
% p = [0.1,0.25,0.5,0.75,0.9, 0.01];
% 
% % 计算对应分布下的分位点
% quantile_vec = icdf(pd,p);

% pd = makedist('normal','mu',1,'sigma',5);
% samps1 = random(pd,50,1); % 使用分布对象pd,生成随机数；
% samps2 = raylrnd(1,50,1);% 第一个参数是分布的参数
%% cdf-based quantization
samps3 = randn(500,1);% 默认标准normal

% 设置门限数量(或设置量化bit数)
No_threshold = 7;  % 或 No_bit = 3;
p = 1/(No_threshold+1): 1/(No_threshold+1) : 1-1/(No_threshold+1);  
% 或 p = 1/2^No_bit: 1/2^No_bit : 1-1/2^No_bit

pd_fit = fitdist(samps3,'normal'); % 计算CDF，需指定分布，默认normal分布。

% 计算门限划分partion ,其长度是量化区间数-1
partition = icdf(pd_fit,p);
quanti_res = zeros(length(samps3),1); % 保存量化结果,离散数值

for i = 1:length(samps3)
    for j = 1:length(partition)
        % 执行if，即量化
        if samps3(i)< partition(j)
            quanti_res(i) = j;
            break;
        end
    end
    % 最后一个量化区间
    if samps3(i)>= partition(j)
        quanti_res(i) = j+1;
    end
end

%% quantiz
index = quantiz(samps3,partition); % index+1 = quanti_res
%% plot
t = 1:500;
plot(t,samps3,'x',t,quanti_res,'.')
legend('samples','Quantized samples');





