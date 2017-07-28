//
//  GradeDetialResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/24.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface GradeDetialResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *typeName;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, assign)NSInteger scoreDetail;
@property (nonatomic, assign)NSInteger mark;

@end
