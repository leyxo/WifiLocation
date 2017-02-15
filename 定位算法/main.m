function main(Taskd, Algod, Map_Xd, Map_Yd, AP_Numd, APxd, APyd, ap_powerd, ap_gaind, ap_rssd, FP_Numd, FPxd, FPyd, fp_gaind, Simu_Numd, Realxd, Realyd)

%***************ʵ������****************
Task = Taskd;           %1;             %1:����ʵ�� 2:CDF����
%*****************�㷨******************
Algo = Algod;           %0;             %0:�����㷨 1:NN 2:KNN 3:WKNN 4:��Ҷ˹
%***************��ͼ�ߴ�****************
Mapx = Map_Xd;
Mapy = Map_Yd;
%************AP�ڵ����������***********
APx = APxd;             %[18 84 2 2];   %AP�ڵ�����꣨����C#AP�ڵ����������������
APy = APyd;             %[44 46 2 56];  %AP�ڵ������꣨����C#AP�ڵ����������������
AP_Num = AP_Numd;       %4;             %AP�����
ap_power = ap_powerd;   %20;            %AP�ڵ㷢�͹��ʣ�����C#AP�ڵ������з��Ͳ����� % [20 18 18 18];%dbm
ap_gain = ap_gaind;     %7;             %AP�ڵ㷢�����棨����C#AP�ڵ������з������棩 % [7 6 6 6]; %dbi
ap_rss = ap_rssd;       %[-60 -74 -72]; %�ǲο�AP���ղο�AP�ź�ǿ�ȣ�����C#AP�ڵ������н��սڵ��ź�ǿ�ȣ�
DIS = zeros(1,AP_Num-1);                %DIS�洢������AP����AP���

for i=1:1:AP_Num-1
     dis=sqrt((APx(1)-APx(i+1))*(APx(1)-APx(i+1))+(APy(1)-APy(i+1))*(APy(1)-APy(i+1)));
     DIS(1,i)=dis; 
end

Nn = 0;
Faf = 0;
index = 1;
loss_d1 = 32.44+20*log10(2400)+20*log10(1/1000);
for i=1:1:AP_Num-2        %·�����ָ����FAF����Ӧ
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
N=Nn/index;      %����Ӧ���·�����ָ��ֵ
FAF=Faf/index;   %����Ӧ���FAFֵ


%************FP�ڵ����������**********
FP_Num = FP_Numd;       %580;               %ָ�ƽڵ��������C#ָ�ƿ��л�ȡ��
FPx = FPxd;             %zeros(1,FP_Num);   %ָ�ƺ�������
FPy = FPyd;             %zeros(1,FP_Num);   %ָ����������
fp_gain = fp_gaind;     %2; %dbi            %�������棨����C#ָ�ƽڵ������н������棩


%*************ָ���ź�����*************
%fp_power = zeros(FP_Num,AP_Num);
fp_power = ReceivePowerFun(APx,APy,FPx,FPy,ap_power,ap_gain,fp_gain,N,FAF,loss_d1);


%*************��λ��������*************
Simu_Num = Simu_Numd;   %200;               %����·���ڵ���������C#AP�ڵ�������·�߽ڵ㣩
Realx = Realxd;         %zeros(1,Simu_Num); %·���ڵ�������꣨����C#AP�ڵ�������·�߽ڵ㣩
Realy = Realyd;         %zeros(1,Simu_Num); %·���ڵ��������꣨����C#AP�ڵ�������·�߽ڵ㣩


%% ����CDF����
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
        %����NN��λ�㷨
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
        %����knn��λ�㷨��kȡ2
        %loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,2,2);
        %error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        %for k=1:1:21
        %    if (error<base_array(k))
        %        knn2_cdf(k)=knn2_cdf(k)+1;
        %    end
        %end
        %knn2_sum=knn2_sum+error;
    
        %����knn��λ�㷨��kȡ3
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,2,3);        
        error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        for k=1:1:21
            if (error<base_array(k))
                knn3_cdf(k)=knn3_cdf(k)+1;
            end
        end
        knn3_sum=knn3_sum+error;
    
        %����knn��λ�㷨��kȡ4
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
        %����wknn��λ�㷨��kȡ2
        %loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,3,2);
        %error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        %for k=1:1:21
        %    if (error<base_array(k))
        %        wknn2_cdf(k)=wknn2_cdf(k)+1;
        %    end
        %end
        %wknn2_sum=wknn2_sum+error;
    
        %����wknn��λ�㷨��kȡ3
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,3,3);
        error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
        for k=1:1:21
            if (error<base_array(k))
                wknn3_cdf(k)=wknn3_cdf(k)+1;
            end
        end
        wknn3_sum=wknn3_sum+error;
    
        %����wknn��λ�㷨��kȡ4
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
    
        %����wknn��λ�㷨��kȡ5
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
        %���ñ�Ҷ˹�㷨
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

