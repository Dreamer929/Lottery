//
//  RootModel.h
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootModel : NSObject

@property (nonatomic, copy)NSString *tabbarTitle;

@property (nonatomic, copy)NSString *normaImageName;

@property (nonatomic, copy)NSString *selectImageName;

@property (nonatomic, copy)NSString *className;

/*
  初始化model的类方法（instancetype代表TabBarModel）
*/

+(instancetype)modelWithTitle:(NSString *)title normalImage:(NSString *)imageName selectedImage:(NSString *)selectedImage className:(NSString *)className;


/**
 获取正常状态下的图片
 */

-(UIImage *)normalImage;

/**
 获取选中状态下的图片
 */

- (UIImage *)selectedImage;

@end
