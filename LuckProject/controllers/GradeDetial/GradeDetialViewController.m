//
//  GradeDetialViewController.m
//  LuckProject
//
//  Created by moxi on 2017/7/24.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "GradeDetialViewController.h"
#import "GradeDetailTableViewCell.h"

@interface GradeDetialViewController ()

@property (nonatomic, strong)NSMutableArray *responseData;

@end

@implementation GradeDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"个人积分明细";
    
    [self createUI];
    
    self.responseData = [NSMutableArray array];
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UI

-(void)createUI{
    
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H) WithHeadRefresh:YES WithFootRefresh:NO WithScrollIndicator:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"GradeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"gradecellId"];
}

-(void)netWork{
    [self showBaseHud];
    [UserAccountApi accountGrateDetial:[NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId] blcok:^(NSMutableArray *response, NSString *errorcode, NSString *errorMsg) {
        if ([errorcode isEqualToString:@"0"]) {
            
            [self.responseData addObjectsFromArray:response];
            
            [self.tableView reloadData];
            
            [self dismissHudWithSuccessTitle:errorMsg After:1.f];
            
        }else{
            
            [self dismissHudWithErrorTitle:errorMsg After:1.f];
        }
        [self.tableView.mj_header endRefreshing];
        
    }];
}

-(void)tableViewHeadRefresh{
    
    [self netWork];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.responseData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GradeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gradecellId" forIndexPath:indexPath];
    GradeDetialResponse * resposne = self.responseData[indexPath.row];
    cell.styleLable.text = resposne.typeName;
    cell.timeLable.text = [[resposne.createTime componentsSeparatedByString:@" "]firstObject];
    cell.gradeLable.text = [NSString stringWithFormat:@"%ld",resposne.scoreDetail];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (resposne.mark == 0) {
        cell.stylImage.image = ECIMAGENAME(@"add");
    }else{
        cell.stylImage.image = ECIMAGENAME(@"jian");
    }
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
