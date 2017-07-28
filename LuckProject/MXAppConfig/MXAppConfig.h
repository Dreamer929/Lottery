//
//  MXAppConfig.h
//  LuckProject
//
//  Created by moxi on 2017/7/24.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BandinformationResponse.h"

@interface MXAppConfig : NSObject

extern NSString *const ISLOGIN_KEY;
extern NSString *const USERID_KEY;
extern NSString *const USERNAME_KEY;
extern NSString *const TOKEN_KEY;
extern NSString *const GRADE_KEY;
extern NSString *const ISBINDING_KEY;
extern NSString *const LEVELFIG_KEY;
extern NSString *const ISSIGN_KEY;
extern NSString *const HEADIMAGE_KEY;
extern NSString *const REALNAME_KEY;
extern NSString *const NUMBER_KEY;
extern NSString *const IDNUM_KEY;


@property (nonatomic, assign)BOOL isLogin;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign)NSInteger score;
@property (nonatomic, assign)NSInteger isBinding;
@property (nonatomic, assign)NSInteger levelFlag;
@property (nonatomic, assign)NSInteger isSign;
@property (nonatomic, copy)NSString *imgPath;

@property (nonatomic, copy)NSString *phoneNumber;
@property (nonatomic, copy)NSString *userIdCard;
@property (nonatomic, copy)NSString *userRealName;


+(instancetype)shareInstance;

-(void)saveRegisterResponse:(UserRegosterResponse*)response;
- (void)saveLoginResponse:(LoginResponse*)response;
- (void)saveQiandaoResonse:(QiandaoResponse*)response;
- (void)saveBandInformation:(BandinformationResponse *)response;

-(void)saveUserInfo;
-(void)loadUserInfo;

-(void)reset;

@end
