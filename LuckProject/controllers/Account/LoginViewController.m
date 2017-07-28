//
//  LoginViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/17.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "LoginViewController.h"

#import "UserRegisterViewController.h"
#import "UserAccountApi.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *phoneText;
@property (nonatomic, strong)UITextField *passwordText;

@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIButton *forgetButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"登录";
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UI

-(void)createUI{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 30);
    [button setTitle:@"注册" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 40, 30);
    [left setTitle:@"返回" forState:UIControlStateNormal];
    [left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(dismissClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.phoneText = [[UITextField alloc]init];
    self.phoneText.placeholder = @"请输入电话号码";
    self.phoneText.keyboardType = UIKeyboardTypePhonePad;
    self.phoneText.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneText.delegate = self;
    [self.view addSubview:self.phoneText];
    
    self.passwordText = [[UITextField alloc]init];
    self.passwordText.placeholder = @"请输入入密码";
    self.passwordText.keyboardType = UIKeyboardTypeDefault;
    self.passwordText.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordText.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText.delegate = self;
    [self.view addSubview:self.passwordText];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    self.loginButton.backgroundColor = [UIColor redColor];
    [self.loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 15;
    [self.view addSubview:self.loginButton];
    
    self.forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.forgetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.forgetButton addTarget:self action:@selector(forgetClick:) forControlEvents:UIControlEventTouchUpInside];
    self.forgetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:self.forgetButton];
    
    [self configUi];
    
}

#pragma mark -config

-(void)configUi{
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(30);
    }];
    
    [self.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneText.mas_bottom).offset(30);
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(30);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordText.mas_bottom).offset(30);
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(30);
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(30);
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(30);
    }];
}


#pragma mark -click

-(void)enterRegisterClick:(UIButton*)button{
    
    UserRegisterViewController *vc = [[UserRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dismissClick:(UIButton*)button{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginClick:(UIButton*)button{
    
    [self.phoneText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    
    if (self.phoneText.text.length == 11 && self.passwordText.text) {
        
        LoginParameter *parameter = [[LoginParameter alloc]init];
        parameter.phoneNumber = self.phoneText.text;
        parameter.password = self.passwordText.text;
        
        [self showBaseHud];
        
        [UserAccountApi accountLogin:parameter block:^(LoginResponse *response, NSString *errorMessage) {
            
            if (response) {
                [self dismissHudWithSuccessTitle:errorMessage After:1.f];
                [self performSelector:@selector(dismissLoginVC) withObject:nil afterDelay:1.0];
            }else{
                [self dismissHudWithErrorTitle:errorMessage After:1.f];
            }
        }];
        
    }else{
        
        [self showWarningHudWithWarningTitle:@"请输入正确的账号和密码"];
        [self dismissHudAfter:1.f];
    }
}

-(void)forgetClick:(UIButton*)button{
    
    ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark -metch

-(void)dismissLoginVC{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.phoneText resignFirstResponder];
    [self.passwordText resignFirstResponder];
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
