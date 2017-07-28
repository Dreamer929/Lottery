//
//  ECScrollView.h
//  SmartHR2.0
//
//  Created by 微知软件 on 16/10/7.
//  Copyright © 2016年 Microseer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

//滚动时间间隔
#define ECScrollViewTime 4

@interface ECScrollView : UIView

@property (nonatomic,copy) void(^imageBlock)(NSInteger index);

//暴露借口，传入frame和装有网址的数组
-(instancetype)initWithFrame:(CGRect)frame imageURLs:(NSArray*)imageURLs;

@end
