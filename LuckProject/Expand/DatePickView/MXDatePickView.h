//
//  MXDatePickView.h
//  LuckProject
//
//  Created by moxi on 2017/7/10.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MSDatePickerViewConfirmBlock)(UIDatePicker *picker);
typedef void(^MSDatePickerViewCancelBlock)(UIDatePicker *picker);

@interface MXDatePickView : UIView

@property (nonatomic, copy) MSDatePickerViewConfirmBlock onDatePickerDone;
@property (nonatomic, copy) MSDatePickerViewCancelBlock onDatePickerCancel;

/**
 show date picker
 
 @param mode default is UIDatePickerModeDateAndTime
 */
- (instancetype)initInView:(UIView *)superView datePickerMode:(UIDatePickerMode)mode minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate date:(NSDate *)date doneBlock:(void(^)(UIDatePicker *datePicker))doneBlock cancelBlock:(void(^)(UIDatePicker *datePicker))cancelBlock;

- (void)showPicker;

@end
