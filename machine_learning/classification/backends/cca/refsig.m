function y=refsig(f, S, T, H)


% f-- the fundermental frequency  基频
% S-- the sampling rate 采样率
% T-- the number of sampling points  样本点
% H-- the number of harmonics  谐波数


for i=1:H
   for j=1:T
    t= j/S;
    y(2*i-1,j)=sin(2*pi*(i*f)*t);
    y(2*i,j)=cos(2*pi*(i*f)*t);
   end
end
