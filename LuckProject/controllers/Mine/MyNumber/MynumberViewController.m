//
//  MynumberViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/27.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MynumberViewController.h"

@interface MynumberViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *totalTableview;
@property (nonatomic, strong)UITableView *kjTableview;
@property (nonatomic, strong)UITableView *ticketTableview;

@property (nonatomic, strong)UIButton *totalButton;
@property (nonatomic, strong)UIButton *kjButton;
@property (nonatomic, strong)UIButton *ticketButton;

@property (nonatomic, strong)UIScrollView *scrollview;

@property (nonatomic, strong)NSMutableArray *totalDatas;
@property (nonatomic ,strong)NSMutableArray *kjDatas;
@property (nonatomic, strong)NSMutableArray *ticketDatas;

@end

@implementation MynumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的彩票";
    
    self.totalDatas = [NSMutableArray array];
    self.kjDatas = [NSMutableArray array];
    self.ticketDatas = [NSMutableArray array];
    
    [self createButton];
    [self createScrollview];
    
    [self.totalTableview.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark initUI

-(void)createButton{
    
    self.totalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.totalButton setTitle:@"全部" forState:UIControlStateNormal];
    self.totalButton.backgroundColor = ECCOLOR(225, 225, 225, 1);
    [self.totalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.totalButton addTarget:self action:@selector(clickQg:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.totalButton];
    
    self.kjButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.kjButton setTitle:@"待开奖" forState:UIControlStateNormal];
    self.kjButton.backgroundColor = ECCOLOR(225, 225, 225, 1);
    [self.kjButton addTarget:self action:@selector(clickDf:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.kjButton];
    
    self.ticketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.ticketButton setTitle:@"待出票" forState:UIControlStateNormal];
    self.ticketButton.backgroundColor = ECCOLOR(225, 225, 225, 1);
    [self.ticketButton addTarget:self action:@selector(clickGp:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.ticketButton];
    
    [self configuf];
    
}

-(void)configuf{
    
    CGFloat buttonW = DREAMCSCREEN_W/3;
    
    [self.totalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(buttonW);
        make.height.mas_equalTo(40);
    }];
    
    [self.kjButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.mas_equalTo(self.totalButton.mas_right);
        make.width.mas_equalTo(buttonW);
        make.height.mas_equalTo(40);
    }];
    
    [self.ticketButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.mas_equalTo(self.kjButton.mas_right);
        make.width.mas_equalTo(buttonW);
        make.height.mas_equalTo(40);
    }];
}

-(void)createScrollview{
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, DREAMCSCREEN_W, DREAMCSCREEN_H - 104)];
    self.scrollview.contentSize = CGSizeMake(DREAMCSCREEN_W*3, DREAMCSCREEN_H - 104 - 49);
    self.scrollview.delegate = self;
    self.scrollview.pagingEnabled = YES;
    self.scrollview.bounces = NO;
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollview];
    
    [self createTableview];
}

-(void)createTableview{
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.totalTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, self.scrollview.frame.size.height) style:UITableViewStylePlain];
    self.totalTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(qgtableViewHeadRefresh)];
    
    [self createTablviewWith:self.totalTableview isshowVerScroll:NO];
    
    self.kjTableview = [[UITableView alloc] initWithFrame:CGRectMake(DREAMCSCREEN_W, 0, DREAMCSCREEN_W, self.scrollview.frame.size.height) style:UITableViewStylePlain];
    self.kjTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.kjTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dftableViewHeadRefresh)];
    self.kjTableview.backgroundColor = ECCOLOR(235, 235, 235, 1);
    [self createTablviewWith:self.kjTableview isshowVerScroll:NO];
    
    self.ticketTableview = [[UITableView alloc] initWithFrame:CGRectMake(DREAMCSCREEN_W*2, 0, DREAMCSCREEN_W, self.scrollview.frame.size.height) style:UITableViewStylePlain];
    self.ticketTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(gptableViewHeadRefresh)];
    self.ticketTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self createTablviewWith:self.ticketTableview isshowVerScroll:NO];

}

-(void)createTablviewWith:(UITableView*)tableview isshowVerScroll:(BOOL)isShow{
    
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    tableview.showsVerticalScrollIndicator = isShow;
    
    tableview.tableFooterView = [[UIView alloc]init];
    
    [self.scrollview addSubview:tableview];
}


#pragma mark -Click

-(void)clickQg:(UIButton*)buton{
    
    [self.totalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.kjButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ticketButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.scrollview.contentOffset = CGPointMake(0, 0);
    
}
-(void)clickDf:(UIButton *)button{
    
    [self.kjButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.totalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ticketButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.kjTableview.mj_header beginRefreshing];
    
    self.scrollview.contentOffset = CGPointMake(DREAMCSCREEN_W, 0);
    
}

-(void)clickGp:(UIButton*)button{
    
    [self.ticketButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.kjButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.totalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
   [self.ticketTableview.mj_header beginRefreshing];
    
    self.scrollview.contentOffset = CGPointMake(DREAMCSCREEN_W*2, 0);
    
}



#pragma mark tableview

-(void)netrequest:(BuyLottyHistoryParameter*)parameter{
    
    
    [self showBaseHud];
    [UserAccountApi accountBuyLottyHistory:parameter block:^(NSMutableArray *responses, NSString *errorcode, NSString *error) {
        
        if ([errorcode isEqualToString:@"0"]) {
            
            if (responses.count == 0) {
                
                [self dismissHudWithInfoTitle:@"没有记录哦，买一注吧" After:1.f];
            }else{
                [self.totalDatas removeAllObjects];
                [self.totalDatas addObjectsFromArray:responses];
                [self.totalTableview reloadData];
                [self dismissHudWithSuccessTitle:error After:1.f];
            }
            
        }else{
            [self dismissHudWithErrorTitle:error After:1.f];
        }
        
        [self.totalTableview.mj_header endRefreshing];
        [self.kjTableview.mj_header endRefreshing];
        [self.ticketTableview.mj_header endRefreshing];
    }];
}

-(void)qgtableViewHeadRefresh{
    BuyLottyHistoryParameter *parameter = [[BuyLottyHistoryParameter alloc]init];
    parameter.typeId = @"1";
    [self netrequest:parameter];
}


-(void)dftableViewHeadRefresh{
    BuyLottyHistoryParameter *parameter = [[BuyLottyHistoryParameter alloc]init];
    parameter.typeId = @"2";
    [self netrequest:parameter];
}


-(void)gptableViewHeadRefresh{
    
    BuyLottyHistoryParameter *parameter = [[BuyLottyHistoryParameter alloc]init];
    parameter.typeId = @"3";
    [self netrequest:parameter];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.totalDatas.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BuyLottyHistoryResponse *response;
    if (tableView == self.totalTableview) {
       response = self.totalDatas[indexPath.row];
    }else if (tableView == self.kjTableview){
        response = self.kjDatas[indexPath.row];
    }else{
        response = self.ticketDatas[indexPath.row];
    }
    cell.textLabel.text = response.lotteryTypeName;
    cell.detailTextLabel.text = response.lotteryNo;
    
    return cell;
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
