
%% example 1
partition = [0,1,3];
% codebook = [-1, 0.5, 2, 3];
samp1 = [-2.4, -1, -.2, 0, .2, 1, 1.2, 1.9, 2, 2.9, 3, 3.5, 5];
samp2 = [0.1, 1, 2, -1, 5, 0.7, 2.2, 2.1, 100, -10];
% [index,quantized] = quantiz(samp,partition,codebook);
index = quantiz(samp2,partition);

%% example2
t = [0:.1:2*pi]; % Times at which to sample the sine function
sig = sin(t); % Original signal, a sine wave
partition = [-1:.2:1]; % Length 11, to represent 12 intervals,均匀量化
codebook = [-1.2:.2:1]; % Length 12, one entry for each interval
[index,quants] = quantiz(sig,partition,codebook); % Quantize.
plot(t,sig,'x',t,quants,'.')
legend('Original signal','Quantized signal');
axis([-.2 7 -1.2 1.2])

