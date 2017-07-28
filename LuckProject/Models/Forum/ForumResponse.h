//
//  ForumResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/18.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ForumResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, assign)NSInteger forumId;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, assign)NSInteger userId;
@property (nonatomic, copy)NSString *username;
@property (nonatomic, assign)NSInteger readCount;
@property (nonatomic, copy)NSString *imgPath;
@property (nonatomic, assign)NSInteger hitTotal;
@property (nonatomic, assign)NSInteger commentCount;
@property (nonatomic, assign)NSInteger isThumb;
@property (nonatomic, assign)NSInteger isCollection;

@end
