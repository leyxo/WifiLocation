//
//  StartDrawView.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/10.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "StartDrawView.h"

@implementation StartDrawView
@synthesize map, ap, fp, simu, algo;

- (void)drawRect:(CGRect)rect {
   // 定点定义(即地图的边界顶点坐标)
   float x = 0;
   float y = 0;
   float x1 = 0;
   float y1 = 0;
   float x2 = 0;
   float y2 = 0;
   float x3 = 0;
   float y3 = 0;
   float x4 = 0;
   float y4 = 0;
   
   // 获取View边界
   CGRect viewBounds = self.bounds;
   // 向内收缩，自定义绘图矩形边界
   // ******这里把bounds的参数height和width当做点坐标来用，而不是尺寸!!!方便后面绘图
   CGRect bounds = CGRectMake(viewBounds.origin.x + 20, viewBounds.origin.y + 16, viewBounds.size.width - 20, viewBounds.size.height - 16);
   
   if ((float)map.map_height / (float)map.map_width > (float)(bounds.size.height-bounds.origin.y) / (float)(bounds.size.width-bounds.origin.x))
   {
      // 地图特别高 上下顶格
      y1 = bounds.origin.y;
      y2 = bounds.origin.y;
      y3 = bounds.size.height;
      y4 = bounds.size.height;
      
      float x = (float)(bounds.size.height-bounds.origin.y) * (float)map.map_width / (float)map.map_height;
      x1 = (float)(bounds.size.width-bounds.origin.x) / 2 - x / 2 + bounds.origin.x;
      x2 = (float)(bounds.size.width-bounds.origin.x) / 2 + x / 2 + bounds.origin.x;
      x3 = (float)(bounds.size.width-bounds.origin.x) / 2 + x / 2 + bounds.origin.x;
      x4 = (float)(bounds.size.width-bounds.origin.x) / 2 - x / 2 + bounds.origin.x;
   }
   else
   {
      // 地图特别宽 左右顶格
      x1 = bounds.origin.x;
      x2 = bounds.size.width;
      x3 = bounds.size.width;
      x4 = bounds.origin.x;
      
      float y = (float)(bounds.size.width-bounds.origin.x) * (float)map.map_height / (float)map.map_width;
      y1 = (float)(bounds.size.height-bounds.origin.y) / 2 - y / 2 + bounds.origin.y;
      y2 = (float)(bounds.size.height-bounds.origin.y) / 2 - y / 2 + bounds.origin.y;
      y3 = (float)(bounds.size.height-bounds.origin.y) / 2 + y / 2 + bounds.origin.y;
      y4 = (float)(bounds.size.height-bounds.origin.y) / 2 + y / 2 + bounds.origin.y;
   }
   
   
   // 获得处理的上下文
   CGContextRef context = UIGraphicsGetCurrentContext();
   // 设置线条样式
   CGContextSetLineCap(context, kCGLineCapRound);
   // 设置线条粗细宽度
   CGContextSetLineWidth(context, 2.0);
   // 设置颜色
   CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
   
   
   // 开始一个起始路径
   CGContextBeginPath(context);
   // 起始点
   CGContextMoveToPoint(context, x1, y1);
   // 设置下一个坐标点
   CGContextAddLineToPoint(context, x2, y2);
   // 设置下一个坐标点
   CGContextAddLineToPoint(context, x3, y3);
   // 设置下一个坐标点
   CGContextAddLineToPoint(context, x4, y4);
   //设 置下一个坐标点
   CGContextAddLineToPoint(context, x1, y1);
   // 连接上面定义的坐标点
   CGContextStrokePath(context);
   
   
   
   // 绘制AP节点
   sqliteHelper = [[SQLiteHelper alloc] init];
   [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   NSMutableArray *APArray = [[NSMutableArray alloc] init];
   APArray =  [sqliteHelper selectFromAPInfo:self.map.map_id];
   for(int i = 0; i < APArray.count; i ++) {
      ap = [APArray objectAtIndex:i];
      float ap_x = ap.ap_x;
      float ap_y = ap.ap_y;
      NSString *ap_isrefer = ap.ap_isrefer;
      
      // 计算点实际坐标
      x = ap_x * (x2 - x1) / map.map_width + x1;
      y = ap_y * (y3 - y2) / map.map_height + y1;
      
      // 绘制AP节点
      if ([@"是" isEqual: ap_isrefer]) // 参考节点
      {
         CGContextSetRGBStrokeColor(context,1,0,0,1.0);//画笔线的颜色
         CGContextSetLineWidth(context,1.0);//线的宽度
         CGContextAddArc(context,x,y,3,0,2*3.14,0);//添加一个圆
         CGContextDrawPath(context,kCGPathStroke);//绘制路径
         CGContextAddArc(context,x,y,3,0,2*3.14,0);//添加一个圆
         CGContextDrawPath(context,kCGPathFill);//绘制填充
         CGContextAddArc(context,x,y,9,0,2*3.14,0);//添加一个中圆
         CGContextDrawPath(context,kCGPathStroke);//绘制路径
      }
      else // 其他节点
      {
         CGContextSetRGBStrokeColor(context,0,0,1,1.0);//画笔线的颜色
         CGContextSetLineWidth(context,1.0);//线的宽度
         CGContextAddArc(context,x,y,3,0,2*3.14,0);//添加一个圆
         CGContextDrawPath(context,kCGPathStroke);//绘制路径
         CGContextAddArc(context,x,y,3,0,2*3.14,0);//添加一个圆
         CGContextDrawPath(context,kCGPathFill);//绘制填充
         CGContextAddArc(context,x,y,9,0,2*3.14,0);//添加一个中圆
         CGContextDrawPath(context,kCGPathStroke);//绘制路径
      }
   }
   
   
   
   // 绘制FP节点
   sqliteHelper = [[SQLiteHelper alloc] init];
   [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   NSMutableArray *FPArray = [[NSMutableArray alloc] init];
   FPArray =  [sqliteHelper selectFromFPInfo:self.map.map_id];
   for(int i = 0; i < FPArray.count; i ++) {
      fp = [FPArray objectAtIndex:i];
      float fp_x = fp.fp_x;
      float fp_y = fp.fp_y;
      
      // 计算点实际坐标
      x = fp_x * (x2 - x1) / map.map_width + x1;
      y = fp_y * (y3 - y2) / map.map_height + y1;
      
      // 绘制FP节点
      CGContextSetRGBStrokeColor(context,0.3,0.3,0.3,1.0);//画笔线的颜色
      CGContextSetLineWidth(context,1.0);//线的宽度
      CGContextAddArc(context,x,y,1,0,2*3.14,0);//添加一个圆点
      CGContextDrawPath(context,kCGPathStroke);//绘制路径
   }
   
   
   
   // 绘制仿真路径节点
   //   sqliteHelper = [[SQLiteHelper alloc] init];
   //   [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   NSMutableArray *SimuArray = [[NSMutableArray alloc] init];
   SimuArray =  [sqliteHelper selectFromSimuInfo:self.map.map_id];
   
   // ***画出路径***
   // 开始一个起始路径
   CGContextSetRGBStrokeColor(context,0,0,0,1.0);//画笔线的颜色
   CGContextSetLineWidth(context,1.0);//线的宽度
   CGContextBeginPath(context);
   for(int i = 0; i < SimuArray.count; i ++) {
      simu = [SimuArray objectAtIndex:i];
      float simu_x = simu.real_x;
      float simu_y = simu.real_y;
      
      // 计算点实际坐标
      x = simu_x * (x2 - x1) / map.map_width + x1;
      y = simu_y * (y3 - y2) / map.map_height + y1;
      
      // 绘制仿真节点的路径
      if(0 == i){
         // 起始点
         CGContextMoveToPoint(context, x, y);
      }
      else {
         // 设置下一个坐标点
         CGContextAddLineToPoint(context, x, y);
      }
   }
   // 连接上面定义的坐标点
   CGContextStrokePath(context);
   
   // ***描绘出点***
   CGContextSetRGBStrokeColor(context,0.2,0.2,0.6,1.0);//画笔线的颜色
   for(int i = 0; i < SimuArray.count; i ++) {
      simu = [SimuArray objectAtIndex:i];
      float simu_x = simu.real_x;
      float simu_y = simu.real_y;
      
      // 计算点实际坐标
      x = simu_x * (x2 - x1) / map.map_width + x1;
      y = simu_y * (y3 - y2) / map.map_height + y1;
      
      CGContextAddArc(context,x,y,1,0,2*3.14,0);//添加一个圆点
      CGContextDrawPath(context,kCGPathStroke);//绘制路径
   }
   
   
   // ////////////////////////////////////////////////////////////////////
   // ///////////////////////////**开始实验**//////////////////////////////
   // ////////////////////////////////////////////////////////////////////
   
   if(APArray.count > 0 && FPArray.count > 0 && SimuArray.count > 0)
   {
      // 取出每项单独的NSMutableArray
      int AP_Numd = (int)APArray.count;
      NSMutableArray *APxd = [[NSMutableArray alloc] initWithCapacity:AP_Numd];
      NSMutableArray *APyd = [[NSMutableArray alloc] initWithCapacity:AP_Numd];
      NSMutableArray *ap_powerd = [[NSMutableArray alloc] initWithCapacity:AP_Numd];
      NSMutableArray *ap_gaind = [[NSMutableArray alloc] initWithCapacity:AP_Numd];
      NSMutableArray *ap_rssd = [[NSMutableArray alloc] initWithCapacity:AP_Numd-1];
      for(int i=0; i<AP_Numd; i++)
      {
         ap = [APArray objectAtIndex:i];
         [APxd addObject:[NSNumber numberWithInt:ap.ap_x]];
         [APyd addObject:[NSNumber numberWithInt:ap.ap_y]];
         [ap_powerd addObject:[NSNumber numberWithInt:ap.ap_sendpower]];
         [ap_gaind addObject:[NSNumber numberWithInt:ap.ap_sendgain]];
         if([@"" isEqual: ap.ap_isrefer]){
            [ap_rssd addObject:[NSNumber numberWithInt:ap.ap_receiverefer]];
         }
      }
      
      int FP_Numd = (int)FPArray.count;
      NSMutableArray *FPxd = [[NSMutableArray alloc] initWithCapacity:FP_Numd];
      NSMutableArray *FPyd = [[NSMutableArray alloc] initWithCapacity:FP_Numd];
      int fp_gaind = 0;
      for(int i=0; i<FP_Numd; i++)
      {
         fp = [FPArray objectAtIndex:i];
         [FPxd addObject:[NSNumber numberWithInt:fp.fp_x]];
         [FPyd addObject:[NSNumber numberWithInt:fp.fp_y]];
         fp_gaind = fp.fp_receivegain;
      }
      
      int Simu_Numd = (int)SimuArray.count;
      NSMutableArray *Realxd = [[NSMutableArray alloc] initWithCapacity:Simu_Numd];
      NSMutableArray *Realyd = [[NSMutableArray alloc] initWithCapacity:Simu_Numd];
      for(int i=0; i<Simu_Numd; i++)
      {
         simu = [SimuArray objectAtIndex:i];
         [Realxd addObject:[NSNumber numberWithInt:simu.real_x]];
         [Realyd addObject:[NSNumber numberWithInt:simu.real_y]];
      }
      
      // 调用主函数
      [self mainWithTaskd:1
                    Algod:algo
                   Map_Xd:map.map_width
                   Map_Yd:map.map_height
                  AP_Numd:(int)APArray.count
                     APxd:APxd
                     APyd:APyd
                ap_powerd:ap_powerd
                 ap_gaind:ap_gaind
                  ap_rssd:ap_rssd
                  FP_Numd:(int)FPArray.count
                     FPxd:FPxd
                     FPyd:FPyd
                 fp_gaind:fp_gaind
                Simu_Numd:(int)SimuArray.count
                   Realxd:Realxd
                   Realyd:Realyd
                  context:context];
   }
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

   // 绘制仿真路线
   // 二维数组存储仿真结果坐标点
   NSMutableArray *loc_point_1_x = [[NSMutableArray alloc] initWithCapacity:Simu_Num];
   NSMutableArray *loc_point_1_y = [[NSMutableArray alloc] initWithCapacity:Simu_Num];
   NSMutableArray *loc_point_2_x = [[NSMutableArray alloc] initWithCapacity:Simu_Num];
   NSMutableArray *loc_point_2_y = [[NSMutableArray alloc] initWithCapacity:Simu_Num];
   NSMutableArray *loc_point_3_x = [[NSMutableArray alloc] initWithCapacity:Simu_Num];
   NSMutableArray *loc_point_3_y = [[NSMutableArray alloc] initWithCapacity:Simu_Num];
   NSMutableArray *loc_point_4_x = [[NSMutableArray alloc] initWithCapacity:Simu_Num];
   NSMutableArray *loc_point_4_y = [[NSMutableArray alloc] initWithCapacity:Simu_Num];

   
   for(int i=0; i<Simu_Num; i++)
   {
      int noise = 0;

      if(0 == Algo || 1 == Algo)
      {
         // 调用nn定位算法
         NSMutableArray *loc_point = [self FingerLocFunWithAPx:APx APy:APy FPx:FPx FPy:FPy fp_power:fp_power ap_power:ap_power ap_gain:ap_gain fp_gain:fp_gain p_x:[[Realx objectAtIndex:i] intValue] p_y:[[Realy objectAtIndex:i] intValue] noise:noise N:N FAF:FAF loss_d1:loss_d1 ID:1 k:1];
         // 把这个定位点的坐标分别加入到loc_point_1_x和loc_point_1_y大数组
         [loc_point_1_x addObject:[loc_point objectAtIndex:0]];
         [loc_point_1_y addObject:[loc_point objectAtIndex:1]];

      }
      
      if(0 == Algo || 2 == Algo)
      {
         //调用knn定位算法，k取3
         NSMutableArray *loc_point = [self FingerLocFunWithAPx:APx APy:APy FPx:FPx FPy:FPy fp_power:fp_power ap_power:ap_power ap_gain:ap_gain fp_gain:fp_gain p_x:[[Realx objectAtIndex:i] intValue] p_y:[[Realy objectAtIndex:i] intValue] noise:noise N:N FAF:FAF loss_d1:loss_d1 ID:2 k:3];
         [loc_point_2_x addObject:[loc_point objectAtIndex:0]];
         [loc_point_2_y addObject:[loc_point objectAtIndex:1]];

      }
      
      if(0 == Algo || 3 == Algo)
      {
         //调用wknn定位算法，k取3
         NSMutableArray *loc_point = [self FingerLocFunWithAPx:APx APy:APy FPx:FPx FPy:FPy fp_power:fp_power ap_power:ap_power ap_gain:ap_gain fp_gain:fp_gain p_x:[[Realx objectAtIndex:i] intValue] p_y:[[Realy objectAtIndex:i] intValue] noise:noise N:N FAF:FAF loss_d1:loss_d1 ID:3 k:3];
         [loc_point_3_x addObject:[loc_point objectAtIndex:0]];
         [loc_point_3_y addObject:[loc_point objectAtIndex:1]];

      }
      
      if(0 == Algo || 4 == Algo)
      {
         //调用贝叶斯算法
         NSMutableArray *loc_point = [self FingerLocFunWithAPx:APx APy:APy FPx:FPx FPy:FPy fp_power:fp_power ap_power:ap_power ap_gain:ap_gain fp_gain:fp_gain p_x:[[Realx objectAtIndex:i] intValue] p_y:[[Realy objectAtIndex:i] intValue] noise:noise N:N FAF:FAF loss_d1:loss_d1 ID:4 k:2];
         [loc_point_4_x addObject:[loc_point objectAtIndex:0]];
         [loc_point_4_y addObject:[loc_point objectAtIndex:1]];

      }
   }
   
   
   // 计算地图边界坐标，为下面绘制仿真路线提供数据
   // 定点定义(即地图的边界顶点坐标)
   float x = 0;
   float y = 0;
   float x1 = 0;
   float y1 = 0;
   float x2 = 0;
   float y2 = 0;
   float x3 = 0;
   float y3 = 0;
   float x4 = 0;
   float y4 = 0;
   
   // 获取View边界
   CGRect viewBounds = self.bounds;
   // 向内收缩，自定义绘图矩形边界
   // ******这里把bounds的参数height和width当做点坐标来用，而不是尺寸!!!方便后面绘图
   CGRect bounds = CGRectMake(viewBounds.origin.x + 20, viewBounds.origin.y + 16, viewBounds.size.width - 20, viewBounds.size.height - 16);
   
   if ((float)map.map_height / (float)map.map_width > (float)(bounds.size.height-bounds.origin.y) / (float)(bounds.size.width-bounds.origin.x))
   {
      // 地图特别高 上下顶格
      y1 = bounds.origin.y;
      y2 = bounds.origin.y;
      y3 = bounds.size.height;
      y4 = bounds.size.height;
      
      float x = (float)(bounds.size.height-bounds.origin.y) * (float)map.map_width / (float)map.map_height;
      x1 = (float)(bounds.size.width-bounds.origin.x) / 2 - x / 2 + bounds.origin.x;
      x2 = (float)(bounds.size.width-bounds.origin.x) / 2 + x / 2 + bounds.origin.x;
      x3 = (float)(bounds.size.width-bounds.origin.x) / 2 + x / 2 + bounds.origin.x;
      x4 = (float)(bounds.size.width-bounds.origin.x) / 2 - x / 2 + bounds.origin.x;
   }
   else
   {
      // 地图特别宽 左右顶格
      x1 = bounds.origin.x;
      x2 = bounds.size.width;
      x3 = bounds.size.width;
      x4 = bounds.origin.x;
      
      float y = (float)(bounds.size.width-bounds.origin.x) * (float)map.map_height / (float)map.map_width;
      y1 = (float)(bounds.size.height-bounds.origin.y) / 2 - y / 2 + bounds.origin.y;
      y2 = (float)(bounds.size.height-bounds.origin.y) / 2 - y / 2 + bounds.origin.y;
      y3 = (float)(bounds.size.height-bounds.origin.y) / 2 + y / 2 + bounds.origin.y;
      y4 = (float)(bounds.size.height-bounds.origin.y) / 2 + y / 2 + bounds.origin.y;
   }
   
   //***绘制真实及仿真路线
   if(0 == Algo || 1 == Algo)
   {
      // ***画出路径***
      // 开始一个起始路径
      CGContextSetRGBStrokeColor(context,1,0,0,1.0);//画笔线的颜色
      CGContextSetLineWidth(context,1.0);//线的宽度
      CGContextBeginPath(context);
      for(int i = 0; i < loc_point_1_x.count; i ++) {
         float simu_x = [[loc_point_1_x objectAtIndex:i] floatValue];
         float simu_y = [[loc_point_1_y objectAtIndex:i] floatValue];
         
         // 计算点实际坐标
         x = simu_x * (x2 - x1) / map.map_width + x1;
         y = simu_y * (y3 - y2) / map.map_height + y1;
         
         // 绘制仿真节点的路径
         if(0 == i){
            // 起始点
            CGContextMoveToPoint(context, x, y);
         }
         else {
            // 设置下一个坐标点
            CGContextAddLineToPoint(context, x, y);
         }
      }
      // 连接上面定义的坐标点
      CGContextStrokePath(context);
      
      // ***描绘出点***
      CGContextSetRGBStrokeColor(context,0.7,0,0,1.0);//画笔线的颜色
      for(int i = 0; i < loc_point_1_x.count; i ++) {
         float simu_x = [[loc_point_1_x objectAtIndex:i] floatValue];
         float simu_y = [[loc_point_1_y objectAtIndex:i] floatValue];
         
         // 计算点实际坐标
         x = simu_x * (x2 - x1) / map.map_width + x1;
         y = simu_y * (y3 - y2) / map.map_height + y1;
         
         CGContextAddArc(context,x,y,3,0,2*3.14,0);//添加一个圆点
         CGContextDrawPath(context,kCGPathStroke);//绘制路径
      }
   }
   if(0 == Algo || 2 == Algo)
   {
      // ***画出路径***
      // 开始一个起始路径
      CGContextSetRGBStrokeColor(context,0,1,0,1.0);//画笔线的颜色
      CGContextSetLineWidth(context,1.0);//线的宽度
      CGContextBeginPath(context);
      for(int i = 0; i < loc_point_2_x.count; i ++) {
         float simu_x = [[loc_point_2_x objectAtIndex:i] floatValue];
         float simu_y = [[loc_point_2_y objectAtIndex:i] floatValue];
         
         // 计算点实际坐标
         x = simu_x * (x2 - x1) / map.map_width + x1;
         y = simu_y * (y3 - y2) / map.map_height + y1;
         
         // 绘制仿真节点的路径
         if(0 == i){
            // 起始点
            CGContextMoveToPoint(context, x, y);
         }
         else {
            // 设置下一个坐标点
            CGContextAddLineToPoint(context, x, y);
         }
      }
      // 连接上面定义的坐标点
      CGContextStrokePath(context);
      
      // ***描绘出点***
      CGContextSetRGBStrokeColor(context,0,0.7,0,1.0);//画笔线的颜色
      for(int i = 0; i < loc_point_2_x.count; i ++) {
         float simu_x = [[loc_point_2_x objectAtIndex:i] floatValue];
         float simu_y = [[loc_point_2_y objectAtIndex:i] floatValue];
         
         // 计算点实际坐标
         x = simu_x * (x2 - x1) / map.map_width + x1;
         y = simu_y * (y3 - y2) / map.map_height + y1;
         
         CGContextAddArc(context,x,y,3,0,2*3.14,0);//添加一个圆点
         CGContextDrawPath(context,kCGPathStroke);//绘制路径
      }
   }
   if(0 == Algo || 3 == Algo)
   {
      // ***画出路径***
      // 开始一个起始路径
      CGContextSetRGBStrokeColor(context,0,0,1,1.0);//画笔线的颜色
      CGContextSetLineWidth(context,1.0);//线的宽度
      CGContextBeginPath(context);
      for(int i = 0; i < loc_point_3_x.count; i ++) {
         float simu_x = [[loc_point_3_x objectAtIndex:i] floatValue];
         float simu_y = [[loc_point_3_y objectAtIndex:i] floatValue];
         
         // 计算点实际坐标
         x = simu_x * (x2 - x1) / map.map_width + x1;
         y = simu_y * (y3 - y2) / map.map_height + y1;
         
         // 绘制仿真节点的路径
         if(0 == i){
            // 起始点
            CGContextMoveToPoint(context, x, y);
         }
         else {
            // 设置下一个坐标点
            CGContextAddLineToPoint(context, x, y);
         }
      }
      // 连接上面定义的坐标点
      CGContextStrokePath(context);
      
      // ***描绘出点***
      CGContextSetRGBStrokeColor(context,0,0,0.7,1.0);//画笔线的颜色
      for(int i = 0; i < loc_point_3_x.count; i ++) {
         float simu_x = [[loc_point_3_x objectAtIndex:i] floatValue];
         float simu_y = [[loc_point_3_y objectAtIndex:i] floatValue];
         
         // 计算点实际坐标
         x = simu_x * (x2 - x1) / map.map_width + x1;
         y = simu_y * (y3 - y2) / map.map_height + y1;
         
         CGContextAddArc(context,x,y,3,0,2*3.14,0);//添加一个圆点
         CGContextDrawPath(context,kCGPathStroke);//绘制路径
      }
   }
   if(0 == Algo || 4 == Algo)
   {
      // ***画出路径***
      // 开始一个起始路径
      CGContextSetRGBStrokeColor(context,1,0.7,0,1.0);//画笔线的颜色
      CGContextSetLineWidth(context,1.0);//线的宽度
      CGContextBeginPath(context);
      for(int i = 0; i < loc_point_4_x.count; i ++) {
         float simu_x = [[loc_point_4_x objectAtIndex:i] floatValue];
         float simu_y = [[loc_point_4_y objectAtIndex:i] floatValue];
         
         // 计算点实际坐标
         x = simu_x * (x2 - x1) / map.map_width + x1;
         y = simu_y * (y3 - y2) / map.map_height + y1;
         
         // 绘制仿真节点的路径
         if(0 == i){
            // 起始点
            CGContextMoveToPoint(context, x, y);
         }
         else {
            // 设置下一个坐标点
            CGContextAddLineToPoint(context, x, y);
         }
      }
      // 连接上面定义的坐标点
      CGContextStrokePath(context);
      
      // ***描绘出点***
      CGContextSetRGBStrokeColor(context,1,0.7,0,1.0);//画笔线的颜色
      for(int i = 0; i < loc_point_4_x.count; i ++) {
         float simu_x = [[loc_point_4_x objectAtIndex:i] floatValue];
         float simu_y = [[loc_point_4_y objectAtIndex:i] floatValue];
         
         // 计算点实际坐标
         x = simu_x * (x2 - x1) / map.map_width + x1;
         y = simu_y * (y3 - y2) / map.map_height + y1;
         
         CGContextAddArc(context,x,y,3,0,2*3.14,0);//添加一个圆点
         CGContextDrawPath(context,kCGPathStroke);//绘制路径
      }
   }
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
      NSMutableArray * ap = [[NSMutableArray alloc] initWithCapacity:ap_num];
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
         [ap addObject: [NSNumber numberWithInt:v]];
      }
      [fp_power addObject:ap];
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
