//
//  MessageResponse.m
//  LuckProject
//
//  Created by moxi on 2017/7/17.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MessageResponse.h"

@implementation MessageResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"phonenumber":@"phonenumber",
             @"code":@"code",
             @"createtime":@"createtime"
             };
}

@end
