//
//  CDFDrawView.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/10.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "CDFDrawView.h"

@implementation CDFDrawView
@synthesize map, ap, fp, simu, algo;

- (void)drawRect:(CGRect)rect {
   
}


#pragma mark - 核心部分：算法
// 仿真算法主函数
- (void)mainWithTaskd:(int)Taskd
                Algod:(int)Algod
               Map_Xd:(int)Map_Xd
               Map_Yd:(int)Map_Yd
              AP_Numd:(int)AP_Numd
                 APxd:(NSMutableArray*)APxd
                 APyd:(NSMutableArray*)APyd
            ap_powerd:(NSMutableArray*)ap_powerd
             ap_gaind:(NSMutableArray*)ap_gaind
              ap_rssd:(NSMutableArray*)ap_rssd
              FP_Numd:(int)FP_Numd
                 FPxd:(NSMutableArray*)FPxd
                 FPyd:(NSMutableArray*)FPyd
             fp_gaind:(int)fp_gaind
            Simu_Numd:(int)Simu_Numd
               Realxd:(NSMutableArray*)Realxd
               Realyd:(NSMutableArray*)Realyd
              context:(CGContextRef)context{
   
   //***************实验内容****************
   int Task = Taskd;           //1;             //1:仿真实验 2:CDF曲线
   //*****************算法******************
   int Algo = Algod;           //0;             //0:所有算法 1:NN 2:KNN 3:WKNN 4:贝叶斯
   //***************地图尺寸****************
   int Mapx = Map_Xd;
   int Mapy = Map_Yd;
   //************AP节点个数与坐标***********
   NSMutableArray *APx = APxd; //[18 84 2 2];   //AP节点横坐标（连接C#AP节点配置中坐标参数）
   NSMutableArray *APy = APyd; //[44 46 2 56];  //AP节点纵坐标（连接C#AP节点配置中坐标参数）
   int AP_Num = AP_Numd;       //4;             //AP点个数
   NSMutableArray *ap_power = ap_powerd;        //AP节点发送功率（连接C#AP节点配置中发送参数） % [20 18 18 18];%dbm
   NSMutableArray *ap_gain = ap_gaind;          //AP节点发送增益（连接C#AP节点配置中发送增益） % [7 6 6 6]; %dbi
   NSMutableArray *ap_rss = ap_rssd;            //非参考AP接收参考AP信号强度（连接C#AP节点配置中接收节点信号强度）
   NSMutableArray *DIS = [[NSMutableArray alloc] initWithCapacity:AP_Num-1];               //DIS存储各非主AP与主AP间距
   
   for(int i=0; i<AP_Num-1; i++)
   {
      double dis=sqrt(
                      ([[APx objectAtIndex:0] intValue]-[[APx objectAtIndex:i+1] intValue])*
                      ([[APx objectAtIndex:0] intValue]-[[APx objectAtIndex:i+1] intValue])+
                      ([[APy objectAtIndex:0] intValue]-[[APy objectAtIndex:i+1] intValue])*
                      ([[APy objectAtIndex:0] intValue]-[[APy objectAtIndex:i+1] intValue]));
      [DIS addObject:[NSNumber numberWithDouble:dis]];
   }
   
   double Nn = 0;
   double Faf = 0;
   int index = 1;
   double loss_d1 = 32.44+20*log10(2400)+20*log10((double)1.0/1000.0);
   
   for(int i=0; i<AP_Num-2; i++)      //路径损耗指数与FAF自适应
   {
      for(int j=i+1; j<AP_Num-1; j++)
      {
         if([[DIS objectAtIndex:j] doubleValue]==[[DIS objectAtIndex:i] doubleValue])
            continue;
         
         double n = ([[ap_rss objectAtIndex:i] intValue]-[[ap_rss objectAtIndex:j] intValue])/
         (10*log10([[DIS objectAtIndex:j] doubleValue]/[[DIS objectAtIndex:i] doubleValue]));
         Nn = Nn + n;
         double faf = loss_d1-[[ap_rss objectAtIndex:j] intValue] - 10*n*log10([[DIS objectAtIndex:j] doubleValue]);
         Faf = Faf + faf;
         index = index + 1;
      }
   }
   
   double N = Nn/index;      //自适应后的路径损耗指数值
   double FAF = Faf/index;   //自适应后的FAF值
   
   //************FP节点个数与坐标**********
   int FP_Num = FP_Numd;       //580;               //指纹节点个数（从C#指纹库中获取）
   NSMutableArray *FPx = FPxd; //zeros(1,FP_Num);   //指纹横轴坐标
   NSMutableArray *FPy = FPyd; //zeros(1,FP_Num);   //指纹纵轴坐标
   int fp_gain = fp_gaind;     //2; //dbi           //接收增益（连接C#指纹节点配置中接收增益）
   
   
   //*************指纹信号数据*************
   NSMutableArray *fp_power = [self ReceivePowerFunWithAPx:APx APy:APy FPx:FPx FPy:FPy ap_power:ap_power ap_gain:ap_gain fp_gain:fp_gain N:N FAF:FAF loss_d1:loss_d1];
   
   
   //*************定位仿真数据*************
   int Simu_Num = Simu_Numd;         //仿真路径节点数（连接C#AP节点配置中路线节点）
   NSMutableArray *Realx = Realxd;   //路径节点横轴坐标（连接C#AP节点配置中路线节点）
   NSMutableArray *Realy = Realyd;   //路径节点纵轴坐标（连接C#AP节点配置中路线节点）
   
   
   ////// 绘制CDF曲线
   //if(2 == Task)
   //nn_cdf=zeros(1,21);
   //knn2_cdf=zeros(1,21);
   //knn3_cdf=zeros(1,21);
   //knn4_cdf=zeros(1,21);
   //wknn2_cdf=zeros(1,21);
   //wknn3_cdf=zeros(1,21);
   //wknn4_cdf=zeros(1,21);
   //wknn5_cdf=zeros(1,21);
   //bayes_cdf=zeros(1,21);
   //
   //base_array=0:0.1:2;
   //
   //nn_sum=0;
   //knn2_sum=0;
   //knn3_sum=0;
   //knn4_sum=0;
   //wknn2_sum=0;
   //wknn3_sum=0;
   //wknn4_sum=0;
   //wknn5_sum=0;
   //bayes_sum=0;
   //
   //
   //for i=1:1:Simu_Num
   //noise=normrnd(0,0);
   //
   //if(0 == Algo || 1 == Algo)
   ////调用NN定位算法
   //loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,1,1);
   //error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
   //   for k=1:1:21
   //      if (error<base_array(k))
   //         nn_cdf(k)=nn_cdf(k)+1;
   //   %nn_cdf(k)=nn_cdf(k)+error;
   //   %fprintf('nn_cdf=%f\n',nn_cdf(k));
   //   end
   //   end
   //   nn_sum=nn_sum+error;
   //   end
   //
   //   if(0 == Algo || 2 == Algo)
   //
   //
   //      //调用knn定位算法，k取3
   //      loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,2,3);
   //   error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
   //   for k=1:1:21
   //      if (error<base_array(k))
   //         knn3_cdf(k)=knn3_cdf(k)+1;
   //   end
   //   end
   //   knn3_sum=knn3_sum+error;
   //   end
   //
   //   if(0 == Algo || 3 == Algo)
   //
   //      //调用wknn定位算法，k取3
   //      loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,3,3);
   //   error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
   //   for k=1:1:21
   //      if (error<base_array(k))
   //         wknn3_cdf(k)=wknn3_cdf(k)+1;
   //   end
   //   end
   //   wknn3_sum=wknn3_sum+error;
   //
   //   end
   //
   //   if(0 == Algo || 4 == Algo)
   //      //调用贝叶斯算法
   //      loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,Realx(i),Realy(i),noise,N,FAF,loss_d1,4,2);
   //   error=sqrt((loc_point(1)-Realx(i))*(loc_point(1)-Realx(i))+(loc_point(2)-Realy(i))*(loc_point(2)-Realy(i)));
   //   for k=1:1:21
   //      if (error<base_array(k))
   //         bayes_cdf(k)=bayes_cdf(k)+1;
   //   %bayes_cdf(k)=bayes_cdf(k)+error;
   //   %fprintf('bayes_cdf=%f\n',bayes_cdf(k));s
   //   end
   //   end
   //   bayes_sum=bayes_sum+error;
   //   end
   //   end
   //
   //   //不同算法定位平均误差
   //   //fprintf('nn=%f\n',nn_sum/Simu_Num);
   //   //fprintf('knn3=%f\n',knn3_sum/Simu_Num);
   //   //fprintf('wknn3=%f\n',wknn3_sum/Simu_Num);
   //   //fprintf('bayes=%f\n',bayes_sum/Simu_Num);
   //
   //
   //   //figure('NumberTitle', 'off', 'Name', 'CDF曲线图');
   //   if(0 == Algo || 1 == Algo)
   //      plot(base_array,nn_cdf/Simu_Num,'g<-');
   //   hold on
   //   legend('NN');
   //   end
   //   if(0 == Algo || 2 == Algo)
   //      plot(base_array,knn3_cdf/Simu_Num,'b*-');
   //   hold on
   //   legend('KNN3');
   //   end
   //   if(0 == Algo || 3 == Algo)
   //      plot(base_array,wknn3_cdf/Simu_Num,'r+-');
   //   hold on
   //   legend('WKNN3');
   //   end
   //   if(0 == Algo || 4 == Algo)
   //      plot(base_array,bayes_cdf/Simu_Num,'co-');
   //   hold on
   //   legend('Bayes');
   //   end
   //   
   //   if(0 == Algo)
   //      legend('nn','knn3','wknn3','bayes');
   //   end
   //   
   //   xlabel('Error distance(m)')
   //   ylabel('Cumulative distribution function')
   //   title('CDF Comparison')
   //   
   //   end
}