%��ͬ�㷨��λƽ�����
%fprintf('nn=%f\n',nn_sum/Simu_Num);
%fprintf('knn2=%f\n',knn2_sum/Simu_Num);
%fprintf('knn3=%f\n',knn3_sum/Simu_Num);
%fprintf('knn4=%f\n',knn4_sum/Simu_Num);
%fprintf('wknn2=%f\n',wknn2_sum/Simu_Num);
%fprintf('wknn3=%f\n',wknn3_sum/Simu_Num);
%fprintf('wknn4=%f\n',wknn4_sum/Simu_Num);
%fprintf('wknn5=%f\n',wknn5_sum/Simu_Num);
%fprintf('bayes=%f\n',bayes_sum/Simu_Num);


figure('NumberTitle', 'off', 'Name', 'CDF����ͼ');
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


%% ���Ʒ���·��
if(1 == Task)
figure('NumberTitle', 'off', 'Name', '����·��ͼ');
%���������᷶Χ
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
  
%��ά����洢�����������
loc_point_1 = zeros(Simu_Num, 2);
loc_point_2 = zeros(Simu_Num, 2);
loc_point_3 = zeros(Simu_Num, 2);
loc_point_4 = zeros(Simu_Num, 2);

for i=1:1:Simu_Num
    noise=normrnd(0,0);
    
    H3 = plot(Realx(i),Realy(i),'k.-');
    hold on;
    
    if(0 == Algo || 1 == Algo)
        %����nn��λ�㷨
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,1,1);
        loc_point_1(i,1) = loc_point(1);
        loc_point_1(i,2) = loc_point(2);
        H4 = plot(loc_point(1),loc_point(2),'g<-');
        hold on;
        legend([H1(1),H2(1),H3(1),H4(1)],'ָ�ƽڵ�','AP�ڵ�','��ʵ·��','NN��λ·��');
    end
    
    if(0 == Algo || 2 == Algo)
        %����knn��λ�㷨��kȡ3
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,2,3);
        loc_point_2(i,1) = loc_point(1);
        loc_point_2(i,2) = loc_point(2);
        H5 = plot(loc_point(1),loc_point(2),'b*-');
        hold on;
            legend([H1(1),H2(1),H3(1),H5(1)],'ָ�ƽڵ�','AP�ڵ�','��ʵ·��','KNN3·��');
    end
    
    if(0 == Algo || 3 == Algo)
        %����wknn��λ�㷨��kȡ3
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,3,3);
        loc_point_3(i,1) = loc_point(1);
        loc_point_3(i,2) = loc_point(2);
        H6=plot(loc_point(1),loc_point(2),'r+-');
        hold on;
            legend([H1(1),H2(1),H3(1),H6(1)],'ָ�ƽڵ�','AP�ڵ�','��ʵ·��','WKNN3·��');
    end
    
    if(0 == Algo || 4 == Algo)
        %���ñ�Ҷ˹�㷨
        loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,4,2);
        loc_point_4(i,1) = loc_point(1);
        loc_point_4(i,2) = loc_point(2);
        H7=plot(loc_point(1),loc_point(2),'co-');
        hold on;
            legend([H1(1),H2(1),H3(1),H7(1)],'ָ�ƽڵ�','AP�ڵ�','��ʵ·��','��Ҷ˹�㷨·��');
    end
end

%������ʵ������·��
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
    legend([H1(1),H2(1),H3(1),H4(1),H5(1),H6(1),H7(1)],'ָ�ƽڵ�','AP�ڵ�','��ʵ·��','NN��λ·��','KNN3·��','WKNN3·��','��Ҷ˹�㷨·��');
end
end
