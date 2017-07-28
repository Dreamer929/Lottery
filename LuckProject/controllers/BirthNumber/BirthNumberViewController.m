//
//  BirthNumberViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "BirthNumberViewController.h"
#import "MSNumberScrollAnimatedView.h"

@interface BirthNumberViewController ()

@property(nonatomic, strong)MXPopView *popView;
@property(nonatomic, strong)MXDatePickView *dateView;

@property (nonatomic, strong)MSNumberScrollAnimatedView *numberView;
@property (nonatomic, assign)NSInteger arnromRedNum;
@property (nonatomic, assign)NSInteger weiRedCount;

@property (nonatomic, strong)UIButton *getBirthButton;

@property (nonatomic, strong)UITableView *numberTableView;

@property (nonatomic, strong)NSMutableArray *readArr;
@property (nonatomic, strong)NSMutableArray *blueArr;

@property (nonatomic, strong)NSMutableArray *totalDatas;

@property (nonatomic, assign)NSInteger selectStyle;
@property (nonatomic, assign)NSInteger cellCount;


@end

@implementation BirthNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"生日选号";
    self.readArr = [NSMutableArray array];
    self.blueArr = [NSMutableArray array];
    self.totalDatas = [NSMutableArray array];
    
    self.weiRedCount = 7;
    self.arnromRedNum = 10000000;
    self.selectStyle = 0;
    self.cellCount = 0;
    
    [self createUI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UI

-(void)createUI{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 30);
    [button setTitle:@"双色球" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeStyleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.numberView = [[MSNumberScrollAnimatedView alloc]initWithFrame:CGRectMake(0, 65, DREAMCSCREEN_W, 60)];
    self.numberView.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
    self.numberView.textColor = [UIColor redColor];
    self.numberView.minLength = self.weiRedCount;
    
    CALayer * layer=[self.numberView layer];
    [layer setMasksToBounds:YES];     //是否设置边框以及是否可见
    [layer setBorderWidth:3];       //设置边框线的宽
    [layer setBorderColor:[[UIColor redColor] CGColor]];
    
    [self.view addSubview:self.numberView];
    
    
    [self initTableViewWithFrame:CGRectMake(0, 125,DREAMCSCREEN_W , DREAMCSCREEN_H - 125 - 40) WithHeadRefresh:NO WithFootRefresh:NO WithScrollIndicator:NO];
    
    self.getBirthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getBirthButton.backgroundColor = [UIColor redColor];
    self.getBirthButton.frame = CGRectMake(30, DREAMCSCREEN_H - 40, DREAMCSCREEN_W - 60, 35);
    [self.getBirthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getBirthButton setTitle:@"选取生日" forState:UIControlStateNormal];
    [self.getBirthButton addTarget:self action:@selector(getBithClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getBirthButton];
}



#pragma mark -click

-(void)changeStyleClick:(UIButton*)button{
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"双色球",@"大乐透",@"福彩3D",@"排列三",@"排列五",@"七星彩",@"七乐彩",@"六合彩",@"时时彩", nil];
    
    self.popView = [[MXPopView alloc]initInView:[UIApplication sharedApplication].keyWindow rows:arr initialSelection:0 doneBlock:^(UIPickerView *picker, NSInteger selectedIndex, NSString *selectedValue) {
        
        if(selectedIndex == 2 || selectedIndex==3){
            self.arnromRedNum = 1000;
            self.weiRedCount = 3;
        }else if (selectedIndex == 7){
            self.arnromRedNum = 1000000;
            self.weiRedCount = 6;
        }else if(selectedIndex == 4||selectedIndex == 8){
            self.arnromRedNum = 100000;
            self.weiRedCount = 5;
        }else{
            self.arnromRedNum = 10000000;
            self.weiRedCount = 7;
        }
        self.selectStyle = selectedIndex;
        self.numberView.minLength = self.weiRedCount;
        [button setTitle:selectedValue forState:UIControlStateNormal];
    } cancelBlock:^(UIPickerView *picker) {
        
    }];
    
    [self.popView showPicker];
}

-(void)getBithClick:(UIButton*)button{
    
    self.dateView = [[MXDatePickView alloc]initInView:self.view datePickerMode:UIDatePickerModeDate minimumDate:nil maximumDate:nil date:[NSDate date] doneBlock:^(UIDatePicker *datePicker) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        [self.getBirthButton setTitle:[formatter stringFromDate:datePicker.date] forState:UIControlStateNormal];
        
        [self getBallByRandnum:self.selectStyle];
        self.cellCount = 1;
        [self.tableView reloadData];
    
        
        self.numberView.number = @(arc4random()%self.arnromRedNum);
        [self.numberView startAnimation];

    } cancelBlock:^(UIDatePicker *datePicker) {
        
    }];
    
    [self.dateView showPicker];
}


