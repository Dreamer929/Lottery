//
//  MessageResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/17.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MessageResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *phonenumber;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *createtime;

@end