// 返回指纹RSS库二维数组
- (NSMutableArray *)ReceivePowerFunWithAPx:(NSMutableArray*)APx
                                       APy:(NSMutableArray*)APy
                                       FPx:(NSMutableArray*)FPx
                                       FPy:(NSMutableArray*)FPy
                                  ap_power:(NSMutableArray*)ap_power
                                   ap_gain:(NSMutableArray*)ap_gain
                                   fp_gain:(int)fp_gain
                                         N:(int)N
                                       FAF:(int)FAF
                                   loss_d1:(int)loss_d1 {
   NSUInteger ap_num = APx.count;  //AP个数矩阵的行数和列数
   NSUInteger fp_num = FPx.count;  //指纹矩阵的行数和列数
   NSMutableArray * fp_power = [[NSMutableArray alloc] initWithCapacity:fp_num]; // 二维数组，外层是FP个数，内层是AP个数
   
   for (NSUInteger i=0; i<fp_num; i++)
   {
      // 用作fp_power的内层嵌套数组
      NSMutableArray * ap_temp = [[NSMutableArray alloc] initWithCapacity:ap_num];
      for (NSUInteger j=0; j<ap_num; j++)
      {
         double dis=sqrt(
                         ([[FPx objectAtIndex:i] intValue]-[[APx objectAtIndex:j] intValue])*
                         ([[FPx objectAtIndex:i] intValue]-[[APx objectAtIndex:j] intValue])
                         +([[FPy objectAtIndex:i] intValue]-[[APy objectAtIndex:j] intValue])*
                         ([[FPy objectAtIndex:i] intValue]-[[APy objectAtIndex:j] intValue])
                         );
         
         int loss_dx=loss_d1+10*N*log10(dis)+FAF;
         
         int v=[[ap_power objectAtIndex:j] intValue] + [[ap_gain objectAtIndex:j] intValue] + fp_gain - loss_dx;
         [ap_temp addObject: [NSNumber numberWithInt:v]];
      }
      [fp_power addObject:ap_temp];
   }
   return fp_power;
}

