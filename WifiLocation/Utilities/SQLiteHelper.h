//
//  SQLiteHelper.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/08.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLiteHelper : NSObject

- (void)openSqliteWithFileName:(NSString *)sqliteName;
- (void)createTableWithString:(NSString *)sqlite;
- (void)updataWithString:(NSString *)sqlite;
- (void)insertWithString:(NSString *)sqlite;
- (void)deleteWithString:(NSString *)sqlite;
- (NSMutableArray*)selectFromMapInfo;
- (NSMutableArray*)selectFromAPInfo:(int)mapid;
- (NSMutableArray*)selectFromFPInfo:(int)mapid;
- (NSMutableArray*)selectFromSimuInfo:(int)mapid;
- (void)closeSqlite;

@end

// 全局静态变量
static sqlite3 *db = NULL; // 指向数据库的公共指针
static SQLiteHelper *sqliteHelper;
