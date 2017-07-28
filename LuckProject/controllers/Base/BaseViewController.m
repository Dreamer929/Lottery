//
//  BaseViewController.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------TableView------
/**
 *  初始化TableView
 *
 *  @param frame  TableView的坐标
 *  @param isHead 是否需要下拉刷新
 *  @param isFoot 是否需要上拉加载
 *  @param isShow 是否显示滚动条
 */
- (void)initTableViewWithFrame:(CGRect)frame WithHeadRefresh:(BOOL)isHead WithFootRefresh:(BOOL)isFoot WithScrollIndicator:(BOOL)isShow
{
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    if (isShow) {
        self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
  
    }else{
        self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    }
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if (isHead) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewHeadRefresh)];
    }
    
    if (isFoot){
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewFootRefresh)];
    }
    
    [self.view addSubview:_tableView];
}



#pragma mark ------TableView代理函数------

/**
 *  设置TableView的Section
 *
 *  @param tableView self.tableView
 *
 *  @return Section数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    //    NSLog(@"Section条数%s",__FUNCTION__);
    return 1;
}


/**
 *  设置Section中的Row
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Row数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"Rows条数%s",__FUNCTION__);
    return 1;
}


/**
 *  设置Section的Header高度
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Section的Header高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    NSLog(@"SectionHeader高度%s",__FUNCTION__);
    return 0.f;
}


/**
 *  设置Section的Footer高度
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Section的Footer高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    NSLog(@"SectionFooter高度%s",__FUNCTION__);
    return 0.f;
}


/**
 *  设置Section的Header
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Section的View
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    NSLog(@"HeaderView定制%s",__FUNCTION__);
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}



/**
 *  设置Section的Footer
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Section的View
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //    NSLog(@"FooterView定制%s",__FUNCTION__);
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}


/**
 *  设置Row的高度
 *
 *  @param tableView self.tableView
 *  @param indexPath indexPath
 *
 *  @return Row的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"Row高度%s",__FUNCTION__);
    return 0;
}


/**
 *  设置TableView的Cell
 *
 *  @param tableView self.tableView
 *  @param indexPath indexPath
 *
 *  @return TableView的Cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"填充Cell%s",__FUNCTION__);
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}


/**
 *  点击TableViewCell事件
 *
 *  @param tableView self.tableView
 *  @param indexPath indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"点击Cell%s",__FUNCTION__);
}



#pragma mark ------MJRefresh------
/**
 *  下拉刷新
 */
- (void)tableViewHeadRefresh
{
    //    NSLog(@"下拉刷新%s",__FUNCTION__);
}


/**
 *  上拉加载
 */
- (void)tableViewFootRefresh
{
    //    NSLog(@"上拉加载%s",__FUNCTION__);
}



#pragma mark ------MBProgressHUD------

/**
 *  普通Hud
 */
- (void)showBaseHud
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    hud.contentColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
}


/**
 *  成功Hud
 *
 *  @param successTitle 标题可为空，默认Success
 */
- (void)showSuccessHudWithSuccessTitle:(NSString *)successTitle
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = successTitle ? successTitle : @"Success";
    hud.label.numberOfLines = 0;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    hud.contentColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
}

/**
 *  错误Hud
 *
 *  @param errorTitle 标题可为空，默认Error
 */
- (void)showErrorHudWithErrorTitle:(NSString *)errorTitle
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = errorTitle ? errorTitle : @"Error";
    hud.label.numberOfLines = 0;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:ECIMAGENAME(@"hud_error")];
    hud.bezelView.color = ECCOLOR(0, 0, 0, .8f);
    hud.contentColor = ECCOLOR(255, 255, 255, 1.f);
}

/**
 *  警告Hud
 *
 *  @param warningTitle 标题可为空，默认Warning
 */
