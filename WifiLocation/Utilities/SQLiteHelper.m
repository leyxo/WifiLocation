//
//  SQLiteHelper.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/08.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "SQLiteHelper.h"
#import "MapModel.h"
#import "APModel.h"
#import "FPModel.h"
#import "SimuModel.h"

@implementation SQLiteHelper

#pragma mark - 打开数据库
- (void)openSqliteWithFileName:(NSString *)sqliteName {
   // sqliteName = @"wifilocation.sqlite";
   //判断数据库是否为空,如果不为空说明已经打开
   if(db != nil) {
      NSLog(@"数据库已经打开");
      return;
   }
   
   //获取文件路径
   NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
   NSString *strPath = [str stringByAppendingPathComponent:sqliteName];
   NSLog(@"%@",strPath);
   
   
   
   //*********** 强行写入/Document/wifilocation.sqlite **********************
   NSString
   *sqldocPath = [[NSBundle mainBundle] pathForResource:@"wifilocation" ofType:@"sqlite"];
   NSFileManager * mng = [[NSFileManager alloc] init];
   // 把资源文件拷贝到/Document
   [mng removeItemAtPath:strPath error:nil];
   [mng copyItemAtPath:sqldocPath toPath:strPath error:nil];
   //***********************************************************************
   
   
   
   //打开数据库
   //如果数据库存在就打开,如果不存在就创建一个再打开
   int result = sqlite3_open([strPath UTF8String], &db);

   if (result == SQLITE_OK) {
      NSLog(@"数据库打开成功");
   } else {
      NSLog(@"数据库打开失败");
   }
}

#pragma mark - 增删改
//创建表格
- (void)createTableWithString:(NSString *)sqlite {
   //1.准备sqlite语句
//   NSString *sqlite = [NSString stringWithFormat:@"create table if not exists 'student' ('number' integer primary key autoincrement not null,'name' text,'sex' text,'age'integer)"];
   //2.执行sqlite语句
   char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
   int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
   //3.sqlite语句是否执行成功
   
   if (result == SQLITE_OK) {
      NSLog(@"创建表成功");
   } else {
      NSLog(@"创建表失败");
   }
}

//修改数据
- (void)updataWithString:(NSString *)sqlite {
   //1.sqlite语句
//   NSString *sqlite = [NSString stringWithFormat:@"update student set name = '%@',sex = '%@',age = '%ld' where number = '%ld'",stu.name,stu.sex,stu.age,stu.number];
   //2.执行sqlite语句
   char *error = NULL; // 执行sqlite语句失败的时候,会把失败的原因存储到里面
   int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
   if (result == SQLITE_OK) {
      NSLog(@"修改数据成功");
   } else {
      NSLog(@"修改数据失败");
   }
}

//添加数据
- (void)insertWithString:(NSString *)sqlite {
   //1.准备sqlite语句
//   NSString *sqlite = [NSString stringWithFormat:@"insert into student(number,name,age,sex) values ('%d','%@','%@','%d')", 201109, @"Mike Liang", @"男", 22];
   //2.执行sqlite语句
   char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
   int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
   if (result == SQLITE_OK) {
      NSLog(@"添加数据成功");
   } else {
      NSLog(@"添加数据失败");
   }
}

#pragma mark - 查询数据 (select * from [TABLE])

// 查询地图数据
- (NSMutableArray*)selectFromMapInfo {
   NSMutableArray *array = [[NSMutableArray alloc] init];
   //1.准备sqlite语句
   NSString * sqlite = [NSString stringWithFormat:@"select * from map_info"];
   //2.伴随指针
   sqlite3_stmt *stmt = NULL;
   //3.预执行sqlite语句
   int result = sqlite3_prepare(db, sqlite.UTF8String, -1, &stmt, NULL);//第4个参数是一次性返回所有的参数,就用-1
   if (result == SQLITE_OK) {
      NSLog(@"查询地图成功");
      //4.执行n次
      while (sqlite3_step(stmt) == SQLITE_ROW) {
         MapModel *mapInfo = [[MapModel alloc] init];
         mapInfo.map_id = sqlite3_column_int(stmt, 0);
         mapInfo.map_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)] ;
         mapInfo.map_width = sqlite3_column_int(stmt, 2);
         mapInfo.map_height = sqlite3_column_int(stmt, 3);
         mapInfo.map_info = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)] ;
         [array addObject:mapInfo];
      }
   } else {
      NSLog(@"查询地图失败");
   }
   //5.关闭伴随指针
   sqlite3_finalize(stmt);
   return array;
}

// 查询AP数据
- (NSMutableArray*)selectFromAPInfo:(int)mapid {
   NSMutableArray *array = [[NSMutableArray alloc] init];
   NSString *sqlite = [NSString stringWithFormat:@"select * from ap_info where map_id = %d", mapid];
   sqlite3_stmt *stmt = NULL;
   int result = sqlite3_prepare(db, sqlite.UTF8String, -1, &stmt, NULL);
   if (result == SQLITE_OK) {
      NSLog(@"查询AP成功");
      while (sqlite3_step(stmt) == SQLITE_ROW) {
         APModel *apInfo = [[APModel alloc] init];
         apInfo.ap_id = sqlite3_column_int(stmt, 0);
         apInfo.ap_isrefer = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)] ;
         apInfo.map_id = sqlite3_column_int(stmt, 2);
         apInfo.ap_x = sqlite3_column_int(stmt, 3);
         apInfo.ap_y = sqlite3_column_int(stmt, 4);
         apInfo.ap_sendpower = sqlite3_column_int(stmt, 5);
         apInfo.ap_sendgain = sqlite3_column_int(stmt, 6);
         apInfo.ap_receiverefer = sqlite3_column_int(stmt, 7);
         [array addObject:apInfo];
      }
   } else {
      NSLog(@"查询AP失败");
   }
   sqlite3_finalize(stmt);
   return array;
}

// 查询FP数据
- (NSMutableArray*)selectFromFPInfo:(int)mapid {
   NSMutableArray *array = [[NSMutableArray alloc] init];
   NSString *sqlite = [NSString stringWithFormat:@"select * from fp_info where map_id = %d", mapid];
   sqlite3_stmt *stmt = NULL;
   int result = sqlite3_prepare(db, sqlite.UTF8String, -1, &stmt, NULL);
   if (result == SQLITE_OK) {
      NSLog(@"查询FP成功");
      while (sqlite3_step(stmt) == SQLITE_ROW) {
         FPModel *fpInfo = [[FPModel alloc] init];
         fpInfo.fp_id = sqlite3_column_int(stmt, 0);
         fpInfo.map_id = sqlite3_column_int(stmt, 1);
         fpInfo.fp_x = sqlite3_column_int(stmt, 2);
         fpInfo.fp_y = sqlite3_column_int(stmt, 3);
         fpInfo.fp_receivegain = sqlite3_column_int(stmt, 4);
         [array addObject:fpInfo];
      }
   } else {
      NSLog(@"查询FP失败");
   }
   sqlite3_finalize(stmt);
   return array;
}


#pragma mark - 关闭数据库
- (void)closeSqlite {
   
   int result = sqlite3_close(db);
   if (result == SQLITE_OK) {
      NSLog(@"数据库关闭成功");
   } else {
      NSLog(@"数据库关闭失败");
   }
}

@end
