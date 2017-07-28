//
//  UserRegosterResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/24.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserRegosterResponse : MTLModel<MTLJSONSerializing>


@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, assign) NSInteger score;


@end
