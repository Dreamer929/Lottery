//
//  XieyiViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/27.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "XieyiViewController.h"

@interface XieyiViewController ()

@property (nonatomic,strong)UITextView *severceTextView;

@end

@implementation XieyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"服务协议";
    
    self.severceTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H)];
    
    [self.view addSubview:self.severceTextView];
    self.severceTextView.editable = NO;
    NSString *thepath = [[NSBundle mainBundle] pathForResource:@"serviceDetail"ofType:@"txt"];
    NSFileManager* fm = [NSFileManager defaultManager];
    NSData* data = [[NSData alloc] init];
    data = [fm contentsAtPath:thepath];
    
    
    self.severceTextView.text=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.severceTextView.font = [UIFont systemFontOfSize:15];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
