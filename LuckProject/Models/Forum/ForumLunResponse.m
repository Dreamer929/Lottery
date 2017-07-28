//
//  ForumLunResponse.m
//  LuckProject
//
//  Created by moxi on 2017/7/19.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "ForumLunResponse.h"

@implementation ForumLunResponse


+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"discussTime":@"discussTime",
             @"content":@"totacontentlHit",
             @"username":@"username",
             @"commentCount":@"commentCount",
             @"userImg":@"userImg"
             };
}

@end
