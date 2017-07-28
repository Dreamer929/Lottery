//
//  MXHttpRequestUrl.h
//  LuckProject
//
//  Created by moxi on 2017/6/30.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXHttpRequestUrl : NSObject

+ (NSString *)connectUrl:(NSDictionary *)params url:(NSString *)baseUrl;

@end
