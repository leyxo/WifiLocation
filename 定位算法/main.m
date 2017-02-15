function main(Taskd, Algod, Map_Xd, Map_Yd, AP_Numd, APxd, APyd, ap_powerd, ap_gaind, ap_rssd, FP_Numd, FPxd, FPyd, fp_gaind, Simu_Numd, Realxd, Realyd)

%***************实验内容****************
Task = Taskd;           %1;             %1:仿真实验 2:CDF曲线
%*****************算法******************
Algo = Algod;           %0;             %0:所有算法 1:NN 2:KNN 3:WKNN 4:贝叶斯
%***************地图尺寸****************
Mapx = Map_Xd;
Mapy = Map_Yd;
%************AP节点个数与坐标***********
APx = APxd;             %[18 84 2 2];   %AP节点横坐标（连接C#AP节点配置中坐标参数）
APy = APyd;             %[44 46 2 56];  %AP节点纵坐标（连接C#AP节点配置中坐标参数）
AP_Num = AP_Numd;       %4;             %AP点个数
ap_power = ap_powerd;   %20;            %AP节点发送功率（连接C#AP节点配置中发送参数） % [20 18 18 18];%dbm
ap_gain = ap_gaind;     %7;             %AP节点发送增益（连接C#AP节点配置中发送增益） % [7 6 6 6]; %dbi
ap_rss = ap_rssd;       %[-60 -74 -72]; %非参考AP接收参考AP信号强度（连接C#AP节点配置中接收节点信号强度）
DIS = zeros(1,AP_Num-1);                %DIS存储各非主AP与主AP间距

for i=1:1:AP_Num-1
     dis=sqrt((APx(1)-APx(i+1))*(APx(1)-APx(i+1))+(APy(1)-APy(i+1))*(APy(1)-APy(i+1)));
     DIS(1,i)=dis; 
end

Nn = 0;
Faf = 0;
index = 1;
loss_d1 = 32.44+20*log10(2400)+20*log10(1/1000);
for i=1:1:AP_Num-2        %路径损耗指数与FAF自适应
    for j=i+1:1:AP_Num-1
        if(DIS(j)==DIS(i))
            continue;
        end
        n=(ap_rss(i)-ap_rss(j))/(10*log10(DIS(j)/DIS(i)));
        Nn=Nn+n;
        faf=loss_d1-ap_rss(j)-10*n*log10(DIS(j));
        Faf=Faf+faf;
        index=index+1;
    end
end
N=Nn/index;      %自适应后的路径损耗指数值
FAF=Faf/index;   %自适应后的FAF值


%************FP节点个数与坐标**********
FP_Num = FP_Numd;       %580;               %指纹节点个数（从C#指纹库中获取）
FPx = FPxd;             %zeros(1,FP_Num);   %指纹横轴坐标
FPy = FPyd;             %zeros(1,FP_Num);   %指纹纵轴坐标
fp_gain = fp_gaind;     %2; %dbi            %接收增益（连接C#指纹节点配置中接收增益）


%*************指纹信号数据*************
%fp_power = zeros(FP_Num,AP_Num);
fp_power = ReceivePowerFun(APx,APy,FPx,FPy,ap_power,ap_gain,fp_gain,N,FAF,loss_d1);


%*************定位仿真数据*************
Simu_Num = Simu_Numd;   %200;               %仿真路径节点数（连接C#AP节点配置中路线节点）
Realx = Realxd;         %zeros(1,Simu_Num); %路径节点横轴坐标（连接C#AP节点配置中路线节点）
Realy = Realyd;         %zeros(1,Simu_Num); %路径节点纵轴坐标（连接C#AP节点配置中路线节点）


%% 绘制CDF曲线
if(2 == Task)
nn_cdf=zeros(1,21);
knn2_cdf=zeros(1,21);
knn3_cdf=zeros(1,21);
knn4_cdf=zeros(1,21);
wknn2_cdf=zeros(1,21);
wknn3_cdf=zeros(1,21);
wknn4_cdf=zeros(1,21);
wknn5_cdf=zeros(1,21);
bayes_cdf=zeros(1,21);

base_array=0:0.1:2;

nn_sum=0;
knn2_sum=0;
knn3_sum=0;
knn4_sum=0;
wknn2_sum=0;
wknn3_sum=0;
wknn4_sum=0;
wknn5_sum=0;
bayes_sum=0;


