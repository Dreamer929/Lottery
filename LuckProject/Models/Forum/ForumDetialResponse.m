//
//  ForumDetialResponse.m
//  LuckProject
//
//  Created by moxi on 2017/7/18.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "ForumDetialResponse.h"

@implementation ForumDetialResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"content":@"content",
             @"createTime":@"createTime",
             @"userId":@"userId",
             @"username":@"username",
             @"imgPath":@"imgPath",
             };
}

@end
