//
//  ForgetPasswordViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/19.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "UIButton+MSButton.h"
#import "MessageMessageParameter.h"
#import "UserAccountApi.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *phoneTextFiled;
@property (nonatomic, strong)UITextField *codeTextFiled;
@property (nonatomic, strong)UIButton* timeBurron;
@property (nonatomic, strong)UITextField *nePwdTextfile;

@property (nonatomic, strong)UIButton *registButton;
@property (nonatomic, copy)NSString *code;
@property (nonatomic, copy)NSString *time;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"忘记密码";
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -ui

-(void)createUI{
   
    self.phoneTextFiled = [[UITextField alloc]init];
    self.phoneTextFiled.placeholder = @"请输入电话号码";
    self.phoneTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneTextFiled.delegate = self;
    [self.view addSubview:self.phoneTextFiled];
    
    self.timeBurron = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.timeBurron setTimeStyle];
    [self.view addSubview:self.timeBurron];
    [self.timeBurron addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.codeTextFiled = [[UITextField alloc]init];
    self.codeTextFiled.placeholder = @"请输入验证码";
    self.codeTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.codeTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    self.codeTextFiled.delegate = self;
    [self.view addSubview:self.codeTextFiled];

    
    self.nePwdTextfile = [[UITextField alloc]init];
    self.nePwdTextfile.placeholder = @"请设置密码";
    self.nePwdTextfile.borderStyle = UITextBorderStyleRoundedRect;
    self.nePwdTextfile.keyboardType = UIKeyboardTypeDefault;
    self.nePwdTextfile.delegate = self;
    [self.view addSubview:self.nePwdTextfile];
    
    
    self.registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registButton.backgroundColor = [UIColor redColor];
    [self.registButton setTitle:@"重置" forState:UIControlStateNormal];
    self.registButton.layer.cornerRadius = 15;
    self.registButton.layer.masksToBounds = YES;
    [self.registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.registButton addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registButton];
    
    [self configUI];

}

-(void)configUI{
    
    [self.timeBurron mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.timeBurron.mas_left).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    [self.codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextFiled.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    
    [self.nePwdTextfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTextFiled.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nePwdTextfile.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
}


#pragma mark click

-(void)clickAction:(UIButton*)button{
    
    if (self.phoneTextFiled.text.length == 11) {
        
        MessageMessageParameter *parameter = [[MessageMessageParameter alloc]init];
        parameter.phoneNumber = self.phoneTextFiled.text;
        
        [self showBaseHud];
        
        [UserAccountApi accountMessage:parameter block:^(MessageResponse *response, NSString *errorMessage) {
            
            
            if ([errorMessage isEqualToString:@""]) {
                
                [self.timeBurron startTime];
                
                self.code = response.code;
                self.time = response.createtime;
                
                [self dismissHudWithSuccessTitle:errorMessage After:1.f];
                
            }else{
                
                [self dismissHudWithInfoTitle:errorMessage After:1.f];
            }
            
        }];
        
    }else{
        
        [self showWarningHudWithWarningTitle:@"请输入正确的电话号码"];
        [self dismissHudAfter:1.f];
    }
    
}

-(void)registerClick:(UIButton*)button{
    
    [self.phoneTextFiled resignFirstResponder];
    [self.codeTextFiled resignFirstResponder];
    [self.nePwdTextfile resignFirstResponder];
    
    if ([self.code isEqualToString:self.codeTextFiled.text]) {
        
        if ([self.nePwdTextfile.text isEqualToString:@""]) {
            
            [self showBaseHud];
            [self dismissHudWithWarningTitle:@"密码不能为空" After:1.f];
        }else{
            
            
            UserRegosterParameter *parameter = [[UserRegosterParameter alloc]init];
            parameter.phoneNumber = self.phoneTextFiled.text;
            parameter.code = self.codeTextFiled.text;
            parameter.codeTime = self.time;
            parameter.password = self.nePwdTextfile.text;
            
            [self showBaseHud];
            
            [UserAccountApi accountForgetPwd:parameter block:^(NSString *errorcode, NSString *errorMsg) {
                
                if ([errorcode isEqualToString:@"0"]) {
                    [self dismissHudWithSuccessTitle:errorMsg After:1.f];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self dismissHudWithErrorTitle:errorMsg After:1.f];
                }
            }];
            
            
        }
        
    }else{
        
        [self showBaseHud];
        [self dismissHudWithWarningTitle:@"请输入正确的验证码" After:1.f];
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
