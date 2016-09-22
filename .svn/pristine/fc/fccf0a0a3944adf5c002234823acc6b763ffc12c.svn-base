//
//  SJAccount.m
//  传值
//
//  Created by mac on 15/9/1.
//  Copyright (c) 2015年 UQI. All rights reserved.
//

#import "SJAccount.h"


@implementation SJAccount
+(void)saveUser:(priceModel *)user
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path=[path stringByAppendingPathComponent:@"user.plist"];
    NSLog(@"%@",path);
    [NSKeyedArchiver archiveRootObject:user toFile:path];
}
+(priceModel *)user
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path=[path stringByAppendingPathComponent:@"user.plist"];
    priceModel *user=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return user;
}

+ (void)removUser {
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path=[path stringByAppendingPathComponent:@"user.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager removeItemAtPath:path error:&error];
}

@end
