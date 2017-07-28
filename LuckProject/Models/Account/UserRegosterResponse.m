//
//  UserRegosterResponse.m
//  LuckProject
//
//  Created by moxi on 2017/7/24.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "UserRegosterResponse.h"

@implementation UserRegosterResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"token":@"token",
             @"userId":@"userId",
             @"username":@"username",
             @"score":@"score"
             };
}

@end
