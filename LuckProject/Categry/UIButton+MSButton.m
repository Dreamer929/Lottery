//
//  UIButton+MSButton.m
//  MSWireless
//
//  Created by 微知 on 2017/1/3.
//  Copyright © 2017年 Microseer. All rights reserved.
//

#import "UIButton+MSButton.h"

@implementation UIButton (MSButton)

- (void)setTimeStyle{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = ECCOLOR(255, 153, 0, 1).CGColor;
    self.layer.borderWidth = 1;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:ECCOLOR(255, 153, 0, 1) forState:UIControlStateNormal];
}

- (void)startTime{
    
    
    //改变button 样式
    self.backgroundColor = ECCOLOR(255, 204, 127, 1);
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.userInteractionEnabled = NO;
    //倒计时时间
    __block NSInteger timeOut = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        //倒计时关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:@"重获验证码" forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else{
            NSInteger allTime = (NSInteger)60 + 1;
            NSInteger seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,@"s"] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}

@end
