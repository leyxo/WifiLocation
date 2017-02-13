clc
clear
%************AP个数与坐标***********
%AP_Num=4;             %AP点个数
%FP_Num=45;            %指纹个数

% APx=[0 45 0 45];
%  APy=[0 0 45 45];
APx=[18 84 2 2];
APy=[44 46 2 56];
AP_Num=4;       %AP点个数
ap_power= [20 18 18 18];%dbm
ap_gain= [7 6 6 6]; %dbi
RSS=[60 74 72]; %非主AP接收主AP信号强度
DIS=zeros(1,AP_Num-1);
num=1;
  for i=1:1:AP_Num-1
        dis=sqrt((APx(1)-APx(i+1))*(APx(1)-APx(i+1))+(APy(1)-APy(i+1))*(APy(1)-APy(i+1)));
        DIS(1,num)=dis; %各非主AP与主AP间距
        num=num+1;
  end
  len=3; 
  Nn=0;
  Faf=0;
  index=1;
   loss_d1=32.44+20*log10(2400)+20*log10(1/1000);
  for i=1:1:len-1        %路径损耗指数与FAF自适应
      for j=i+1:1:len
          n=(RSS(i)-RSS(j))/(10*log10(DIS(j)/DIS(i)));
          Nn=Nn+n;
          faf=loss_d1-RSS(j)-10*n*log10(DIS(j));
          Faf=Faf+faf;
          index=index+1;
      end
  end
  N=Nn/index;
  FAF=Faf/index;
%************指纹个数与坐标**********
FP_Num=580;
fp_gain=2; %dbi
FPx=zeros(1,FP_Num);                   %指纹横轴坐标
FPy=zeros(1,FP_Num);                   %指纹纵轴坐标


index=1;                       %对指纹坐标进行初始化，四个角落没有指纹点
for i=1:1:20
    for j=1:1:29
          if ~(i<13&&j>7)
        %if ~(i==1&&j==1||i==1&&j==7||i==7&&j==1||i==7&&j==7)
            FPx(1,index)=(j-1)*3;
            FPy(1,index)=(i-1)*3;
            %index
            index=index+1;
            
        end
    end
end


%fprintf('FPx=%f\n',FPx);
%fprintf('FPy=%f\n',FPy);
FPx
FPy

%*************指纹信号数据*************
%fp_power=zeros(FP_Num,AP_Num);
fp_power=ReceivePowerFun(APx,APy,FPx,FPy,ap_power,ap_gain,fp_gain,N,FAF,loss_d1);

%*************定位仿真数据*************
nn_cdf=zeros(1,21);
knn2_cdf=zeros(1,21);
knn3_cdf=zeros(1,21);
knn4_cdf=zeros(1,21);
wknn2_cdf=zeros(1,21);
wknn3_cdf=zeros(1,21);
wknn4_cdf=zeros(1,21);
bayes_cdf=zeros(1,21);


base_array=[0:0.1:2];
n=0;
nn_sum=0;
knn2_sum=0;
knn3_sum=0;
knn4_sum=0;
wknn2_sum=0;
wknn3_sum=0;
wknn4_sum=0;
bayes_sum=0;
Dbayes_sum=0;

index=0;
 Xx=[2.00 4.00 6.00 8.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 10.00 12.00 14.00 16.00 18.00 20.00 22.00 24.00 26.00 28.00 30.00 32.00 34.00 36.00 38.00 40.00 42.00 44.00 46.00 48.00 50.00 52.00 54.00 56.00 58.00 60.00 62.00 64.00 66.00 68.00 70.00 70.00 70.00 70.00 70.00];
 Yy=[5.00 5.00 5.00 5.00 7.00 9.00 11.00 13.00 15.00 17.00 19.00 21.00 23.00 25.00 27.00 29.00 31.00 33.00 35.00 37.00 39.00 41.00 43.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 45.00 47.00 49.00 51.00 53.00];
 Simu_Num=length(Xx);
for n=1:1:Simu_Num
   
   p_x=Xx(n);              %待定位点坐标，0~30
   p_y=Yy(n);
