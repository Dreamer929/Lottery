//
//  DoubleBallViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/11.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "DoubleBallViewController.h"


@interface DoubleBallViewController ()

@property (nonatomic, strong)UIScrollView *scrollview;
@property (nonatomic, strong)UIButton *systemBtn;
@property (nonatomic, strong)UIButton *clearBtn;
@property (nonatomic, strong)UIButton *saveBtn;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UILabel *tipLable;

@property (nonatomic, strong)MXPopView *popView;

//红篮球被选中的数量
@property (nonatomic, assign)NSInteger redChangedC;
@property (nonatomic, assign)NSInteger blueChangedC;
@property (nonatomic, strong)NSMutableArray *ballCount;
@property (nonatomic, strong)NSMutableArray *redBallCount;



@property (nonatomic, strong)NSString *ballString;


@end

@implementation DoubleBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ballCount = [NSMutableArray array];
    self.redBallCount = [NSMutableArray array];
    
    [self.redBallCount removeAllObjects];
    [self.ballCount removeAllObjects];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UI

-(void)createUI{
    
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = ECCOLOR(225, 225, 225, 1);
    [self.view addSubview:self.bottomView];
    
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, DREAMCSCREEN_W, DREAMCSCREEN_H -64 - 40)];
    self.scrollview.backgroundColor = [UIColor clearColor];
    self.scrollview.contentSize = CGSizeMake(DREAMCSCREEN_W, DREAMCSCREEN_H);
    [self.view addSubview:self.scrollview];
    
    self.systemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.systemBtn setImage:ECIMAGENAME(@"jixuan_16x16_@2x") forState:UIControlStateNormal];
    self.systemBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.systemBtn setTitle:@"机选" forState:UIControlStateNormal];
    
    self.systemBtn.hidden = YES;
    
    [self.systemBtn setTitleColor:ECCOLOR(252, 141, 66, 1) forState:UIControlStateNormal] ;
    [self.systemBtn addTarget:self action:@selector(systemChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollview addSubview:self.systemBtn];
    
    self.tipLable = [[UILabel alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W - 150 - 10, 10, 150, 30)];
    self.tipLable.textAlignment = NSTextAlignmentRight;
    self.tipLable.font = [UIFont systemFontOfSize:12];
    [self.scrollview addSubview:self.tipLable];
    
    if (self.flag == 0) {
        self.navigationItem.title = @"双色球";
        self.tipLable.text = @"选6个红球和1个篮球";
    }else if (self.flag == 1){
        self.navigationItem.title = @"大乐透";
        self.tipLable.text = @"选5个红球和2个篮球";
    }else{
        
    }
    
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clearBtn.frame = CGRectMake(20, 4, 32,32 );
    [self.clearBtn setBackgroundImage:ECIMAGENAME(@"checkout") forState:UIControlStateNormal];
    [self.clearBtn addTarget:self action:@selector(clearBallClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.clearBtn];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(DREAMCSCREEN_W - 80, 5, 60, 30);
    self.saveBtn.layer.masksToBounds = YES;
    self.saveBtn.layer.cornerRadius = 10;
    self.saveBtn.backgroundColor = [UIColor yellowColor];
    [self.saveBtn setTitle:@"模拟投注" forState:UIControlStateNormal];
    self.saveBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveNumClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomView addSubview:self.saveBtn];
    
    switch (self.flag) {
        case 0:
        {
            [self createBallWithRedBallCount:33 blueBall:16];
        }
            break;
        case 1:
        {
            [self createBallWithRedBallCount:35 blueBall:12];
        }
            break;
            
        default:
            break;
    }
    
  
    
    [self setupConfig];
}

