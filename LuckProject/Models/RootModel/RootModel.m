//
//  RootModel.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "RootModel.h"

@implementation RootModel


//初始化model的类方法（instancetype代表TabBarModel）
+(instancetype)modelWithTitle:(NSString *)title normalImage:(NSString *)imageName selectedImage:(NSString *)selectedImage className:(NSString *)className{
    //+里面的self代表类本身
    return [[self alloc] initWithTitle:title normalImage:imageName selectedImage:selectedImage className:className];
}
//初始化model的实例方法（id适用所有）
-(id)initWithTitle:(NSString *)title normalImage:(NSString *)imageName selectedImage:(NSString *)selectedImage className:(NSString*)className{
    
    if (self = [super init]) {
        //简单的指针赋值
        _tabbarTitle = title;
        _normaImageName = imageName;
        _selectImageName = selectedImage;
        _className = className;
    }
    return self;
}

-(UIImage *)normalImage{
    
    UIImage *image = [[UIImage imageNamed:self.normaImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (UIImage *)selectedImage{
    
    UIImage *image = [[UIImage imageNamed:self.selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


@end
