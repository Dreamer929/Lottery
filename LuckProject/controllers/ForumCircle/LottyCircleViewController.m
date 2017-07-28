//
//  LottyCircleViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/18.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "LottyCircleViewController.h"
#import "UserAccountApi.h"
#import "ForumParameter.h"
#import "ForumTableViewCell.h"
#import "LottyCircleDetileViewController.h"
#import "DistributeViewController.h"

@interface LottyCircleViewController ()

@property (nonatomic, strong)NSMutableArray *responseDatas;
@property (nonatomic, assign)NSInteger page;


@end

@implementation LottyCircleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"彩票圈";
    
    self.responseDatas = [NSMutableArray array];
    
    self.page = 0;
    
    [self createUI];
    [self.tableView.mj_header beginRefreshing];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -ui

-(void)createUI{
    
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H) WithHeadRefresh:YES WithFootRefresh:YES WithScrollIndicator:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"ForumTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellid"];
    
    [self.tableView.mj_header beginRefreshing];
    
    [self initNarRightButton];
}

#pragma mark -righButton

-(void)initNarRightButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:ECIMAGENAME(@"fatie") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(distrubeClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
}

#pragma mark -click

-(void)distrubeClick:(UIButton*)button{
    
    if ([MXAppConfig shareInstance].isLogin) {
        DistributeViewController *vc = [[DistributeViewController alloc]init];
        
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



#pragma mark -refresh

-(void)tableViewHeadRefresh{
    
    ForumParameter *parameter = [[ForumParameter alloc]init];
    parameter.pageNo = [NSString stringWithFormat:@"%ld",self.page];
    parameter.pageSize = @"30";
    parameter.userId = [NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId];
    
    [self showBaseHud];
    
    [UserAccountApi accountGetForum:parameter block:^(NSMutableArray* responseArr,NSString *errorMsg) {
        
        if (responseArr.count) {
            
            [self.responseDatas removeAllObjects];
            
            [self.responseDatas addObjectsFromArray:responseArr];
            
            [self dismissHudWithSuccessTitle:@"" After:1.f];
            
            [self.tableView reloadData];
            
        }else{
            [self dismissHudWithErrorTitle:@"" After:1.f];
        }
        
        [self.tableView.mj_header endRefreshing];
        
    }];
}

-(void)tableViewFootRefresh{
   
    ForumParameter *parameter = [[ForumParameter alloc]init];
    parameter.pageNo = [NSString stringWithFormat:@"%ld",++self.page];
    parameter.pageSize = @"30";
    parameter.userId = [NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId];
    
    [self showBaseHud];
    
    [UserAccountApi accountGetForum:parameter block:^(NSMutableArray* responseArr,NSString *errorMsg) {
        
        if (responseArr.count) {
            
            [self.responseDatas addObjectsFromArray:responseArr];
            
            [self dismissHudWithSuccessTitle:@"" After:1.f];
            
            [self.tableView reloadData];
            
            
        }else{
            [self dismissHudWithErrorTitle:@"" After:1.f];
        }
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
}



#pragma mark -tableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.responseDatas.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ForumResponse *response = self.responseDatas[indexPath.row];
    NSString *cellString = response.content;
    
    CGSize cellSize = STRING_SIZE(DREAMCSCREEN_W - 16, cellString, 12);
    CGFloat cellHeigh = cellSize.height;
    
    return cellHeigh + 100;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    ForumResponse *response = self.responseDatas[indexPath.row];
    
    [cell.userheadView sd_setImageWithURL:[NSURL URLWithString:response.imgPath] placeholderImage:ECIMAGENAME(@"header") completed:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userNickLable.text = response.username;
    cell.createTimeLable.text = response.createTime;
    cell.contentLable.text = response.content;
    cell.zanLable.text = [NSString stringWithFormat:@"%ld",response.hitTotal];
    if (response.isThumb) {
        cell.zanImage.image = ECIMAGENAME(@"yizan");
    }else{
        cell.zanImage.image = ECIMAGENAME(@"zan");
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([MXAppConfig shareInstance].isLogin) {
        
        LottyCircleDetileViewController *vc = [[LottyCircleDetileViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        vc.response = self.responseDatas[indexPath.row];
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