%    if ~(p_x>19&&p_y<37)
%    if ~(p_x>16&&p_y<40)
    % p_x=15;              %待定位点坐标，0~30
   % p_y=20;
    %noise=randn;
    noise=normrnd(0,0);
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,1,1);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:21
        if (error<base_array(i))
            nn_cdf(i)=nn_cdf(i)+1;
            %nn_cdf(i)=nn_cdf(i)+error;
           % fprintf('nn_cdf=%f\n',nn_cdf(i));
        end
    end
    nn_sum=nn_sum+error;


    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,2,2);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:21
        if (error<base_array(i))
            knn2_cdf(i)=knn2_cdf(i)+1;
        end
    end
    
    knn2_sum=knn2_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,2,3);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:21
        if (error<base_array(i))
            knn3_cdf(i)=knn3_cdf(i)+1;
        end
    end
    knn3_sum=knn3_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,2,4);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:21
        if (error<base_array(i))
            knn4_cdf(i)=knn4_cdf(i)+1;
            %knn4_cdf(i)=knn4_cdf(i)+error;
           % fprintf('knn4_cdf=%f\n',knn4_cdf(i));
        end
    end
    knn4_sum=knn4_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,3,2);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:21
        if (error<base_array(i))
            wknn2_cdf(i)=wknn2_cdf(i)+1;
        end
    end
    wknn2_sum=wknn2_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,3,3);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:21
        if (error<base_array(i))
            wknn3_cdf(i)=wknn3_cdf(i)+1;
        end
    end
    wknn3_sum=wknn3_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,3,4);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:21
        if (error<base_array(i))
            wknn4_cdf(i)=wknn4_cdf(i)+1;
            %wknn4_cdf(i)=wknn4_cdf(i)+error;
            %fprintf('wknn4_cdf=%f\n',wknn4_cdf(i));
        end
    end
    wknn4_sum=wknn4_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,4,2);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:21
        if (error<base_array(i))
            bayes_cdf(i)=bayes_cdf(i)+1;
            %bayes_cdf(i)=bayes_cdf(i)+error;
           % fprintf('bayes_cdf=%f\n',bayes_cdf(i));
        end
    end
    bayes_sum=bayes_sum+error;
    
     loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,6,200);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:21
        if (error<base_array(i))
            Dbayes_cdf(i)=Dbayes_cdf(i)+1;
            %bayes_cdf(i)=bayes_cdf(i)+error;
           % fprintf('bayes_cdf=%f\n',bayes_cdf(i));
        end
    end
    Dbayes_sum=Dbayes_sum+error;
%     n=n+1;

figure(1);
H1 = plot(FPx,FPy,'b.')
hold on;
H2 = plot(APx,APy,'gp');
hold on;
% plot(30,0,'gp');
% hold on;
% plot(0,30,'gp');
% hold on;
% plot(30,30,'gp');
% hold on;
H3 = plot(p_x,p_y,'bx');
hold on;
% loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,1,1);
% H4 = plot(loc_point(1),loc_point(2),'k<');
% hold on;
% loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,2,3);
%  H5 = plot(loc_point(1),loc_point(2),'r*');
%  hold on;
 loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,N,FAF,loss_d1,3,3);
H6=plot(loc_point(1),loc_point(2),'c+');
hold on;

% legend([H1(1),H2(1),H3(1),H4(1),H5(1),H6(1),H7(1)],'数据库采样点','AP位置','真实位置','NN定位位置','KNN3定位位置','WKNN3定位位置')
legend([H1(1),H2(1),H3(1),H6(1)],'数据库采样点','AP位置','真实位置','WKNN3定位位置')
end
%    end
fprintf('a=%d\n',Simu_Num);
fprintf('nn=%f\n',nn_sum/Simu_Num);
fprintf('knn2=%f\n',knn2_sum/Simu_Num);
fprintf('knn3=%f\n',knn3_sum/Simu_Num);
fprintf('knn4=%f\n',knn4_sum/Simu_Num);
fprintf('wknn2=%f\n',wknn2_sum/Simu_Num);
fprintf('wknn3=%f\n',wknn3_sum/Simu_Num);
fprintf('wknn4=%f\n',wknn4_sum/Simu_Num);
fprintf('bayes=%f\n',bayes_sum/Simu_Num);



figure(2);






plot(base_array,nn_cdf/Simu_Num,'g+-');
hold on
%plot(base_array,knn2_cdf/Simu_Num,'k:x');
%hold on
plot(base_array,knn2_cdf/Simu_Num,'b*-');
hold on
%plot(base_array,wknn2_cdf/Simu_Num,'m--x');
%hold on
plot(base_array,wknn2_cdf/Simu_Num,'ro-');
hold on
plot(base_array,bayes_cdf/Simu_Num,'k.-');
hold on

%legend('nn','knn2','knn3','wknn2','wknn4','bayes');
legend('nn','knn3','wknn3','bayes');
xlabel('Error distance(m)')
ylabel('Cumulative distribution function')
title('CDF Comparison')