- (void)showWarningHudWithWarningTitle:(NSString *)warningTitle
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = warningTitle ? warningTitle : @"Warning";
    hud.label.numberOfLines = 0;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:ECIMAGENAME(@"hud_warning")];
    hud.bezelView.color = ECCOLOR(0, 0, 0, .8f);
    hud.contentColor = ECCOLOR(255, 255, 255, 1.f);
}

/**
 *  提示Hud
 *
 *  @param infoTitle 标题可为空，默认Info
 */
- (void)showInfoHudWithInfoTitle:(NSString *)infoTitle
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = infoTitle ? infoTitle : @"Info";
    hud.label.numberOfLines = 0;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:ECIMAGENAME(@"hud_info")];
    hud.bezelView.color = ECCOLOR(0, 0, 0, .8f);
    hud.contentColor = ECCOLOR(255, 255, 255, 1.f);
}

/**
 *  普通Hud带文本
 *
 *  @param title 标题不可为空
 */
- (void)showBaseHudWithTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    // Set the label text.
    hud.label.text = title;
    hud.label.numberOfLines = 0;
    hud.bezelView.color = ECCOLOR(0, 0, 0, .8f);
    hud.contentColor = ECCOLOR(255, 255, 255, 1.f);
}

/**
 *  安卓Toast
 *
 *  @param title 标题不可为空
 */
- (void)showToastHudWithTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.bezelView.color = ECCOLOR(0, 0, 0, .8f);
    hud.contentColor = ECCOLOR(255, 255, 255, 1.f);
    
    [hud hideAnimated:YES afterDelay:1.5f];
}

/**
 *  Hud消失
 */
- (void)dismissHud
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
    [hud hideAnimated:YES];
}

/**
 *  Hud延迟消失
 *
 *  @param afterSecond 延迟时间
 */
- (void)dismissHudAfter:(NSTimeInterval)afterSecond
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
        [hud hideAnimated:YES afterDelay:afterSecond];
    });
}

/**
 *  成功Hud延迟消失
 *
 *  @param successTitle 标题可为空，默认Success
 *  @param afterSecond  延迟时间
 */
- (void)dismissHudWithSuccessTitle:(NSString *)successTitle After:(NSTimeInterval)afterSecond
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
        hud.label.text = successTitle ? successTitle : @"Success";
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:ECIMAGENAME(@"hud_success")];
        [hud hideAnimated:YES afterDelay:afterSecond];
    });
    
}


/**
 *  错误Hud延迟消失
 *
 *  @param errorTitle  标题可为空，默认Error
 *  @param afterSecond 延迟时间
 */
- (void)dismissHudWithErrorTitle:(NSString *)errorTitle After:(NSTimeInterval)afterSecond
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
        hud.label.text = errorTitle ? errorTitle : @"Error";
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:ECIMAGENAME(@"hud_error")];
        [hud hideAnimated:YES afterDelay:afterSecond];
    });
    
}


/**
 *  警告Hud延迟消失
 *
 *  @param warningTitle 标题可为空，默认Warning
 *  @param afterSecond  延迟时间
 */
- (void)dismissHudWithWarningTitle:(NSString *)warningTitle After:(NSTimeInterval)afterSecond
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
        hud.label.text = warningTitle ? warningTitle : @"Warning";
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:ECIMAGENAME(@"hud_warning")];
        [hud hideAnimated:YES afterDelay:afterSecond];
    });
    
}


/**
 *  提示Hud延迟消失
 *
 *  @param infoTitle   标题可为空，默认Info
 *  @param afterSecond 延迟时间
 */
- (void)dismissHudWithInfoTitle:(NSString *)infoTitle After:(NSTimeInterval)afterSecond
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
        hud.label.text = infoTitle ? infoTitle : @"Info";
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:ECIMAGENAME(@"hud_info")];
        [hud hideAnimated:YES afterDelay:afterSecond];
    });
    
}


/**UIAleterController
 *
 */
-(void)initAletrControllerTille:(NSString*)title message:(NSString*)message alertStyle:(UIAlertControllerStyle)style{
    _alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
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
