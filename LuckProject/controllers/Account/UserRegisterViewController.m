//
//  UserRegisterViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/17.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "UIButton+MSButton.h"
#import "UserAccountApi.h"
#import "UserRegosterParameter.h"
#import "MessageMessageParameter.h"

@interface UserRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic, strong)UITextField *passwordText;
@property (nonatomic, strong)UITextField *userNameText;
@property (nonatomic, strong)UITextField *codeText;
@property (nonatomic, strong)UIButton *registerBurton;

@property (nonatomic, strong)UIButton *timerButton;
@property (nonatomic, copy)NSString *code;
@property (nonatomic, copy)NSString *time;

@end

@implementation UserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UI

-(void)createUI{
    
    self.phoneText = [[UITextField alloc]init];
    self.phoneText.placeholder = @"请输入电话号码";
    self.phoneText.keyboardType = UIKeyboardTypePhonePad;
    self.phoneText.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneText.delegate = self;
    [self.view addSubview:self.phoneText];
    
    self.timerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.timerButton setTimeStyle];
    [self.view addSubview:self.timerButton];
    [self.timerButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.codeText = [[UITextField alloc]init];
    self.codeText.placeholder = @"请输入验证码";
    self.codeText.keyboardType = UIKeyboardTypePhonePad;
    self.codeText.borderStyle = UITextBorderStyleRoundedRect;
    self.codeText.delegate = self;
    [self.view addSubview:self.codeText];
    
    self.userNameText = [[UITextField alloc]init];
    self.userNameText.placeholder = @"请输入用户名";
    self.userNameText.delegate = self;
    self.userNameText.keyboardType = UIKeyboardTypeDefault;
    self.userNameText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.userNameText];
    
    self.passwordText = [[UITextField alloc]init];
    self.passwordText.placeholder = @"请设置密码";
    self.passwordText.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText.keyboardType = UIKeyboardTypeDefault;
    self.passwordText.delegate = self;
    [self.view addSubview:self.passwordText];
    
    
    self.registerBurton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBurton.backgroundColor = [UIColor redColor];
    [self.registerBurton setTitle:@"注册" forState:UIControlStateNormal];
    self.registerBurton.layer.cornerRadius = 15;
    self.registerBurton.layer.masksToBounds = YES;
    [self.registerBurton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.registerBurton addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBurton];
    
    [self configUI];
}

-(void)configUI{
    
    [self.timerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.timerButton.mas_left).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneText.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    
    [self.userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeText.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    
    [self.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameText.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
    
    [self.registerBurton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordText.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(30);
    }];
}


#pragma mark click

-(void)clickAction:(UIButton*)button{
    
    if (self.phoneText.text.length == 11) {
        
        MessageMessageParameter *parameter = [[MessageMessageParameter alloc]init];
        parameter.phoneNumber = self.phoneText.text;
        
        [UserAccountApi accountMessage:parameter block:^(MessageResponse *response, NSString *errorMessage) {
            
            [self showBaseHudWithTitle:@""];
            
            if ([errorMessage isEqualToString:@""]) {
                
                [self.timerButton startTime];
                
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
    
    [self.phoneText resignFirstResponder];
    [self.codeText resignFirstResponder];
    [self.userNameText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    
    if ([self.code isEqualToString:self.codeText.text]) {
        
        if ([self.userNameText.text isEqualToString:@""] || [self.passwordText.text isEqualToString:@""]) {
            
            [self showBaseHud];
            [self dismissHudWithWarningTitle:@"用户名和密码不能为空" After:1.f];
        }else{
            
            
            UserRegosterParameter *parameter = [[UserRegosterParameter alloc]init];
            parameter.phoneNumber = self.phoneText.text;
            parameter.username = self.userNameText.text;
            parameter.code = self.codeText.text;
            parameter.codeTime = self.time;
            parameter.password = self.passwordText.text;
            
            [self showBaseHud];
            
            [UserAccountApi accountRegister:parameter block:^(UserRegosterResponse *reponse, NSString *errorMessage) {
                
                if (reponse) {
                    
                    [self dismissHudWithSuccessTitle:errorMessage After:1.f];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [self dismissHudWithErrorTitle:errorMessage After:1.f];
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
