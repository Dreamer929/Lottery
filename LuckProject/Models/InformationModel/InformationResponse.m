//
//  InformationResponse.m
//  LuckProject
//
//  Created by moxi on 2017/7/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "InformationResponse.h"

@implementation InformationResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"title":@"title",
             @"newsId":@"newsId",
             @"readCount":@"readCount",
             @"registertime":@"registertime",
             @"newsType":@"newsType",
             @"imageurl":@"imageurl",
             };
}

@end
