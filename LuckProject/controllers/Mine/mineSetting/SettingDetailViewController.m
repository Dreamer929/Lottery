//
//  SettingDetailViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/26.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "SettingDetailViewController.h"

@interface SettingDetailViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UITextField *nameText;
@property (nonatomic,strong)UITextField *idText;

@end

@implementation SettingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -ui

-(void)createUI{
    
   self.navigationItem.title = @"信息绑定";

    
    self.phoneText = [[UITextField alloc]init];
    self.phoneText.placeholder = @"请输入电话号码";
    self.phoneText.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneText.delegate = self;
    [self.view addSubview:self.phoneText];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(35);
    }];

    self.nameText = [[UITextField alloc]init];
    self.nameText.placeholder = @"请输入姓名";
    self.nameText.borderStyle = UITextBorderStyleRoundedRect;
    self.nameText.delegate = self;
    [self.view addSubview:self.nameText];

    
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneText.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(35);
    }];
    
    self.idText = [[UITextField alloc]init];
    self.idText.placeholder = @"请输入身份证号";
    self.idText.borderStyle = UITextBorderStyleRoundedRect;
    self.idText.delegate = self;
    [self.view addSubview:self.idText];
    
    
    [self.idText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameText.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(35);
    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.idText.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(35);
    }];
    
    if ([MXAppConfig shareInstance].isSign) {
        
        self.phoneText.text = [MXAppConfig shareInstance].phoneNumber;
        self.nameText.text = [MXAppConfig shareInstance].userRealName;
        self.idText.text = [MXAppConfig shareInstance].userIdCard;
    }
    
}


#pragma mark -click

-(void)commitClick:(UIButton*)button{
    
    if ([MXAppConfig shareInstance].isBinding) {
        
        [self showWarningHudWithWarningTitle:@"您已经绑定过信息"];
        [self dismissHudAfter:1.f];
    }else{
        if (self.phoneText.text.length == 11&&self.nameText.text.length&&self.idText.text.length == 18) {
            
            BandInformationParameter *parameter = [[BandInformationParameter alloc]init];
            parameter.phoneNumber = self.phoneText.text;
            parameter.realName = self.nameText.text;
            parameter.idCard = self.idText.text;
            [self showBaseHud];
            [UserAccountApi accountBandInformation:parameter blcok:^(NSString *errorcode, NSString *error) {
                
                if ([errorcode isEqualToString:@"0"]) {
                    [self dismissHudWithSuccessTitle:error After:1.f];
                    [self performSelector:@selector(backSetting) withObject:nil afterDelay:1.f];
                }else{
                    [self dismissHudWithErrorTitle:error After:1.f];
                }
            }];
            
        }else{
            
            [self showWarningHudWithWarningTitle:@"你填写的信息不符合规则"];
            [self dismissHudAfter:1.f];
        }
  
    }
    
}

#pragma mark back

-(void)backSetting{
    
    [self.navigationController popToRootViewControllerAnimated:YES];

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
