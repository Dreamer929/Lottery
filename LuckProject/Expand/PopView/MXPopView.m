//
//  MXPopView.m
//  LuckProject
//
//  Created by moxi on 2017/7/10.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MXPopView.h"

@interface MXPopView ()

@property (nonatomic, strong) UIView *hostView;

@property (nonatomic, strong) UIView *shadeView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) NSInteger initialSelectionIndex;

@property (nonatomic, strong) NSString *selectedValue;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong)NSMutableArray *resultData;
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)UIButton *closeButton;
@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)UIImageView *baseView;

@property (nonatomic, copy)NSString *checkNumStr;

@property (nonatomic, strong)UIView *view;
@property (nonatomic, copy)NSString *score;


@end

@implementation MXPopView

-(instancetype)initInView:(UIView *)hostView score:(NSString*)score doneBlock:(void (^)())doneBlock{
    
    self = [super initWithFrame:hostView.bounds];
    if (self) {
        self.hostView = hostView;
        self.onCheckOutDone = doneBlock;
        self.score = score;
        
        [self setUpQiandaoView];
    }
    return self;
}

-(void)setUpQiandaoView{
    
    if(!self.shadeView){
        self.shadeView = [[UIView alloc] initWithFrame:self.bounds];
        self.shadeView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self addSubview:self.shadeView];
    }
    if (!self.baseView) {
        self.baseView = [[UIImageView alloc]initWithFrame:CGRectMake(80, -250, self.shadeView.frame.size.width - 160, 222)];
        self.baseView.userInteractionEnabled = YES;
        self.baseView.image = ECIMAGENAME(@"lucky_main_backBigBg_360x640_@2x");
        [self.shadeView addSubview:self.baseView];
        
        [UIView animateWithDuration:0.5 animations:^{
           self.baseView.frame = CGRectMake(80, 180, self.shadeView.frame.size.width - 160,222);
        }];
    }
    
    if (!self.view) {
        
        self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width,self.baseView.frame.size.height - 40 )];
        self.view.backgroundColor = [UIColor whiteColor];
        [self.baseView addSubview:self.view];
        
        UILabel *lable = [[UILabel alloc]init];
        lable.text = [NSString currtenDate];
        lable.textColor = [UIColor redColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
        [self.view addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(20);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.height.mas_equalTo(30);
        }];
        
        UILabel *tip = [[UILabel alloc]init];
        tip.text = [@"签到成功当前积分为:" stringByAppendingString:self.score];
        tip.textAlignment = NSTextAlignmentCenter;
        tip.textColor = [UIColor grayColor];
        tip.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:tip];
        
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lable.mas_bottom).offset(30);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.height.mas_equalTo(30);
        }];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"smile")];
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tip.mas_bottom);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(32);
            make.height.mas_equalTo(32);
        }];
        
        
    }
    
    if (!self.closeButton) {
        self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.baseView.frame.size.height - 40, self.view.frame.size.width, 40)];
        [self.closeButton setTitle:@"知道了" forState:UIControlStateNormal];
        self.closeButton.backgroundColor = [UIColor redColor];
        self.closeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.closeButton addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.baseView addSubview:self.closeButton];
    }

    
    
}

-(instancetype)initInView:(UIView *)hostView object:(id)respons checkOutNum:(NSString *)string doneBlock:(void (^)())doneBlock{
    
    self = [super initWithFrame:hostView.bounds];
    if (self) {
        self.hostView = hostView;
        self.resultData = respons;
        self.onCheckOutDone = doneBlock;
        self.checkNumStr = string;
        self.titleArr = @[@"查询号码",@"一等奖",@"二等奖",@"三等奖",@"四等奖",@"五等奖",@"六等奖"];
        [self setUpView];
    }
    
    return self;
}

-(void)setUpView{
    
    if(!self.shadeView){
        self.shadeView = [[UIView alloc] initWithFrame:self.bounds];
        self.shadeView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
        [self addSubview:self.shadeView];
    }
    
    if (!self.baseView) {
        self.baseView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 150, self.shadeView.frame.size.width - 80, self.shadeView.frame.size.height - 250)];
        self.baseView.userInteractionEnabled = YES;
        self.baseView.image = ECIMAGENAME(@"lucky_main_backBigBg_360x640_@2x");
        [self.shadeView addSubview:self.baseView];
    }
    
    if (!self.tableview) {
        
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.baseView.frame.size.width,self.baseView.frame.size.height - 40 ) style:UITableViewStyleGrouped];
        self.tableview.delegate = self;
        self.tableview.backgroundColor = [UIColor whiteColor];
        self.tableview.dataSource = self;
        [self.baseView addSubview:self.tableview];
    }
    
    if (!self.closeButton) {
        self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.baseView.frame.size.height - 40, self.tableview.frame.size.width, 40)];
        [self.closeButton setTitle:@"close" forState:UIControlStateNormal];
        self.closeButton.backgroundColor = [UIColor redColor];
        self.closeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.closeButton addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.baseView addSubview:self.closeButton];
    }
    
}


