//
//  AboutUsViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/27.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"关于";
    
    [self creteUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creteUI{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = ECIMAGENAME(@"mylogo");
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(64*2);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    UILabel *lable = [[UILabel alloc]init];
    lable.text = [appCurName stringByAppendingString:[@" v:" stringByAppendingString:appCurVersion]];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:lable];
    
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).offset(8);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
    }];
    
    UILabel *shengming = [[UILabel alloc]init];
    shengming.text = @"声明:您通过本应用参加的各种活动,与Apple Inc.无关。";
    shengming.font = [UIFont systemFontOfSize:14];
    shengming.numberOfLines = 0;
    shengming.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:shengming];
    
    [shengming mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lable.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(50);
    }];
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
