//
//  DreamerDefine.h
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#ifndef DreamerDefine_h
#define DreamerDefine_h



#define ECIMAGENAME(_name_) [UIImage imageNamed:_name_]

#define ECCOLOR(r, g, b, a)             [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define DREAMSCREEN          [[UIScreen mainScreen] bounds]
#define DREAMCSCREEN_W        [[UIScreen mainScreen]bounds].size.width
#define DREAMCSCREEN_H        [[UIScreen mainScreen]bounds].size.height



/**
 *  计算文本行高
 *
 *  @param _width_  文本宽
 *  @param _string_ 文本内容
 *  @param _fsize_  文本字体
 *
 *  @return 文本尺寸
 */
#define STRING_SIZE(_width_, _string_, _fsize_) [_string_ boundingRectWithSize:CGSizeMake(_width_, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_fsize_]} context:nil].size;


/**
 *  计算富文本行高
 *
 *  @param _string_ 富文本内容
 *  @param _width_  富文本宽
 *
 *  @return 富文本尺寸
 */
#define ATTRIBUTEDSTRING_SIZE(_string_, _width_) [_string_ boundingRectWithSize:CGSizeMake(_width_, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil]


/**
 *  导入头文件
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "Masonry.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "YYCache.h"


#import "RootViewController.h"
#import "BaseViewController.h"
#import "MineViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "UserRegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "LottyCircleViewController.h"
#import "LottyCircleDetileViewController.h"
#import "GradeDetialViewController.h"

#import "UserRegosterResponse.h"
#import "UserRegosterParameter.h"
#import "LoginResponse.h"
#import "LoginParameter.h"
#import "QiandaoResponse.h"
#import "ForumResponse.h"
#import "ForumParameter.h"
#import "ForumLunResponse.h"
#import "ForumLunParameter.h"
#import "ForumZanResponse.h"
#import "ForumDetialResponse.h"
#import "ForumDetialParameter.h"
#import "GradeDetialResponse.h"
#import "MessageResponse.h"
#import "MessageMessageParameter.h"
#import "GradeDetialResponse.h"
#import "InformationParamter.h"
#import "InformationResponse.h"
#import "HistoryLotteryModel.h"
#import "BuyLottyParameter.h"
#import "BuyLottyHistoryParameter.h"
#import "BuyLottyHistoryResponse.h"




#import "MXHttpRequestCache.h"
#import "MXHttpRequestUrl.h"
#import "MXHttpRequestManger.h"
#import "MXAppConfig.h"


#import "ECScrollView.h"

#import "RootModel.h"
#import "MXPopView.h"
#import "MXDatePickView.h"



#import "UserAccountApi.h"


#import "UIButton+MSButton.h"
#import "NSString+GetCutttenDate.h"



#endif /* DreamerDefine_h */