- (instancetype)initInView:(UIView *)hostView rows:(NSMutableArray *)items initialSelection:(NSInteger)index doneBlock:(void(^)(UIPickerView *picker, NSInteger selectedIndex, NSString *selectedValue))doneBlock cancelBlock:(void(^)(UIPickerView *picker))cancelBlock{
    self = [super initWithFrame:hostView.bounds];
    if(self){
        self.hostView = hostView;
        self.data = items;
        self.initialSelectionIndex = index;
        self.onMSStringPickerDone = doneBlock;
        self.onMSStringPickerCancel = cancelBlock;
        [self setupStringPicker];
    }
    return self;
}

- (void)setupStringPicker{
    
    if(!self.shadeView){
        self.shadeView = [[UIView alloc] initWithFrame:self.bounds];
        self.shadeView.backgroundColor = [UIColor blackColor];
        self.shadeView.alpha = 0.3;
        [self.shadeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        [self addSubview:self.shadeView];
    }
    
    if(!self.pickerView){
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.backgroundColor = [UIColor whiteColor];
    }
    [self.pickerView selectRow:self.initialSelectionIndex inComponent:0 animated:NO];
    
    CGFloat buttonHeight = 40;
    CGFloat contentViewHeight = self.pickerView.frame.size.height + buttonHeight;
    
    if(!self.contentView){
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, DREAMCSCREEN_W, contentViewHeight)];
        self.contentView.backgroundColor = [UIColor redColor];
        [self addSubview:self.contentView];
    }
    
    CGRect pickerFrame = self.pickerView.frame;
    pickerFrame.origin.y = buttonHeight;
    pickerFrame.size.width = DREAMCSCREEN_W;
    self.pickerView.frame = pickerFrame;
    
    [self.contentView addSubview:self.pickerView];
    
    if(!self.cancleButton){
        self.cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, pickerFrame.size.width / 2, buttonHeight)];
        [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        self.cancleButton.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        self.cancleButton.userInteractionEnabled = YES;
        self.cancleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.cancleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self.cancleButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.cancleButton];
    }
    
    if(!self.doneButton){
        self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(pickerFrame.size.width / 2, 0, pickerFrame.size.width / 2, buttonHeight)];
        [self.doneButton setTitle:@"确定" forState:UIControlStateNormal];
        self.doneButton.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        self.doneButton.userInteractionEnabled = YES;
        self.doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.doneButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [self.doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.doneButton];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.shadeView.alpha = 0.3;
        self.contentView.frame = CGRectMake(0, self.frame.size.height - contentViewHeight , DREAMCSCREEN_W, contentViewHeight);
    }];
}

- (void)slideAnimation{
    self.shadeView.alpha = 0;
    self.contentView.frame = CGRectMake(0, self.frame.size.height , DREAMCSCREEN_W, self.pickerView.frame.size.height);
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

-(void)showView{
    
    if (self.hostView) {
        [self.hostView addSubview:self];
    }
}


#pragma mark - event
- (void)doneButtonPressed:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        [self slideAnimation];
    } completion:^(BOOL finished) {
        if(self.onMSStringPickerDone){
            
            self.selectedValue = [self.data objectAtIndex:self.selectedIndex];
            self.onMSStringPickerDone(self.pickerView,self.selectedIndex,self.selectedValue);
        }
        [self removeFromSuperview];
    }];
}

- (void)cancelButtonPressed:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        [self slideAnimation];
    } completion:^(BOOL finished) {
        if(self.onMSStringPickerCancel){
            self.onMSStringPickerCancel(self.pickerView);
        }
        [self removeFromSuperview];
    }];
}

-(void)closeClick:(id)sender{
    
    [UIView animateWithDuration:1.5 animations:^{
        
        self.shadeView.alpha = 0;
    } completion:^(BOOL finished) {
        
        if (self.onCheckOutDone) {
            self.onCheckOutDone(self.tableview);
        }
        [self removeFromSuperview];
    }];
}


#pragma mark - UIPickerViewDelegate & DataSource
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedIndex = row;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.data.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    id obj = self.data[(NSUInteger)row];

    
    if([obj isKindOfClass:[NSString class]]){
        return obj;
    }
    
    if([obj respondsToSelector:@selector(description)]){
        return [obj performSelector:@selector(description)];
    }
    
    return nil;
}

#pragma mark -UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lable = [[UILabel alloc]init];
    lable.text = @"选定号码查询";
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    return lable;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
     cell.textLabel.text = self.titleArr[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = self.checkNumStr;
    }else{
        
        HistoryLotteryModel *model = self.resultData[indexPath.row - 1];
        
        cell.detailTextLabel.text = [[NSString stringWithFormat:@"%@",model.LottyCount] stringByAppendingString:@"注"];
    }

    return cell;
}

@end
