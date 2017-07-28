//
//  LottyCircleDetileViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/18.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "LottyCircleDetileViewController.h"
#import "ForumDetialParameter.h"
#import "UserAccountApi.h"
#import "ForumLunTableViewCell.h"
#import "ForumLunParameter.h"

@interface LottyCircleDetileViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)NSMutableArray *responseDatas;
@property (nonatomic, strong)UIButton *buttonZan;
@property (nonatomic, strong)UITextField *lunTextFiled;
@property (nonatomic, strong)UIView *lunBaseView;
@property (nonatomic, strong)UILabel *lunLable;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UILabel *zanLabel;

@property (nonatomic, assign)BOOL isZan;
@property (nonatomic, assign)NSInteger zanCount;
@property (nonatomic, assign)BOOL isLun;
@property (nonatomic, assign)NSInteger lunCount;

@end

@implementation LottyCircleDetileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isLun = NO;
    self.isZan = NO;
    
    self.navigationItem.title = @"详情";
    self.responseDatas = [NSMutableArray array];
    
    [self createUI];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(show:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -CreateUI

-(void)createUI{
    
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H - 30) WithHeadRefresh:YES WithFootRefresh:YES WithScrollIndicator:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"ForumLunTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, 210)];
    self.tableView.tableHeaderView = self.headerView;

    UIImageView *headView = [[UIImageView alloc]init];
    [headView sd_setImageWithURL:[NSURL URLWithString:self.response.imgPath]];
    headView.frame = CGRectMake(8, 8, 40, 40);
    headView.layer.masksToBounds = YES;
    headView.layer.cornerRadius = 20;
    [self.headerView addSubview:headView];
    
    UILabel *nickLable = [[UILabel alloc]init];
    nickLable.text = self.response.username;
    nickLable.frame = CGRectMake(50, 10, 150, 25);
    [self.headerView addSubview:nickLable];
    
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W - 120, 10, 100, 25)];
    timeLable.text = [self.response.createTime componentsSeparatedByString:@" "].firstObject;
    timeLable.textAlignment = NSTextAlignmentRight;
    timeLable.font = [UIFont systemFontOfSize:14];
    [self.headerView addSubview:timeLable];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, DREAMCSCREEN_W - 20, 100)];
    lable.numberOfLines = 0;
    lable.text = self.response.content;
    lable.font = [UIFont systemFontOfSize:13];
    [self.headerView addSubview:lable];
    
    self.buttonZan = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonZan.frame = CGRectMake(5, 150, 20, 20);
    
    self.zanLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 150, 40, 20)];
    self.zanLabel.font = [UIFont systemFontOfSize:12];
    self.zanLabel.textColor = [UIColor blackColor];
    self.zanLabel.textAlignment = NSTextAlignmentLeft;
    self.zanLabel.text = [NSString stringWithFormat:@"%ld",self.response.hitTotal];
    [self.headerView addSubview:self.zanLabel];
    
    if (self.isZan) {
        
        [self.buttonZan setImage:ECIMAGENAME(@"yizan") forState:UIControlStateNormal];
        self.buttonZan.userInteractionEnabled = NO;
        self.zanLabel.text = [NSString stringWithFormat:@"%ld",self.zanCount];
        
    }else{
       
        if (self.response.isThumb) {
            
            [self.buttonZan setImage:ECIMAGENAME(@"yizan") forState:UIControlStateNormal];
            self.buttonZan.userInteractionEnabled = NO;
            
        }else{
            [self.buttonZan setImage:ECIMAGENAME(@"zan") forState:UIControlStateNormal];
        }
    }
    
    
    [self.buttonZan addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView addSubview:self.buttonZan];
    
    UIImageView *readImage = [[UIImageView alloc]init];
    readImage.image = ECIMAGENAME(@"read");
    readImage.frame = CGRectMake(DREAMCSCREEN_W/2 - 20, 150, 20, 20);
    [self.headerView addSubview:readImage];
    UILabel *readLable = [[UILabel alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W/2, 150, 30, 20)];
    readLable.font = [UIFont systemFontOfSize:12];
    readLable.textColor = [UIColor blackColor];
    readLable.textAlignment = NSTextAlignmentLeft;
    readLable.text = [NSString stringWithFormat:@"%ld",self.response.readCount];
    [self.headerView addSubview:readLable];
    
    UIImageView *lunImage = [[UIImageView alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W - 50, 150, 20, 20)];
    lunImage.image = ECIMAGENAME(@"lun");
    [self.headerView addSubview:lunImage];
    
    self.lunLable = [[UILabel alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W - 20, 150, 30, 20)];
    
    if (self.isLun) {
        self.lunLable.text = [NSString stringWithFormat:@"%ld",self.lunCount];
    }else{
        self.lunLable.text = [NSString stringWithFormat:@"%ld",self.response.commentCount];
    }
    
    self.lunLable.font = [UIFont systemFontOfSize:12];
    self.lunLable.textColor = [UIColor blackColor];
    [self.headerView addSubview:self.lunLable];
    
    UILabel *tipLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, DREAMCSCREEN_W, 30)];
    tipLable.backgroundColor = ECCOLOR(230, 230, 230, 1);
    tipLable.textColor = [UIColor blackColor];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.font = [UIFont systemFontOfSize:15];
    if (self.response.commentCount) {
        tipLable.text = @"也留下你独特的见解吧";
    }else{
        tipLable.text = @"还没有评论哦，快来抢一楼";
    }
    [self.headerView addSubview:tipLable];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.lunBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, DREAMCSCREEN_H - 35, DREAMCSCREEN_W, 35)];
    self.lunBaseView.backgroundColor = ECCOLOR(220, 220, 220, 1);
    [self.view addSubview:self.lunBaseView];
    
    self.lunTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(3, 3, DREAMCSCREEN_W - 6, 29)];
    self.lunTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    self.lunTextFiled.placeholder = @"发表你的评论";
    self.lunTextFiled.delegate = self;
    [self.lunBaseView addSubview:self.lunTextFiled];
}

