//
//  ForumZanResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/19.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ForumZanResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign)NSInteger isHit;
@property (nonatomic, assign)NSInteger totalHit;

@end