for i=1:1:Simu_Num
    noise=normrnd(0,0);
     
    if(0 == Algo || 1 == Algo)
        %调用NN定位算法
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,1,1);
        error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        for k=1:1:21
            if (error<base_array(k))
                nn_cdf(k)=nn_cdf(k)+1;
                %nn_cdf(k)=nn_cdf(k)+error;
                %fprintf('nn_cdf=%f\n',nn_cdf(k));
            end
        end
        nn_sum=nn_sum+error;
    end
    
    if(0 == Algo || 2 == Algo)
        %调用knn定位算法，k取2
        %loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,2,2);
        %error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        %for k=1:1:21
        %    if (error<base_array(k))
        %        knn2_cdf(k)=knn2_cdf(k)+1;
        %    end
        %end
        %knn2_sum=knn2_sum+error;
    
        %调用knn定位算法，k取3
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,2,3);        
        error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        for k=1:1:21
            if (error<base_array(k))
                knn3_cdf(k)=knn3_cdf(k)+1;
            end
        end
        knn3_sum=knn3_sum+error;
    
        %调用knn定位算法，k取4
        %loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,2,4);
        %error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        %for k=1:1:21
        %    if (error<base_array(k))
        %        knn4_cdf(k)=knn4_cdf(k)+1;
        %        %knn4_cdf(k)=knn4_cdf(k)+error;
        %       % fprintf('knn4_cdf=%f\n',knn4_cdf(k));
        %    end
        %end
        %knn4_sum=knn4_sum+error;
    end
    
    if(0 == Algo || 3 == Algo)
        %调用wknn定位算法，k取2
        %loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,3,2);
        %error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        %for k=1:1:21
        %    if (error<base_array(k))
        %        wknn2_cdf(k)=wknn2_cdf(k)+1;
        %    end
        %end
        %wknn2_sum=wknn2_sum+error;
    
        %调用wknn定位算法，k取3
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,3,3);
        error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        for k=1:1:21
            if (error<base_array(k))
                wknn3_cdf(k)=wknn3_cdf(k)+1;
            end
        end
        wknn3_sum=wknn3_sum+error;
    
        %调用wknn定位算法，k取4
        %loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,3,4);
        %error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        %for k=1:1:21
        %    if (error<base_array(k))
        %        wknn4_cdf(k)=wknn4_cdf(k)+1;
        %        %wknn4_cdf(k)=wknn4_cdf(k)+error;
        %        %fprintf('wknn4_cdf=%f\n',wknn4_cdf(k));
        %    end
        %end
        %wknn4_sum=wknn4_sum+error;
    
        %调用wknn定位算法，k取5
        %loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,3,5);
        %error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        %for k=1:1:21
        %    if (error<base_array(k))
        %        wknn5_cdf(k)=wknn5_cdf(k)+1;
        %        %wknn4_cdf(k)=wknn4_cdf(k)+error;
        %        %fprintf('wknn4_cdf=%f\n',wknn4_cdf(k));
        %    end
        %end
        %wknn5_sum=wknn5_sum+error;
    end
    
    if(0 == Algo || 4 == Algo)
        %调用贝叶斯算法
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,4,2);
        error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        for k=1:1:21
            if (error<base_array(k))
                bayes_cdf(k)=bayes_cdf(k)+1;
                %bayes_cdf(k)=bayes_cdf(k)+error;
                %fprintf('bayes_cdf=%f\n',bayes_cdf(k));s
            end
        end
        bayes_sum=bayes_sum+error;
    end
end

%不同算法定位平均误差
%fprintf('nn=%f\n',nn_sum/Simu_Num);
%fprintf('knn2=%f\n',knn2_sum/Simu_Num);
%fprintf('knn3=%f\n',knn3_sum/Simu_Num);
%fprintf('knn4=%f\n',knn4_sum/Simu_Num);
%fprintf('wknn2=%f\n',wknn2_sum/Simu_Num);
%fprintf('wknn3=%f\n',wknn3_sum/Simu_Num);
%fprintf('wknn4=%f\n',wknn4_sum/Simu_Num);
%fprintf('wknn5=%f\n',wknn5_sum/Simu_Num);
%fprintf('bayes=%f\n',bayes_sum/Simu_Num);


figure('NumberTitle', 'off', 'Name', 'CDF曲线图');
if(0 == Algo || 1 == Algo)
    plot(base_array,nn_cdf/Simu_Num,'g<-');
    hold on
    legend('NN');
