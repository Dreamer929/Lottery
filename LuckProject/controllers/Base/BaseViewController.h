//
//  BaseViewController.h
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BaseViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;           //tableView

@property (nonatomic, strong) UIAlertController *alert;                 //弹框


#pragma mark ------TableView------
/**
 *  初始化TableView
 *
 *  @param frame  TableView的坐标
 *  @param isHead 是否需要下拉刷新
 *  @param isFoot 是否需要上拉加载
 *  @param isShow 是否显示滚动条
 */
- (void)initTableViewWithFrame:(CGRect)frame WithHeadRefresh:(BOOL)isHead WithFootRefresh:(BOOL)isFoot WithScrollIndicator:(BOOL)isShow;

/**
 *  设置TableView的Section
 *
 *  @param tableView self.tableView
 *
 *  @return Section数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

/**
 *  设置Section中的Row
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Row数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 *  设置Section的Header高度
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Section的Header高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;


/**
 *  设置Section的Footer高度
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Section的Footer高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;



/**
 *  设置Section的Header
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Section的View
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;


/**
 *  设置Section的Footer
 *
 *  @param tableView self.tableView
 *  @param section   section
 *
 *  @return Section的View
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;


/**
 *  设置Row的高度
 *
 *  @param tableView self.tableView
 *  @param indexPath indexPath
 *
 *  @return Row的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  设置TableView的Cell
 *
 *  @param tableView self.tableView
 *  @param indexPath indexPath
 *
 *  @return TableView的Cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  点击TableViewCell事件
 *
 *  @param tableView self.tableView
 *  @param indexPath indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


#pragma mark ------MJRefresh------
/**
 *  下拉刷新
 */
- (void)tableViewHeadRefresh;

/**
 *  上拉加载
 */
- (void)tableViewFootRefresh;



#pragma mark ------MBProgressHUD------

/**
 *  普通Hud
 */
- (void)showBaseHud;

/**
 *  成功Hud
 *
 *  @param successTitle 标题可为空，默认Success
 */
- (void)showSuccessHudWithSuccessTitle:(NSString *)successTitle;

/**
 *  错误Hud
 *
 *  @param errorTitle 标题可为空，默认Error
 */
- (void)showErrorHudWithErrorTitle:(NSString *)errorTitle;

/**
 *  警告Hud
 *
 *  @param warningTitle 标题可为空，默认Warning
 */
- (void)showWarningHudWithWarningTitle:(NSString *)warningTitle;

/**
 *  提示Hud
 *
 *  @param infoTitle 标题可为空，默认Info
 */
- (void)showInfoHudWithInfoTitle:(NSString *)infoTitle;

/**
 *  普通Hud带文本
 *
 *  @param title 标题不可为空
 */
- (void)showBaseHudWithTitle:(NSString *)title;

/**
 *  安卓Toast
 *
 *  @param title 标题不可为空
 */
- (void)showToastHudWithTitle:(NSString *)title;


/**
 *  Hud消失
 */
- (void)dismissHud;

/**
 *  Hud延迟消失
 *
 *  @param afterSecond 延迟时间
 */
- (void)dismissHudAfter:(NSTimeInterval)afterSecond;

/**
 *  成功Hud延迟消失
 *
 *  @param successTitle 标题可为空，默认Success
 *  @param afterSecond  延迟时间
 */
- (void)dismissHudWithSuccessTitle:(NSString *)successTitle After:(NSTimeInterval)afterSecond;

/**
 *  错误Hud延迟消失
 *
 *  @param errorTitle  标题可为空，默认Error
 *  @param afterSecond 延迟时间
 */
- (void)dismissHudWithErrorTitle:(NSString *)errorTitle After:(NSTimeInterval)afterSecond;

/**
 *  警告Hud延迟消失
 *
 *  @param warningTitle 标题可为空，默认Warning
 *  @param afterSecond  延迟时间
 */
- (void)dismissHudWithWarningTitle:(NSString *)warningTitle After:(NSTimeInterval)afterSecond;


/**
 *  提示Hud延迟消失
 *
 *  @param infoTitle   标题可为空，默认Info
 *  @param afterSecond 延迟时间
 */
- (void)dismissHudWithInfoTitle:(NSString *)infoTitle After:(NSTimeInterval)afterSecond;


/**
 *  弹框
 *
 *
 *
 */
-(void)initAletrControllerTille:(NSString*)title message:(NSString*)message alertStyle:(UIAlertControllerStyle)style;

@end
