//
//  ForumDetialResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/18.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ForumDetialResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, assign)NSInteger userId;
@property (nonatomic, copy)NSString *username;
@property (nonatomic, copy)NSString *imgPath;

@end