-(void)createBallWithRedBallCount:(NSInteger)redBall blueBall:(NSInteger)blueBall{
    
    
    
    CGFloat buttonW = (DREAMCSCREEN_W - 7*20)/6;
    CGFloat buttonH = buttonW;
    CGFloat paceH = 20;
    CGFloat paceV = 5;
    
    for (NSInteger index = 0; index < redBall; index++) {
        
        NSInteger H = index%6;
        NSInteger v = index/6;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(paceH + (buttonW + paceH)*H, v*(buttonH + paceV) + 50, buttonW, buttonH);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonW/2;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor redColor].CGColor;
        button.tag = index;
        button.selected = NO;
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(changeRedBallClick:) forControlEvents:UIControlEventTouchUpInside];
        if (index<=8) {
            [button setTitle:[@"0" stringByAppendingString: [NSString stringWithFormat:@"%ld",index + 1]] forState:UIControlStateNormal];
        }else{
            [button setTitle:[NSString stringWithFormat:@"%ld",index + 1] forState:UIControlStateNormal];
        }        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [self.scrollview addSubview:button];
    }
    
    for (NSInteger index = 0; index < blueBall; index++) {
        
        NSInteger H = index%6;
        NSInteger V = index/6;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(paceH + (buttonW + paceH)*H, V*(buttonH + paceV) + (buttonH + paceV)*6 + 60, buttonW, buttonH);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonW/2;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor blueColor].CGColor;
        button.tag = index;
        button.selected = NO;
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(changeBlueBallClick:) forControlEvents:UIControlEventTouchUpInside];

        if (index<=8) {
            [button setTitle:[@"0" stringByAppendingString: [NSString stringWithFormat:@"%ld",index + 1]] forState:UIControlStateNormal];
        }else{
           [button setTitle:[NSString stringWithFormat:@"%ld",index + 1] forState:UIControlStateNormal];
        }
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [self.scrollview addSubview:button];
        
    }
}

-(void)setupConfig{
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    [self.systemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollview.mas_top).offset(10);
        make.left.mas_equalTo(self.scrollview.mas_left);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
}


#pragma mark -click 

-(void)changeRedBallClick:(UIButton*)sender{
    
    if (sender.selected) {
        
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor whiteColor];
        sender.selected = NO;
        [self.redBallCount removeLastObject];
    }else{
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor redColor];
        self.redChangedC++;
        sender.selected = YES;
        [self.redBallCount addObject:sender.titleLabel.text];
    }
}

-(void)changeBlueBallClick:(UIButton*)sender{
    
    if (sender.selected) {
        
        self.blueChangedC--;
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor whiteColor];
        sender.selected = NO;
        [self.ballCount removeLastObject];
        
    }else{
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor blueColor];
        self.blueChangedC++;
        [self.ballCount addObject:sender.titleLabel.text];
        sender.selected = YES;
    }
}

-(void)systemChangeAction:(UIButton*)button{
    
}

-(void)clearBallClick:(UIButton*)button{
    
    
    NSInteger ballBCount = 0;
    NSInteger ballRCount = 0;
    NSString *lottID = [NSString string];
    NSString *codes = [NSString string];
    NSString *string =[NSString string];
    string = [self.redBallCount componentsJoinedByString:@"%2C"];
    NSString *transFormCell = [NSString string];
    
    switch (self.flag) {
        case 0:
        {
            
            ballRCount = 6;
            ballBCount = 1;
            lottID = @"51";
            
            if (self.ballCount.count == ballBCount && self.redBallCount.count == ballRCount) {
                
                [self showBaseHud];
                codes = [[string stringByAppendingString:@"%7C"] stringByAppendingString:self.ballCount[0]];
                transFormCell = [[self.redBallCount componentsJoinedByString:@" "] stringByAppendingString:[@"    "stringByAppendingString:self.ballCount[0]]];
                NSString *URL = [NSString stringWithFormat:CHECK_ISLUCK,codes,lottID];
                
                NSMutableArray *arr = [NSMutableArray array];
                
                [MXHttpRequestManger GET:URL parameters:@{} success:^(id responseObject) {
                    
                    
                    NSMutableArray *data = responseObject[@"awardList"];
                    
                    for (NSDictionary *dic in data) {
                        HistoryLotteryModel *model = [[HistoryLotteryModel alloc]init];
                        model.LottyCount = dic[@"count"];
                        model.name = dic[@"name"];
                        [arr addObject:model];
                    }
                    
                    
                    
                    self.popView = [[MXPopView alloc]initInView:self.view object:arr checkOutNum:transFormCell doneBlock:^(UITableView *tableview) {
                        
                        
                    }];
                    
                    [self.popView showView];
                    
                    [self dismissHudWithSuccessTitle:@"Success" After:1.f];
                    
                } failure:^(NSError *error) {
                    
                    [self dismissHudWithErrorTitle:@"Faile" After:1.f];
                }];
                
            }else{
                
                [self showWarningHudWithWarningTitle:@"请输入正确的单式号码"];
                [self performSelector:@selector(dismissHud) withObject:nil afterDelay:1.f];
            }

            
        }
            break;
        case 1:
        {
            ballRCount = 5;
            ballBCount = 2;
            lottID = @"23529";
            string = [self.redBallCount componentsJoinedByString:@"%2C"];
            NSString *blueBall = [self.ballCount componentsJoinedByString:@"%2C"];
            
            if (self.ballCount.count == ballBCount && self.redBallCount.count == ballRCount) {
                
                [self showBaseHud];
                codes = [[string stringByAppendingString:@"%7C"] stringByAppendingString:blueBall];

                transFormCell = [[self.redBallCount componentsJoinedByString:@" "] stringByAppendingString:[@"    "stringByAppendingString:[self.ballCount[0]stringByAppendingString:[@" " stringByAppendingString:self.ballCount[1]]]]];
                
                NSString *URL = [NSString stringWithFormat:CHECK_ISLUCK,codes,lottID];
                
                NSMutableArray *arr = [NSMutableArray array];
                
                [MXHttpRequestManger GET:URL parameters:@{} success:^(id responseObject) {
                    
                    
                    NSMutableArray *data = responseObject[@"awardList"];
                    
                    for (NSDictionary *dic in data) {
                        HistoryLotteryModel *model = [[HistoryLotteryModel alloc]init];
                        model.LottyCount = dic[@"count"];
                        model.name = dic[@"name"];
                        [arr addObject:model];
                    }
                    
                    
                    self.popView = [[MXPopView alloc]initInView:self.view object:arr checkOutNum:transFormCell doneBlock:^(UITableView *tableview) {
                        
                        
                    }];
                    
                    [self.popView showView];
                    
                    [self dismissHudWithSuccessTitle:@"Success" After:1.f];
                    
                } failure:^(NSError *error) {
                    
                    [self dismissHudWithErrorTitle:@"Faile" After:1.f];
                }];
                
            }else{
                
                [self showWarningHudWithWarningTitle:@"请输入正确的单式号码"];
                [self performSelector:@selector(dismissHud) withObject:nil afterDelay:1.f];
            }

            
        }
            break;
            
        default:
            break;
    }
    
}