end
if(0 == Algo || 2 == Algo)
    plot(base_array,knn3_cdf/Simu_Num,'b*-');
    hold on
    legend('KNN3');
end
if(0 == Algo || 3 == Algo)
    plot(base_array,wknn3_cdf/Simu_Num,'r+-');
    hold on
    legend('WKNN3');
end
if(0 == Algo || 4 == Algo)
    plot(base_array,bayes_cdf/Simu_Num,'co-');
    hold on
    legend('Bayes');
end

if(0 == Algo)
    legend('nn','knn3','wknn3','bayes');
end

xlabel('Error distance(m)')
ylabel('Cumulative distribution function')
title('CDF Comparison')

end


%% 绘制仿真路线
if(1 == Task)
figure('NumberTitle', 'off', 'Name', '仿真路线图');
%限制坐标轴范围
%axis([0 Mapx 0 Mapy]);
axis equal;
hold on;
xlim([0 Mapx]);
hold on;
ylim([0 Mapy]);
hold on;
set(gca,'ydir','reverse');
hold on;

H1 = plot(FPx,FPy,'b.');
hold on;
H2 = plot(APx,APy,'ro');
hold on;
  
%二维数组存储仿真结果坐标点
loc_point_1 = zeros(Simu_Num, 2);
loc_point_2 = zeros(Simu_Num, 2);
loc_point_3 = zeros(Simu_Num, 2);
loc_point_4 = zeros(Simu_Num, 2);

for i=1:1:Simu_Num
    noise=normrnd(0,0);
    
    H3 = plot(Realx(i),Realy(i),'k.-');
    hold on;
    
    if(0 == Algo || 1 == Algo)
        %调用nn定位算法
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,1,1);
        loc_point_1(i,1) = loc_point(1);
        loc_point_1(i,2) = loc_point(2);
        H4 = plot(loc_point(1),loc_point(2),'g<-');
        hold on;
        legend([H1(1),H2(1),H3(1),H4(1)],'指纹节点','AP节点','真实路线','NN定位路径');
    end
    
    if(0 == Algo || 2 == Algo)
        %调用knn定位算法，k取3
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,2,3);
        loc_point_2(i,1) = loc_point(1);
        loc_point_2(i,2) = loc_point(2);
        H5 = plot(loc_point(1),loc_point(2),'b*-');
        hold on;
            legend([H1(1),H2(1),H3(1),H5(1)],'指纹节点','AP节点','真实路线','KNN3路径');
    end
    
    if(0 == Algo || 3 == Algo)
        %调用wknn定位算法，k取3
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,3,3);
        loc_point_3(i,1) = loc_point(1);
        loc_point_3(i,2) = loc_point(2);
        H6=plot(loc_point(1),loc_point(2),'r+-');
        hold on;
            legend([H1(1),H2(1),H3(1),H6(1)],'指纹节点','AP节点','真实路线','WKNN3路径');
    end
    
    if(0 == Algo || 4 == Algo)
        %调用贝叶斯算法
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,4,2);
        loc_point_4(i,1) = loc_point(1);
        loc_point_4(i,2) = loc_point(2);
        H7=plot(loc_point(1),loc_point(2),'co-');
        hold on;
            legend([H1(1),H2(1),H3(1),H7(1)],'指纹节点','AP节点','真实路线','贝叶斯算法路径');
    end
end

%绘制真实及仿真路线
H3L = plot(Realx,Realy,'k.-');
hold on;
if(0 == Algo || 1 == Algo)
    H4L = plot(loc_point_1(:,1), loc_point_1(:,2), 'g<-');
    hold on;
end
if(0 == Algo || 2 == Algo)
    H5L = plot(loc_point_2(:,1), loc_point_2(:,2), 'b*-');
    hold on;
end
if(0 == Algo || 3 == Algo)
    H6L = plot(loc_point_3(:,1), loc_point_3(:,2), 'r+-');
    hold on;
end
if(0 == Algo || 4 == Algo)
    H7L = plot(loc_point_4(:,1), loc_point_4(:,2), 'co-');
    hold on;
end
box on;
if(0 == Algo)
    legend([H1(1),H2(1),H3(1),H4(1),H5(1),H6(1),H7(1)],'指纹节点','AP节点','真实路线','NN定位路径','KNN3路径','WKNN3路径','贝叶斯算法路径');
end
end
