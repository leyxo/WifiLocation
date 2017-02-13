function loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,id,k)
%id:算法ID号，1、NN  2、KNN 3、WKNN 4、Bayes 

%loc_point=[0 0];
[ap_r,ap_num]=size(APx);
[fp_r,fp_num]=size(FPx);
rp_power=zeros(1,ap_num);
% X=ReceivePowerFun2(N);
% Y=ReceivePowerFun3(FAF);
for j=1:1:ap_num 
    dis=sqrt((p_x-APx(j))*(p_x-APx(j))+(p_y-APy(j))*(p_y-APy(j)));
%   loss_d1=32.44+20*log10(2400)+20*log10(1/1000); 
    loss_dx=loss_d1+10*N*log10(dis)+FAF;
    rp_power(1,j)=ap_power(j)+ap_gain(j)+fp_gain-loss_dx-noise;     %待定位点接收到各AP强度值
%   loss_db=32.44+20*log10(2400)+20*log10(dis/1000); 
%   rp_power(1,j)=ap_power+ap_gain+fp_gain-loss_db-noise;
end

dis_power=zeros(1,fp_num);      %待定位点收到各AP节点的强度值与所有指纹节点收到各AP节点信号强度的差值和
for i=1:1:fp_num
    d_sum=0;
    for j=1:1:ap_num
        d_sum=(fp_power(i,j)-rp_power(1,j))*(fp_power(i,j)-rp_power(1,j))+d_sum;
    end
    dis_power(1,i)=sqrt(d_sum);
end
 
temp_fpx=FPx;
temp_fpy=FPy;
temp_dispow=dis_power;
temp_power=fp_power;                %指纹节点收到各AP节点信号强度
temp=0;

for i=1:1:fp_num-1                                    %冒泡法排序
    for j=1:1:fp_num-i
        if(temp_dispow(j) > temp_dispow(j + 1))
            
            temp = temp_dispow(j);
            temp_dispow(j) = temp_dispow(j+1);
            temp_dispow(j+1) = temp;
            
            for n=1:1:ap_num                            %对接收信号强度值该行的所有值进行交换
                temp = temp_power(j,n);
                temp_power(j,n) = temp_power(j+1,n);
                temp_power(j+1,n) = temp;
            end
            
            temp = temp_fpx(j);
            temp_fpx(j) = temp_fpx(j+1);
            temp_fpx(j+1) = temp;
            temp = temp_fpy(j);
            temp_fpy(j) = temp_fpy(j+1);
            temp_fpy(j+1) = temp;
        end
    end
end

x_sum = 0;
y_sum = 0;
u=0;
sigma=0.3;%%%%%%%%%%%%%%%%%%%%%%%;
switch (id)
    case 1                                            %NN
        x_sum=temp_fpx(1);
        y_sum=temp_fpy(1);
    case 2                                            %KNN
        for i=1:1:k
            x_sum=x_sum+temp_fpx(i);
            y_sum=y_sum+temp_fpy(i);
        end
        x_sum=x_sum*1.0/k;
        y_sum=y_sum*1.0/k;
  
        
    case 3                                            %WKNN
        w_sum=0.0;
        for i=1:1:k
            x_sum=x_sum+temp_fpx(i)*(1.0/(temp_dispow(i) + 0.0001));
            y_sum=y_sum+temp_fpy(i)*(1.0/(temp_dispow(i) + 0.0001));
            w_sum=w_sum+1.0/(temp_dispow(i) + 0.0001);
        end
        x_sum=x_sum*1.0/w_sum;
        y_sum=y_sum*1.0/w_sum;
    case 4
        p_list = zeros(1,fp_num);
        p_APj_FP = 0;
        for i = 1:1:fp_num
            %获取P(APj|指纹i)的后验概率值
            p_APj_FPi = 1.0;
            for j = 1:1:ap_num
                Skj = fp_power(i,j);
                U = Skj + u;
                p_APj_FPi = p_APj_FPi*1.0 / sqrt(2 * 3.1415926) / sigma * exp(-0.5 * (rp_power(1,j) - U) * (rp_power(1,j) - U) / (sigma * sigma));
            end
            p_list(1,i) = p_APj_FPi;
            p_APj_FP =p_APj_FP+p_APj_FPi;
        end
        p_list%%%%%%%%%%%%%%%
        for i =1:1:fp_num
            x_sum=x_sum+FPx(1,i)*p_list(1,i)/p_APj_FP;
            y_sum=y_sum+FPy(1,i)*p_list(1,i)/p_APj_FP;
        end  
        %p_list/p_APj_FP
end 
loc_point=[x_sum y_sum];