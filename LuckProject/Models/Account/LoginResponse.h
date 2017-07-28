//
//  LoginResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/24.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface LoginResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *username;
@property (nonatomic, copy)NSString *token;
@property (nonatomic, assign)NSInteger userId;
@property (nonatomic, assign)NSInteger score;
@property (nonatomic, assign)NSInteger isBinding;
@property (nonatomic, assign)NSInteger isSign;
@property (nonatomic, copy)NSString *imgPath;
@property (nonatomic, copy)NSString *userRealName;
@property (nonatomic, copy)NSString *userIdCard;
@property (nonatomic, copy)NSString *phoneNumber;

@end
