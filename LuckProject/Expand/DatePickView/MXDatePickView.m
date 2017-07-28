//
//  MXDatePickView.m
//  LuckProject
//
//  Created by moxi on 2017/7/10.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MXDatePickView.h"

@interface MXDatePickView ()

@property (nonatomic, strong) UIView *hostView;

@property (nonatomic, strong) UIView *shadeView;
@property (nonatomic, strong) UIView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancleButton;

@end


@implementation MXDatePickView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initInView:(UIView *)superView datePickerMode:(UIDatePickerMode)mode minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate date:(NSDate *)date doneBlock:(void(^)(UIDatePicker *datePicker))doneBlock cancelBlock:(void(^)(UIDatePicker *datePicker))cancelBlock{
    self = [super initWithFrame:superView.bounds];
    if(self){
        self.hostView = superView;
        self.onDatePickerDone = doneBlock;
        self.onDatePickerCancel = cancelBlock;
        [self setupPickerInView:superView datePickerMode:mode minimumDate:minimumDate maximumDate:maximumDate date:date doneBlock:doneBlock cancelBlock:cancelBlock];
    }
    return self;
}

#pragma mark method
- (void)setupPickerInView: (UIView *)superView datePickerMode:(UIDatePickerMode)mode minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate date:(NSDate *)date doneBlock:(void(^)(UIDatePicker *datePicker))doneBlock cancelBlock:(void(^)(UIDatePicker *datePicker))cancelBlock{
    if(!self.shadeView){
        self.shadeView = [[UIView alloc] initWithFrame:self.bounds];
        self.shadeView.backgroundColor = [UIColor blackColor];
        self.shadeView.alpha = 0.3;
        [self.shadeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        [self addSubview:self.shadeView];
    }
    
    if(!self.datePicker){
        self.datePicker = [[UIDatePicker alloc] init];
        self.datePicker.datePickerMode = mode;
        self.datePicker.minimumDate = minimumDate;
        self.datePicker.maximumDate = maximumDate;
        self.datePicker.date = date;
        self.datePicker.backgroundColor = [UIColor whiteColor];
    }
    
    CGFloat buttonHeight = 40;
    CGFloat pickerViewHeight = self.datePicker.frame.size.height + buttonHeight;
    
    if(!self.pickerView){
        self.pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, DREAMCSCREEN_W, pickerViewHeight)];
        self.pickerView.backgroundColor = [UIColor redColor];
        [self addSubview:self.pickerView];
    }
    
    CGRect pickerRect = self.datePicker.frame;
    pickerRect.origin.y = buttonHeight;
    pickerRect.size.width = DREAMCSCREEN_W;
    self.datePicker.frame = pickerRect;
    
    [self.pickerView addSubview:self.datePicker];
    
    if(!self.cancleButton){
        self.cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, pickerRect.size.width / 2, buttonHeight)];
        [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        self.cancleButton.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        self.cancleButton.userInteractionEnabled = YES;
        self.cancleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.cancleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self.cancleButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.pickerView addSubview:self.cancleButton];
    }
    
    if(!self.confirmButton){
        self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(pickerRect.size.width / 2, 0, pickerRect.size.width / 2, buttonHeight)];
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        self.confirmButton.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        self.confirmButton.userInteractionEnabled = YES;
        self.confirmButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.confirmButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [self.confirmButton addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.pickerView addSubview:self.confirmButton];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.shadeView.alpha = 0.3;
        self.pickerView.frame = CGRectMake(0, self.frame.size.height - pickerViewHeight , DREAMCSCREEN_W, pickerViewHeight);
    }];
}

- (void)slideAnimation{
    self.shadeView.alpha = 0;
    self.pickerView.frame = CGRectMake(0, self.frame.size.height , DREAMCSCREEN_W, self.pickerView.frame.size.height);
}

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer{
    [UIView animateWithDuration:0.3 animations:^{
        [self slideAnimation];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showPicker{
    if(self.hostView){
        [self.hostView addSubview:self];
    }
}

#pragma mark - event
- (void)cancelButtonPressed:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        [self slideAnimation];
    } completion:^(BOOL finished) {
        if(self.onDatePickerCancel){
            self.onDatePickerCancel(self.datePicker);
        }
        [self removeFromSuperview];
    }];
}

- (void)confirmButtonPressed:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        [self slideAnimation];
    } completion:^(BOOL finished) {
        if(self.onDatePickerDone){
            self.onDatePickerDone(self.datePicker);
        }
        [self removeFromSuperview];
    }];
}



@end
