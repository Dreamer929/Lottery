//
//  InformationResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface InformationResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)NSInteger newsId;
@property (nonatomic, assign)NSInteger readCount;
@property (nonatomic, copy)NSString *registertime;
@property (nonatomic, copy)NSString *newsType;
@property (nonatomic, copy)NSString *imageurl;

@end