-(void)saveNumClick:(UIButton*)button{
    
    if ([MXAppConfig shareInstance].isLogin) {
        CGFloat redCount;
        CGFloat blueCount;
        
        if (self.flag) {
            redCount = 5;
            blueCount = 2;
        }else{
            redCount = 6;
            blueCount = 1;
        }
        
        if (self.redBallCount.count>=redCount&&self.ballCount.count>=blueCount) {
            
            [self initAletrControllerTille:@"是否投注" message:@"投注后可到我的号码中查看" alertStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *go = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                
                self.ballString =[[[self.redBallCount componentsJoinedByString:@" "] stringByAppendingString:@" " ] stringByAppendingString:[self.ballCount componentsJoinedByString:@" "]];
                
                BuyLottyParameter *parameter = [[BuyLottyParameter alloc]init];
                parameter.userId = [NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId];
                parameter.qihao = @"2017080";
                parameter.lotteryNo = [[self.redBallCount componentsJoinedByString:@" "]stringByAppendingString:[@"," stringByAppendingString:[self.ballCount componentsJoinedByString:@" "]]];
                parameter.lotteryBets = @"1";
                if (self.flag) {
                    parameter.lotteryType = @"dlt";

                    parameter.qihao = @"2017087";

                }else{
                    parameter.lotteryType = @"ssq";
                    parameter.qihao = @"2017087";

                }
                [self showBaseHud];
                [UserAccountApi accountBuyLotty:parameter block:^(NSString *errorcode, NSString *error) {
                    
                    if ([errorcode isEqualToString:@"0"]) {
                        [self dismissHudWithSuccessTitle:@"投注成功等待开奖" After:1.f];
                    }else{
                        [self dismissHudWithErrorTitle:error After:1.f];
                    }
                }];
                
            }];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [self.alert addAction:go];
            [self.alert addAction:cancle];
            
            [self presentViewController:self.alert animated:YES completion:nil];
            
        }else{
            
            [self showWarningHudWithWarningTitle:@"选择正确的号码"];
            [self dismissHudAfter:1.f];
            
        }

    }else{
       
        LoginViewController *vc = [[LoginViewController alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        nvc.navigationBar.barTintColor = [UIColor redColor];
        [nvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self presentViewController:nvc animated:YES completion:nil];
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
