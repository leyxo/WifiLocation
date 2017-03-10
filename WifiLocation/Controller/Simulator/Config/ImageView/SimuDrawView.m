//
//  SimuDrawView.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/09.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "SimuDrawView.h"

@implementation SimuDrawView
@synthesize map, fp, simu;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
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
}

@end
