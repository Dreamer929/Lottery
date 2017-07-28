//
//  MXPopView.h
//  LuckProject
//
//  Created by moxi on 2017/7/10.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnMSStringPickerViewDoneBlock)(UIPickerView *picker, NSInteger selectedIndex, NSString *selectedValue);
typedef void(^OnMSStringPickerViewCancelBlock)(UIPickerView *picker);

typedef void (^OnCheckOutDoneBlock)();



@interface MXPopView : UIView<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) OnMSStringPickerViewDoneBlock onMSStringPickerDone;
@property (nonatomic, copy) OnMSStringPickerViewCancelBlock onMSStringPickerCancel;

@property (nonatomic, copy) OnCheckOutDoneBlock onCheckOutDone;

- (instancetype)initInView:(UIView *)hostView rows:(NSMutableArray *)items initialSelection:(NSInteger)index doneBlock:(void(^)(UIPickerView *picker, NSInteger selectedIndex, NSString *selectedValue))doneBlock cancelBlock:(void(^)(UIPickerView *picker))cancelBlock;

- (void)showPicker;

-(instancetype)initInView:(UIView*)hostView score:(NSString*)score doneBlock:(void(^)())doneBlock;

-(instancetype)initInView:(UIView *)hostView object:(id)respons checkOutNum:(NSString *)string doneBlock:(void(^)())doneBlock;
-(void)showView;


@end
