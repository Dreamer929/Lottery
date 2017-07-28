//
//  ThreeAndFireViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/12.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "ThreeAndFireViewController.h"
#import "LoginViewController.h"

@interface ThreeAndFireViewController ()

@property (nonatomic, strong)UIButton *systemBtn;
@property (nonatomic, strong)UIButton *saveBtn;
@property (nonatomic, strong)UILabel *tipLable;
@property (nonatomic, strong)NSMutableArray *redBallCount;

@property (nonatomic, strong)UIView *bottomView;


@end

@implementation ThreeAndFireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.flag == 2) {
        self.navigationItem.title = @"福彩3D";
    }else if (self.flag == 3){
        self.navigationItem.title = @"排列三";
    }else if (self.flag == 4){
       self.navigationItem.title = @"排列五";
    }else{
        
    }
    self.redBallCount = [NSMutableArray array];
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createUI{
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, DREAMCSCREEN_H - 40, DREAMCSCREEN_W, 40)];
    self.bottomView.backgroundColor = ECCOLOR(225, 225, 225, 1);
    [self.view addSubview:self.bottomView];

    
    self.tipLable = [[UILabel alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W - 150 - 10, 70, 150, 30)];
    self.tipLable.textAlignment = NSTextAlignmentRight;
    self.tipLable.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.tipLable];
    
    self.tipLable.text = @"每一位至少选一位";
  
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
    
    if (self.flag == 4) {
        
    }else{
        [self createBallWithRedBallCount:9 blueBall:9];
    }
    
    

}


-(void)createBallWithRedBallCount:(NSInteger)redBall blueBall:(NSInteger)blueBall{
    
    
    
    CGFloat buttonW = (DREAMCSCREEN_W - 50 - 6*20)/6;
    CGFloat buttonH = buttonW;
    CGFloat paceH = 20;
    CGFloat paceV = 5;
    
    for (NSInteger i = 0; i<3; i++) {
        
        
        for (NSInteger index = 0; index < redBall; index++) {
            
            NSInteger H = index%6;
            NSInteger v = index/6;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(15 + paceH + (buttonW + paceH)*H, v*(buttonH + paceV) + 100 + 100*i + i*v, buttonW, buttonH);
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = buttonW/2;
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor redColor].CGColor;
            button.tag = index + i;
            button.selected = NO;
            button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(changeBaiBallClick:) forControlEvents:UIControlEventTouchUpInside];
            if (index<=8) {
                [button setTitle:[@"0" stringByAppendingString: [NSString stringWithFormat:@"%ld",index + 1]] forState:UIControlStateNormal];
            }else{
                [button setTitle:[NSString stringWithFormat:@"%ld",index + 1] forState:UIControlStateNormal];
            }        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            [self.view addSubview:button];
        }
        
    }
    
}


#pragma mark -click

-(void)saveNumClick:(UIButton*)button{
    
    if ([MXAppConfig shareInstance].isLogin) {
        CGFloat ballCount;
        
        if (self.flag == 4) {
            ballCount = 5;
        }else{
            ballCount = 3;
        }
        
        if (self.redBallCount.count>=ballCount) {
            
            [self initAletrControllerTille:@"是否投注" message:@"投注后可到我的号码中查看" alertStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *go = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                
                BuyLottyParameter *parameter = [[BuyLottyParameter alloc]init];
                parameter.userId = [NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId];
                parameter.lotteryNo = [self.redBallCount componentsJoinedByString:@" "];
                parameter.lotteryBets = @"1";
            
                if (self.flag == 2) {
                    parameter.lotteryType = @"3d";
                    parameter.qihao = @"2017205";
                }else if(self.flag == 3){
                    parameter.lotteryType = @"pls";
                    parameter.qihao = @"2017203";
                }else{
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
            
            [self showWarningHudWithWarningTitle:@"至少每位选一位"];
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

-(void)changeBaiBallClick:(UIButton*)sender{
  
    if (sender.selected) {
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor whiteColor];
        sender.selected = NO;
        [self.redBallCount removeLastObject];
    }else{
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor redColor];
        sender.selected = YES;
         [self.redBallCount addObject:sender.titleLabel.text];
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
