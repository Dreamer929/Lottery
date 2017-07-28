//
//  ForumResponse.m
//  LuckProject
//
//  Created by moxi on 2017/7/18.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "ForumResponse.h"

@implementation ForumResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"title":@"title",
             @"content":@"content",
             @"forumId":@"forumId",
             @"createTime":@"createTime",
             @"userId":@"userId",
             @"username":@"username",
             @"readCount":@"readCount",
             @"imgPath":@"imgPath",
             @"hitTotal":@"hitTotal",
             @"commentCount":@"commentCount",
             @"isThumb":@"isThumb",
             @"isCollection":@"isCollection"
             };
}

@end