#pragma mark -tableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.totalDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    cell.textLabel.text = [[[self.readArr componentsJoinedByString:@"  "] stringByAppendingString:@","]stringByAppendingString:[self.blueArr componentsJoinedByString:@"  "]];
    cell.textLabel.text = self.totalDatas[indexPath.row];
    return cell;
}



#pragma mark -randRom

-(void)getBallByRandnum:(NSInteger)styleindex{

    [self.totalDatas removeAllObjects];
    
    for (NSInteger index = 0; index < 5; index++) {
        
        [self.readArr removeAllObjects];
        [self.blueArr removeAllObjects];
        switch (styleindex) {
            case 0:
            {
                [self.readArr addObjectsFromArray:[self getRandnum:6 num:34]];
                
                NSInteger blueNum = arc4random()%17;
                if (blueNum == 0) {
                    blueNum = 1;
                }
                
                [self.blueArr addObject:[NSNumber numberWithInteger:blueNum]];
                
            }
                break;
            case 1:
            {
                [self.readArr addObjectsFromArray:[self getRandnum:5 num:36]];
                
                [self.blueArr addObjectsFromArray:[self getRandnum:2 num:13]];
            }
                break;
            case 2:
            {
                [self.readArr addObjectsFromArray:[self getRandnum:3 num:10]];
                
            }
                break;
            case 3:
            {
                [self.readArr addObjectsFromArray:[self getRandnum:3 num:10]];

            }
                break;
            case 4:
            {
                [self.readArr addObjectsFromArray:[self getRandnum:5 num:10]];

            }
                break;
            case 5:
            {
                [self.readArr addObjectsFromArray:[self getRandnum:7 num:10]];

            }
                break;
            case 6:
            {
                [self.readArr addObjectsFromArray:[self getRandnum:7 num:31]];

            }
                break;
            case 7:
            {
                [self.readArr addObjectsFromArray:[self getRandnum:6 num:50]];

            }
                break;
            case 8:
            {
                [self.readArr addObjectsFromArray:[self getRandnum:5 num:10]];

            }
                break;
                
            default:
                break;
        }
        
        if (self.blueArr.count == 0) {
            [self.totalDatas addObject:[[[self.readArr componentsJoinedByString:@"  "] stringByAppendingString:@""]stringByAppendingString:[self.blueArr componentsJoinedByString:@"  "]]];
        }else{
          [self.totalDatas addObject:[[[self.readArr componentsJoinedByString:@"  "] stringByAppendingString:@" , "]stringByAppendingString:[self.blueArr componentsJoinedByString:@"  "]]];
        }
        
    }
    
}

-(NSMutableArray *)getRandnum:(NSInteger)arrCount num:(NSInteger)randNum{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if(arr &&arr.count>0){
        [arr removeAllObjects];
    }
    
    NSInteger random;
    for (;;) {
        
        random=arc4random()%randNum;
        
        if (random == 0) {
            random = 1;
        }
        
        if(arr.count==0){
            [arr addObject:[NSNumber numberWithInteger:random]];
            
            continue;//进行下一次循环
            
        }
        
        BOOL isHave=[arr containsObject:[NSNumber numberWithInteger:random]];//判断数组中有没有
        if(isHave){
            
            continue;
        }
        [arr addObject:[NSNumber numberWithInteger:random]];
        if(arr.count==arrCount){
            return arr;
        }
        
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
