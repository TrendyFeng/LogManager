//
//  FTPManager.h
//  一码
//
//  Created by C on 2017/1/9.
//  Copyright © 2017年 C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogManager : NSObject
/**
 开启全局异常处理
 */
+ (void)setUncaughtExceptionHandler;

/**
 上传崩溃日志
 */
+ (void)uploadCrashLog;

@end
