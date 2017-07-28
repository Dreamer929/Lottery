//
//  BandinformationResponse.m
//  LuckProject
//
//  Created by moxi on 2017/7/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "BandinformationResponse.h"

@implementation BandinformationResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"phoneNumber":@"phoneNumber",
             @"userIdCard":@"userIdCard",
             @"userRealName":@"userRealName",
             @"isBanding":@"isBanding",
             };
}
@end
