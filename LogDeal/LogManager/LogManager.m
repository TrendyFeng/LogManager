//
//  LogManager.m
//  一码
//
//  Created by C on 2017/1/9.
//  Copyright © 2017年 C. All rights reserved.
//

//NSString *const logHostPath = @"服务器地址";

#import "LogManager.h"
#include "execinfo.h"
#import <UIKit/UIKit.h>

@implementation LogManager
//异常捕获函数
void UncaughtExceptionHandler(NSException *exception) {
    /**
     *  获取异常崩溃信息
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *logReason = [exception reason];
    NSString *logName = [exception name];
    NSString *logContent = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",logName,logReason,[callStack componentsJoinedByString:@"\n"]];
    
#if DEBUG
    [LogManager sendCrashLogForMessage:logContent];
#else
    
#endif
    
    [LogManager saveCrashLogWithLogContent:logContent
                               withLogName:logName];
}

+ (void)setUncaughtExceptionHandler {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

//把异常崩溃信息发送至开发者邮件
+ (void)sendCrashLogForMessage:(NSString *)content {
    NSMutableString *mailUrl = [NSMutableString string];
//#warning 邮箱地址修改为对应的接收邮箱
    [mailUrl appendString:@"mailto:邮箱地址"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告给XXXX的邮箱，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
//    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
}

//把异常崩溃信息保存到本地
+ (void)saveCrashLogWithLogContent:(nonnull NSString *)logContent
                       withLogName:(nonnull NSString *)logName{
    NSParameterAssert(logContent);
    NSParameterAssert(logName);
    
    UIDevice *userDevice        = [UIDevice currentDevice];
    NSDictionary *infoDic       = [[NSBundle mainBundle] infoDictionary];
    
    NSString *deviceName        = [userDevice systemName];
    NSString *deviceVersion     = [userDevice systemVersion];
    NSString *appVersion        = infoDic[@"CFBundleShortVersionString"];
    NSString *appVersionUpdate  = infoDic[@"CFBundleVersion"];
    
    
//#warning 当前环境，在plist文件中先配置,如Debug、Release
  
#if DEBUG
      NSString *appScheme = infoDic[@"Debug"];
#else
      NSString *appScheme = infoDic[@"Release"];
#endif
//#warning 用户ID，无则不修改
    
    
    NSString *userId = @"userId";
    
    
    NSString *txtName = [NSString stringWithFormat:@"%@_%@_%@_%@_%@_%@_%@.txt",
                         deviceName,
                         deviceVersion,
                         appScheme,
                         appVersion,
                         appVersionUpdate,
                         userId,
                         logName];
    NSLog(@"崩溃日志的文件名为%@",txtName);

    NSString *txtPath = [[self class] crashLogDirectoryPath];
    [[self class] hasLive:txtPath];
    
    NSString *localpath =[NSString stringWithFormat:@"%@/%@",txtPath,txtName];
    NSLog(@"崩溃日志的路径:%@ ",localpath);
    
    NSData *txtData = [logContent dataUsingEncoding:NSUTF8StringEncoding];
    [txtData writeToFile:localpath atomically:YES];
}

//崩溃日志的文件夹路径
+ (NSString *)crashLogDirectoryPath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/crash",docPath];
}

//上传崩溃日志
+ (void)uploadCrashLog {
    
    NSString *logDirecPath = [[self class] crashLogDirectoryPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:logDirecPath];
    for (NSString *fileName in enumerator)
    {
        
        NSString *txtPath = [NSString stringWithFormat:@"%@/%@",logDirecPath,fileName];
        
//#warning 请使用各自上传文件的方法，在上传成功后需要将该文件移除
        
//
//        [HttpRequest uploadTextWithUrlString:logHostPath parameters:paraDic withTxtPath:txtPath withTxtName:txtPath success:^(id responseObject) {
//
//             NSLog(@"%@ \n日志上传成功",fileName);
//             [fileManager removeItemAtPath:txtPath error:nil];
//
//        } failure:^(NSError *error) {
//
//             NSLog(@"%@ \n日志上传失败",fileName);
//
//        }];
      
        
    }
}

//路径是否存在，不存在则创建
+ (BOOL)hasLive:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return NO;
}
@end