// 返回定位结果坐标集合二维数组
- (NSMutableArray *)FingerLocFunWithAPx:(NSMutableArray*)APx
                                    APy:(NSMutableArray*)APy
                                    FPx:(NSMutableArray*)FPx
                                    FPy:(NSMutableArray*)FPy
                               fp_power:(NSMutableArray*)fp_power
                               ap_power:(NSMutableArray*)ap_power
                                ap_gain:(NSMutableArray*)ap_gain
                                fp_gain:(int)fp_gain
                                    p_x:(int)p_x
                                    p_y:(int)p_y
                                  noise:(int)noise
                                      N:(int)N
                                    FAF:(int)FAF
                                loss_d1:(int)loss_d1
                                     ID:(int)ID
                                      k:(int)k {
   //算法ID号:  1 NN 2 KNN 3 WKNN 4 Bayes
   
   NSUInteger ap_num = APx.count;  //AP个数矩阵的行数和列数
   NSUInteger fp_num = FPx.count;  //指纹矩阵的行数和列数
   NSMutableArray * rp_power = [[NSMutableArray alloc] initWithCapacity:ap_num];
   
   for (NSUInteger j=0; j<ap_num; j++)
   {
      int dis = sqrt((p_x - [[APx objectAtIndex:j] intValue])*
                     (p_x - [[APx objectAtIndex:j] intValue])
                     +(p_y - [[APy objectAtIndex:j] intValue])*
                     (p_y - [[APy objectAtIndex:j] intValue]));
      int loss_dx=loss_d1+10*N*log10(dis)+FAF;
      
      int v = [[ap_power objectAtIndex:j] intValue] + [[ap_gain objectAtIndex:j] intValue] + fp_gain - loss_dx - noise; //待定位点接收到各AP强度值
      [rp_power addObject:[NSNumber numberWithInt:v]];
   }
   
   NSMutableArray * dis_power = [[NSMutableArray alloc] initWithCapacity:fp_num];   //待定位点收到各AP节点的强度值与所有指纹节点收到各AP节点信号强度的差值和
   for (int i=0; i<fp_num; i++)
   {
      int d_sum = 0;
      for (int j=0; j<ap_num; j++)
      {
         d_sum=([[[fp_power objectAtIndex:i] objectAtIndex:j] intValue] - [[rp_power objectAtIndex:j] intValue])*
         ([[[fp_power objectAtIndex:i] objectAtIndex:j] intValue] - [[rp_power objectAtIndex:j] intValue]) + d_sum;
      }
      [dis_power addObject:[NSNumber numberWithInt:sqrt(d_sum)]];
   }
   
   NSMutableArray *temp_fpx = FPx;
   NSMutableArray *temp_fpy = FPy;
   NSMutableArray *temp_dispow = dis_power;
   NSMutableArray *temp_power = fp_power;       //指纹节点收到各AP节点信号强度
   
   for(int i=0; i<fp_num-2; i++)                 //冒泡法排序
   {
      for(int j=0; j<fp_num-1-i; j++)
      {
         if([[temp_dispow objectAtIndex:j] intValue] > [[temp_dispow objectAtIndex:j+1] intValue])
         {
            [temp_dispow exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            //对接收信号强度值该行的所有值进行交换
            [temp_power exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            [temp_fpx exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            [temp_fpy exchangeObjectAtIndex:j withObjectAtIndex:j+1];
         }
      }
   }
   
   double x_sum = 0;
   double y_sum = 0;
   double u = 0;
   double sigma = 0.3;
   double w_sum = 0.0; // WKNN
   NSMutableArray * p_list = [[NSMutableArray alloc] initWithCapacity:fp_num]; //贝叶斯
   double p_APj_FP = 0.0;  // 贝叶斯
   double p_APj_FPi = 0.0; // 贝叶斯
   
   switch (ID)
   {
      case 1:                                            // NN
         x_sum=[[temp_fpx objectAtIndex:0] intValue];
         y_sum=[[temp_fpy objectAtIndex:0] intValue];
         break;
      case 2:                                            // KNN
         for(int i=0; i<k; i++)
         {
            x_sum = x_sum + [[temp_fpx objectAtIndex:i] intValue];
            y_sum = y_sum + [[temp_fpy objectAtIndex:i] intValue];
         }
         x_sum = x_sum * 1.0 / k;
         y_sum = y_sum * 1.0 / k;
         break;
      case 3:                                            // WKNN
         w_sum = 0.0;
         for(int i=0; i<k; i++)
         {
            x_sum = x_sum + [[temp_fpx objectAtIndex:i] intValue]*(1.0/([[temp_dispow objectAtIndex:i] intValue] + 0.0001));
            y_sum = y_sum + [[temp_fpy objectAtIndex:i] intValue]*(1.0/([[temp_dispow objectAtIndex:i] intValue] + 0.0001));
            w_sum = w_sum + 1.0 / ([[temp_dispow objectAtIndex:i] intValue] + 0.0001);
         }
         x_sum=x_sum*1.0/w_sum;
         y_sum=y_sum*1.0/w_sum;
         break;
      case 4:                                            // 贝叶斯
         for(int i=0; i<fp_num; i++)
         {
            //获取P(APj|指纹i)的后验概率值
            p_APj_FPi = 1.0;
            for(int j=0; j<ap_num; j++)
            {
               double Skj = [[[fp_power objectAtIndex:i] objectAtIndex:j] intValue];
               double U = Skj + u;
               p_APj_FPi = p_APj_FPi*1.0 / sqrt(2 * 3.1415926) / sigma * exp(-0.5 * ([[rp_power objectAtIndex:j] intValue] - U) * ([[rp_power objectAtIndex:j] intValue] - U) / (sigma * sigma));
            }
            [p_list addObject:[NSNumber numberWithDouble:p_APj_FPi]];
            p_APj_FP = p_APj_FP + p_APj_FPi;
         }
         
         for(int i=0; i<fp_num; i++)
         {
            x_sum = x_sum + [[FPx objectAtIndex:i] doubleValue] * [[p_list objectAtIndex:i] doubleValue] / p_APj_FP;
            y_sum = y_sum + [[FPy objectAtIndex:i] doubleValue] * [[p_list objectAtIndex:i] doubleValue] / p_APj_FP;
         }
         //p_list/p_APj_FP
   }
   
   // 返回这个点
   NSMutableArray *simuPoint = [[NSMutableArray alloc] initWithCapacity:2];
   [simuPoint addObject:[NSNumber numberWithDouble:x_sum]];
   [simuPoint addObject:[NSNumber numberWithDouble:y_sum]];
   return simuPoint;
}

@end
