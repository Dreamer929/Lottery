//
//  MXAppConfig.m
//  LuckProject
//
//  Created by moxi on 2017/7/24.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MXAppConfig.h"

@implementation MXAppConfig

NSString *const ISLOGIN_KEY = @"isLogin_key";
NSString *const USERID_KEY = @"userid_key";
NSString *const USERNAME_KEY = @"username_key";
NSString *const TOKEN_KEY  = @"token_key";
NSString *const GRADE_KEY = @"score_key";
NSString *const ISBINDING_KEY = @"isBinding_key";
NSString *const LEVELFIG_KEY = @"levefFlag_key";
NSString *const ISSIGN_KEY = @"isSign_key";
NSString *const HEADIMAGE_KEY = @"headview_key";
NSString *const REALNAME_KEY = @"realname_key";
NSString *const NUMBER_KEY = @"phone_key";
NSString *const IDNUM_KEY = @"idcard_key";

+(instancetype)shareInstance{
    
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[MXAppConfig alloc]init];
    });
    
    [shareInstance loadUserInfo];
    return shareInstance;
}

-(void)loadUserInfo{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:ISLOGIN_KEY] != nil) {
        self.isLogin = [defaults boolForKey:ISLOGIN_KEY];
    }else{
        self.isLogin = NO;
    }
    
    if ([defaults objectForKey:USERID_KEY] != nil) {
        self.userId = [defaults integerForKey:USERID_KEY];
    }else{
        self.userId = 0;
    }
    if ([defaults objectForKey:USERNAME_KEY]!= nil) {
        self.username = [defaults objectForKey:USERNAME_KEY];
    }else{
        self.username = @"";
    }
    if ([defaults objectForKey:TOKEN_KEY]!= nil) {
        self.token = [defaults objectForKey:TOKEN_KEY];
    }else{
        self.token = @"";
    }
    if ([defaults objectForKey:GRADE_KEY] != nil) {
        self.score = [defaults integerForKey:GRADE_KEY];
    }else{
        self.score = 0;
    }
    
    if ([defaults objectForKey:ISBINDING_KEY]!= nil) {
        self.isBinding = [defaults integerForKey:ISBINDING_KEY];
    }else{
        self.isBinding = 0;
    }
    if ([defaults objectForKey:LEVELFIG_KEY]!= nil) {
        self.levelFlag = [defaults integerForKey:LEVELFIG_KEY];
    }else{
        self.levelFlag = 0;
    }
    if ([defaults objectForKey:ISSIGN_KEY]!= nil) {
        self.isSign = [defaults integerForKey:ISSIGN_KEY];
    }else{
        self.isSign = 0;
    }
    
    if ([defaults objectForKey:HEADIMAGE_KEY] != nil) {
        self.imgPath = [defaults objectForKey:HEADIMAGE_KEY];
    }else{
        self.imgPath = @"";
    }
    if ([defaults objectForKey:REALNAME_KEY]!= nil) {
        self.userRealName = [defaults objectForKey:REALNAME_KEY];
    }else{
        self.userRealName = @"";
    }
    if ([defaults objectForKey:IDNUM_KEY] != nil) {
        self.userIdCard = [defaults objectForKey:IDNUM_KEY];
    }else{
        self.userIdCard = @"";
    }
    if ([defaults objectForKey:NUMBER_KEY]!= nil) {
        self.phoneNumber = [defaults objectForKey:NUMBER_KEY];
    }else{
        self.phoneNumber = @"";
    }
}


-(void)saveUserInfo{
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    
    [defauls setBool:self.isLogin forKey:ISLOGIN_KEY];
    [defauls setInteger:self.score forKey:GRADE_KEY];
    [defauls setInteger:self.levelFlag forKey:LEVELFIG_KEY];
    [defauls setInteger:self.isBinding forKey:ISBINDING_KEY];
    [defauls setInteger:self.userId forKey:USERID_KEY];
    [defauls setObject:self.username forKey:USERNAME_KEY];
    [defauls setObject:self.token forKey:TOKEN_KEY];
    [defauls setInteger:self.isSign forKey:ISSIGN_KEY];
    [defauls setObject:self.imgPath forKey:HEADIMAGE_KEY];
    [defauls setObject:self.userIdCard forKey:IDNUM_KEY];
    [defauls setObject:self.userRealName forKey:REALNAME_KEY];
    [defauls setObject:self.phoneNumber forKey:NUMBER_KEY];
    
    [defauls synchronize];
    
}

-(void)reset{
    
    self.isLogin = NO;
    self.username = @"";
    self.userId = 0;
    self.isBinding = 0;
    self.score = 0;
    self.levelFlag = 0;
    self.token = @"";
    self.isSign = 0;
    self.imgPath = nil;
    
    [self saveUserInfo];
}

-(void)saveBandInformation:(BandinformationResponse *)response{
    
    self.isSign = [response.isBanding integerValue];
    self.userRealName = response.userRealName;
    self.phoneNumber = response.phoneNumber;
    self.userIdCard = response.userIdCard;
    
    [self saveUserInfo];
}

-(void)saveRegisterResponse:(UserRegosterResponse *)response{
    
    self.isLogin = YES;
    self.username = response.username;
    self.userId = response.userId;
    self.token = response.token;
    self.score = response.score;
    self.isSign = 0;
    
    [self saveUserInfo];
}

-(void)saveQiandaoResonse:(QiandaoResponse *)response{
    
    self.isSign = 1;
    self.score = response.score;
    [self saveUserInfo];
}

-(void)saveLoginResponse:(LoginResponse *)response{
    
    self.isLogin = YES;
    self.username = response.username;
    self.userId = response.userId;
    self.token = response.token;
    self.score = response.score;
    self.isSign = response.isSign;
    self.isBinding = response.isBinding;
    self.imgPath = response.imgPath;
    self.userRealName = response.userRealName;
    self.userIdCard = response.userIdCard;
    self.phoneNumber = response.phoneNumber;
    
    [self saveUserInfo];
}



@end
