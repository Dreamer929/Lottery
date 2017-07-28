//
//  MineViewController.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MineViewController.h"
#import "SettingViewController.h"
#import "MynumberViewController.h"
#import "AboutUsViewController.h"
#import "XieyiViewController.h"


@interface MineViewController ()

@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UI

-(void)createUI{
    
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H) WithHeadRefresh:NO WithFootRefresh:NO WithScrollIndicator:NO];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:ECIMAGENAME(@"setting") forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button addTarget:self action:@selector(mineSettingClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark -Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([MXAppConfig shareInstance].isLogin) {
        
        return 4;
    }
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor redColor];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 50, 50)];
        imageView.userInteractionEnabled = YES;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 25;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginhandle:)]];
        [view addSubview:imageView];
        
        UILabel *nickLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 30, 80, 20)];
        nickLable.textColor = [UIColor whiteColor];
        nickLable.userInteractionEnabled = YES;
        [nickLable addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginhandle:)]];
        UILabel *gradeLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 150, 20)];
        gradeLable.textColor = [UIColor whiteColor];
        gradeLable.userInteractionEnabled = YES;
        [gradeLable addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginhandle:)]];
        
        if ([MXAppConfig shareInstance].isLogin) {
            nickLable.text =[MXAppConfig shareInstance].username;
            gradeLable.text = [NSString stringWithFormat:@"积分：%ld  >",[MXAppConfig shareInstance].score];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[MXAppConfig shareInstance].imgPath] placeholderImage:[UIImage imageNamed:@"header"]];
        }else{
            
            nickLable.text = @"立即登录";
            gradeLable.text = @"登录后可查看积分";
            imageView.image = ECIMAGENAME(@"header");
        }
        
        [view addSubview:nickLable];
        [view addSubview:gradeLable];
        
        return view;
    }else{
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = ECCOLOR(225, 225, 225, 1);
        return view;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 120;
    }
    return 20;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0) {
       cell.textLabel.text = @"我的彩票";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"服务协议";
    }else if (indexPath.section == 2){
        cell.textLabel.text = @"关于";
    }else{
        cell.textLabel.text = @"退出登录";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     if (indexPath.section == 0){
        
         if ([MXAppConfig shareInstance].isLogin) {
             
             MynumberViewController *vc = [[MynumberViewController alloc]init];
             self.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:vc animated:YES];
             self.hidesBottomBarWhenPushed = NO;
             
         }else{
             
             LoginViewController *vc = [[LoginViewController alloc]init];
             UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
             nvc.navigationBar.barTintColor = [UIColor redColor];
             [nvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
             [self presentViewController:nvc animated:YES completion:nil];
         }
        
        
    }else if(indexPath.section == 1){
        
        XieyiViewController *vc = [[XieyiViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }else if(indexPath.section == 2){
        
        AboutUsViewController *vc = [[AboutUsViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }else{
        [self signOut];
    }
    
}

#pragma mark -click

-(void)mineSettingClick:(UIButton*)button{
    
    if ([MXAppConfig shareInstance].isLogin) {
        SettingViewController *vc = [[SettingViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        LoginViewController *vc = [[LoginViewController alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        nvc.navigationBar.barTintColor = [UIColor redColor];
        [nvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

-(void)signOut{
    
    [self showBaseHud];
    [UserAccountApi accountSignOut:[NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId] block:^(NSString *code, NSString *errorMsg) {
        
        if ([code isEqualToString:@"0"]) {
            [self dismissHudWithSuccessTitle:@"" After:1.f];
            [self.tableView reloadData];
        }else{
            [self dismissHudWithErrorTitle:errorMsg After:1.f];
        }
        
    }];
    
}


-(void)loginhandle:(UITapGestureRecognizer*)tap{
    
    if ([MXAppConfig shareInstance].isLogin) {
        GradeDetialViewController *vc = [[GradeDetialViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
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
