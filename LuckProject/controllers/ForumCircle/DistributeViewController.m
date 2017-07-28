//
//  DistributeViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/19.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "DistributeViewController.h"

@interface DistributeViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong)UITextView *contentTextFiled;
@property (nonatomic, strong)UITextField *titleTextFiled;

@end

@implementation DistributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发表论坛";
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

-(void)createUI{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:ECIMAGENAME(@"fatie") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fabuClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
    self.titleTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, 80, DREAMCSCREEN_W - 40, 35)];
    self.titleTextFiled.delegate = self;
    self.titleTextFiled.placeholder = @"标题";
    self.titleTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.titleTextFiled];

    
    self.contentTextFiled = [[UITextView alloc]initWithFrame:CGRectMake(20, 130, DREAMCSCREEN_W - 40, DREAMCSCREEN_H/2)];
    self.contentTextFiled.delegate = self;
    self.contentTextFiled.layer.borderColor = ECCOLOR(225, 220, 220, 1).CGColor;
    self.contentTextFiled.layer.borderWidth =1.0;

    [self.view addSubview:self.contentTextFiled];
}


#pragma mark -click

-(void)fabuClick:(UIButton*)button{
    
    [self.contentTextFiled resignFirstResponder];
    [self.titleTextFiled resignFirstResponder];
    
    [self showBaseHud];
    
    if (self.contentTextFiled.text.length && self.titleTextFiled.text.length) {
        
        NSDictionary *dic = @{
                              @"userId":[NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId],
                              @"title":self.contentTextFiled.text,
                              @"content":self.contentTextFiled.text
                              };
        
        [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:@"forum/saveUserForum.do"] parameters:dic success:^(id responseObject) {
            
            if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
                
                [self dismissHudWithSuccessTitle:responseObject[@"error"] After:1.f];
                
                [self performSelector:@selector(backVC) withObject:nil afterDelay:1.f];
            }else{
                
                [self dismissHudWithErrorTitle:responseObject[@"error"] After:1.f];
            }
            
            
        } failure:^(NSError *error) {
            
            [self dismissHudWithErrorTitle:@"" After:1.f];
        }];

    }else{
        
        [self dismissHudWithInfoTitle:@"内容和标题不能为空" After:2.f];
    }
    
}

-(void)backVC{
    [self.navigationController popViewControllerAnimated:YES];
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
