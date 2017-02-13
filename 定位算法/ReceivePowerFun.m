function fp_power=ReceivePowerFun(APx,APy,FPx,FPy,ap_power,ap_gain,fp_gain,N,FAF,loss_d1)

[ap_r,ap_num]=size(APx);  %AP个数矩阵的行数和列数
[fp_r,fp_num]=size(FPx);  %指纹矩阵的行数和列数
fp_power=zeros(fp_num,ap_num);

for i=1:1:fp_num      
    for j=1:1:ap_num
        dis=sqrt((FPx(i)-APx(j))*(FPx(i)-APx(j))+(FPy(i)-APy(j))*(FPy(i)-APy(j)));
      
       %loss_d1=32.44+20*log10(2400)+20*log10(1/1000); 
        loss_dx=loss_d1+10*N*log10(dis)+FAF;
      
        v=ap_power(j)+ap_gain(j)+fp_gain-loss_dx;
        fp_power(i,j)=v;
%       loss_db=32.44+20*log10(2400)+20*log10(dis/1000); 
%       fp_power(i,j)=ap_power+ap_gain+fp_gain-loss_db;
    end
end