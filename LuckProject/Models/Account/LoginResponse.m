//
//  LoginResponse.m
//  LuckProject
//
//  Created by moxi on 2017/7/24.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"username":@"username",
             @"token":@"token",
             @"userId":@"userId",
             @"score":@"score",
             @"isBinding":@"isBinding",
             @"isSign":@"isSign",
             @"imgPath":@"imgPath",
             @"userIdCard":@"userIdCard",
             @"userRealName":@"userRealName",
             @"phoneNumber":@"phoneNumber"
             };
}

@end