#pragma mark -netquest

-(void)netquest{
    
    [self showBaseHud];
    
    ForumDetialParameter *parameter = [[ForumDetialParameter alloc]init];
    parameter.forumId = [NSString stringWithFormat:@"%ld",self.response.forumId];
    parameter.userId = [NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId];
    parameter.token = [MXAppConfig shareInstance].token;
    
    [UserAccountApi accountGetForumDetial:parameter blcok:^(NSMutableArray *responseArr, NSString *errorMsg) {
        
        if ([errorMsg isEqualToString:@""]) {
            [self.responseDatas removeAllObjects];
            [self.responseDatas addObjectsFromArray:responseArr];
            [self dismissHudWithSuccessTitle:errorMsg After:1.f];
            [self.tableView reloadData];
        }else{
            [self dismissHudWithErrorTitle:errorMsg After:1.f];
        }
        
        [self.tableView.mj_header endRefreshing];
        
    }];
}


#pragma mark -TableviewDelegate

-(void)tableViewHeadRefresh{
    
    [self netquest];
}

-(void)tableViewFootRefresh{
    
    [self showBaseHud];
    [self dismissHudWithSuccessTitle:@"评论已加载完" After:1.f];
    [self.tableView.mj_footer endRefreshing];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.responseDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ForumLunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ForumDetialResponse *response = self.responseDatas[indexPath.row];
    
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:response.imgPath] placeholderImage:ECIMAGENAME(@"")];
    cell.timeLable.text = [response.createTime componentsSeparatedByString:@" "].firstObject;
    cell.userNameLable.text = response.username;
    cell.contentLable.text = response.content;
    return cell;
}

#pragma mark -click

-(void)zanClick:(UIButton*)button{
    
    
        
        NSDictionary *dic = @{
                              @"userId":[NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId ],
                              @"forumId":[NSString stringWithFormat:@"%ld",self.response.forumId]
                              };
        
        [UserAccountApi accountZanForum:dic block:^(ForumZanResponse *response, NSString *errorMsg,NSString *errorcode) {
            
            if ([errorcode isEqualToString:@"0"]) {
                
                [self.buttonZan setImage:ECIMAGENAME(@"yizan") forState:UIControlStateNormal];
                self.isZan = YES;
                self.zanLabel.text = [NSString stringWithFormat:@"%ld",response.totalHit];
                self.zanCount = response.totalHit;
            }else{
                
                [self showWarningHudWithWarningTitle:errorMsg];
                [self dismissHudAfter:1.f];
            }
            
        }];

}

#pragma mark -UItextFiled

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.text.length) {
        
        ForumLunParameter *parameter = [[ForumLunParameter alloc]init];
        parameter.forumId = [NSString stringWithFormat:@"%ld",self.response.forumId];
        parameter.content = textField.text;
        parameter.userId = [NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId];
        
        [UserAccountApi accountLunForum:parameter block:^(ForumLunResponse *response, NSString *errorMsg,NSString *code) {
            
            if ([code isEqualToString:@"0"]) {
                self.lunTextFiled.text = @"";
                [self showSuccessHudWithSuccessTitle:@""];
                self.isLun = YES;
                self.lunCount = response.commentCount + 1;
                [self.tableView.mj_header beginRefreshing];
            }else{
                [self showErrorHudWithErrorTitle:errorMsg];
            }
            [self dismissHudAfter:1.f];
        }];
    }
    
    [self.lunTextFiled resignFirstResponder];
    
    return YES;
}


#pragma mark -keyboard

-(void)show:(NSNotification*)ns{
   
    NSValue *value = [ns.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardHeight = [value CGRectValue].size.height;
    self.lunBaseView.frame = CGRectMake(0, DREAMCSCREEN_H - 35 - keyBoardHeight, DREAMCSCREEN_W, 35);
}

-(void)hide:(NSNotification*)ns{
    
    self.lunBaseView.frame = CGRectMake(0, DREAMCSCREEN_H - 35, DREAMCSCREEN_W, 35);
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
