//
//  ForumLunResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/19.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ForumLunResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *discussTime;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *username;
@property (nonatomic, assign)NSInteger commentCount;
@property (nonatomic, assign)NSInteger userImg;

@end
