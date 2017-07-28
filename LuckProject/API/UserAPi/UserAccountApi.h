//
//  UserAccountApi.h
//  LuckProject
//
//  Created by moxi on 2017/7/17.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BandInformationParameter.h"
#import "BandinformationResponse.h"




@interface UserAccountApi : NSObject

+ (void)accountMessage:(MessageMessageParameter*)parameter block:(void(^)(MessageResponse*response,NSString *errorMessage))block;

+ (void)accountRegister:(UserRegosterParameter*)parameter block:(void(^)(UserRegosterResponse*reponse,NSString *errorMessage))block;

+ (void)accountLogin:(LoginParameter*)parameter block:(void(^)(LoginResponse*response,NSString *errorMessage))block;

+ (void)accountSignOut:(NSString*)userId block:(void(^)(NSString *code,NSString*errorMsg))block;

+ (void)accountGetForum:(ForumParameter*)parameter block:(void(^)(NSMutableArray* responseArr,NSString *errorMsg))blcok;

+(void)accountGetForumDetial:(ForumDetialParameter*)parameter blcok:(void(^)(NSMutableArray* responseArr,NSString *errorMsg))blcok;

+(void)accountZanForum:(NSDictionary*)dic block:(void(^)(ForumZanResponse *response,NSString *errorMsg,NSString *errorcode))block;

+(void)accountLunForum:(ForumLunParameter*)parameter block:(void(^)(ForumLunResponse *response,NSString *errorMsg,NSString *code))block;

+ (void)accountForgetPwd:(UserRegosterParameter*)parameter block:(void(^)(NSString *errorcode,NSString *errorMsg))block;

+(void)accountQiandao:(NSString*)userId block:(void(^)(QiandaoResponse *response, NSString *errorcode,NSString *errorMsg))block;

+(void)accountGrateDetial:(NSString*)userId blcok:(void(^)(NSMutableArray* response,NSString *errorcode,NSString *errorMsg))block;

+(void)accountInforation:(InformationParamter*)paraneter block:(void(^)(NSMutableArray* responses,NSString *errorcode,NSString *erorMsg))block;

+(void)accountBuyLotty:(BuyLottyParameter*)parametr block:(void(^)(NSString *errorcode,NSString*error))block;

+(void)accountBandInformation:(BandInformationParameter*)parameter blcok:(void(^)(NSString*errorcode,NSString *error))blcok;

+(void)accountBuyLottyHistory:(BuyLottyHistoryParameter*)parameter block:(void(^)(NSMutableArray *responses,NSString *errorcode,NSString*error))block;

@end
