//
//  InformationViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "InformationViewController.h"

#import "InformationTableViewCell.h"

@interface InformationViewController ()

@property (nonatomic, strong)NSMutableArray *responseDatas;
@property (nonatomic, assign)NSInteger currtenPage;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.responseDatas = [NSMutableArray array];
    
    self.currtenPage = 0;
    
    [self createUI];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UI

-(void)createUI{
    
    if ([self.typeId isEqualToString:@"1"]) {
        
        self.navigationItem.title = @"推荐资讯";
        
    }else if ([self.typeId isEqualToString:@"2"]){
        self.navigationItem.title = @"体育竞彩资讯";
    }else{
        self.navigationItem.title = @"数字竞彩资讯";
    }
    
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H) WithHeadRefresh:YES WithFootRefresh:YES WithScrollIndicator:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"informationcellId"];
}


#pragma mark -TableViewDelegate

-(void)tableViewHeadRefresh{
    
    InformationParamter *parameter = [[InformationParamter alloc]init];
    parameter.pageNo = [NSString stringWithFormat:@"%ld",self.currtenPage];
    if ([self.typeId isEqualToString:@"1"]) {
        parameter.typeId = @"1";
        
    }else if ([self.typeId isEqualToString:@"2"]){
        parameter.typeId = @"2";
    }else{
        parameter.typeId = @"3";
    }
    
    [UserAccountApi accountInforation:parameter block:^(NSMutableArray *responses, NSString *errorcode, NSString *erorMsg) {
        
        if ([errorcode isEqualToString:@"0"]) {
           
            [self.responseDatas removeAllObjects];
            [self.responseDatas addObjectsFromArray:responses];
            
            [self.tableView reloadData];
        }else{
            
        }
        
        [self.tableView.mj_header endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.responseDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informationcellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    InformationResponse *resposne = self.responseDatas[indexPath.row];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:resposne.imageurl]];
    cell.titleLable.text = resposne.title;
    cell.timeLable.text = [resposne.registertime componentsSeparatedByString:@" "].firstObject;
    cell.readLable.text = [NSString stringWithFormat:@"%ld",resposne.readCount];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)tableViewFootRefresh{
    [self showBaseHud];
    [self dismissHudWithWarningTitle:@"这是全部的资讯哦" After:1.f];
    [self.tableView.mj_footer endRefreshing];
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
