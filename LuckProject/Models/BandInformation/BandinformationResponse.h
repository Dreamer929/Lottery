//
//  BandinformationResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BandinformationResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *phoneNumber;
@property (nonatomic, copy)NSString *userIdCard;
@property (nonatomic, copy)NSString *userRealName;
@property (nonatomic, copy)NSString *isBanding;

@end
