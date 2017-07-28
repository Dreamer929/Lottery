//
//  UserAccountApi.m
//  LuckProject
//
//  Created by moxi on 2017/7/17.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "UserAccountApi.h"


@implementation UserAccountApi

+(void)accountRegister:(UserRegosterParameter *)parameter block:(void (^)(UserRegosterResponse*reponse,NSString *errorMessage))block{
    
    NSString *url = @"user/register.do";
    
    NSDictionary *parameters = @{
                                 @"phoneNumber":parameter.phoneNumber,
                                 @"code":parameter.code,
                                 @"codeTime":parameter.codeTime,
                                 @"username":parameter.username,
                                 @"password":parameter.password
                                 };
    
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:parameters success:^(id responseObject) {
        
        if ([responseObject[@"errorcode"]isEqualToString:@"0"]) {
            
            UserRegosterResponse *response = [MTLJSONAdapter modelOfClass:[UserRegosterResponse class] fromJSONDictionary:responseObject[@"result"] error:nil];
            block(response,responseObject[@"error"]);
        }else{
            block(nil,responseObject[@"error"]);
        }
        
        
        
    } failure:^(NSError *error) {
        block(nil,@"请检查网络");
    }];
}


+ (void)accountMessage:(MessageMessageParameter*)parameter block:(void(^)(MessageResponse*response,NSString *errorMessage))block{
    
    NSString *url = @"user/sendCode.do";
    
    NSDictionary *parameters = @{
                                 @"phoneNumber":parameter.phoneNumber
                                 };
    
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:parameters success:^(id responseObject) {
        
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
          
            MessageResponse *responses = [MTLJSONAdapter modelOfClass:[MessageResponse class] fromJSONDictionary:responseObject[@"result"] error:nil];
            
            block(responses,responseObject[@"error"]);
            
        }else{
            block(nil,responseObject[@"error"]);
        }
        
        
        
    } failure:^(NSError *error) {
        block(nil,@"请检查网络");
    }];
}

+(void)accountLogin:(LoginParameter *)parameter block:(void (^)(LoginResponse*response,NSString *errorMessage))block{
    
    MXAppConfig *config = [MXAppConfig shareInstance];
    
    NSString *url = @"user/login.do";
    NSDictionary *dic = @{
                          @"phoneNumber":parameter.phoneNumber,
                          @"password":parameter.password
                          };
    
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            
            LoginResponse *responses = [MTLJSONAdapter modelOfClass:[LoginResponse class] fromJSONDictionary:responseObject[@"result"] error:nil];
            
            [config saveLoginResponse:responses];
            
            block(responses,responseObject[@"error"]);
            
        }else{
            block(nil,responseObject[@"error"]);
        }
        
    } failure:^(NSError *error) {
 
        block(nil,@"请检查网络");
        
    }];
    
}

+ (void)accountForgetPwd:(UserRegosterParameter*)parameter block:(void(^)(NSString *errorcode,NSString *errorMsg))block{
    
    NSString *url = @"user/forgetPwd.do";
    NSDictionary *dic = @{
                          @"phoneNumber":parameter.phoneNumber,
                          @"password":parameter.password,
                          @"code":parameter.code,
                          @"codeTime":parameter.codeTime
                          };
    
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        
        block(responseObject[@"errorcode"],responseObject[@"error"]);
        
    } failure:^(NSError *error) {
        
        block(@"请检查网络",@"");
    }];
}

+(void)accountSignOut:(NSString *)userId block:(void (^)(NSString *code,NSString*errorMsg))block{
    
    MXAppConfig *config = [MXAppConfig shareInstance];
    
    NSString *url = @"user/logoutById.do";
    
    NSDictionary *dic = @{
                          @"userId":userId
                          };
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            
            [config reset];
            block(responseObject[@"errorcode"],responseObject[@"error"]);
        }else{
            block(responseObject[@"errorcode"],responseObject[@"error"]);
        }
        
    } failure:^(NSError *error) {
        block(nil,@"请检查网络");

    }];
}

+ (void)accountGetForum:(ForumParameter *)parameter block:(void (^)(NSMutableArray* responseArr,NSString *errorMsg))blcok{
    
    NSString *url = @"forum/forumList.do";
    NSDictionary *dic = @{
                          @"pageNo":parameter.pageNo,
                          @"pageSize":parameter.pageSize,
                          @"userId":parameter.userId
                          };
    
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        
        NSMutableArray *arr = [NSMutableArray array];
        
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            
            for (NSDictionary *dic in responseObject[@"result"]) {
               ForumResponse *response = [MTLJSONAdapter modelOfClass:[ForumResponse class] fromJSONDictionary:dic error:nil];
                
                [arr addObject:response];
            }
            
            blcok(arr,responseObject[@"error"]);
        }else{
            
            blcok(nil,responseObject[@"error"]);
        }
        
    } failure:^(NSError *error) {
        blcok(nil,@"请检查网络");
    }];
}

+(void)accountGetForumDetial:(ForumDetialParameter *)parameter blcok:(void (^)(NSMutableArray* responseArr,NSString *errorMsg))blcok{
    
    NSString *url = @"forum/forumsDetail.do";
    NSDictionary *dic = @{
                          @"forumId":parameter.forumId,
                          @"userId":parameter.userId,
                          @"token":parameter.token
                          };
    
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        
        NSMutableArray *arr = [NSMutableArray array];
        
         if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
        
        for (NSDictionary *dic in responseObject[@"discussList"]) {
            
            ForumDetialResponse *response = [MTLJSONAdapter modelOfClass:[ForumDetialResponse class] fromJSONDictionary:dic error:nil];;
            [arr addObject:response];
          }
             blcok(arr,responseObject[@"error"]);
         }else{
             
             blcok(nil,responseObject[@"error"]);

         }
        
    } failure:^(NSError *error) {
        blcok(nil,@"请检查网络");

    }];
    
}

+ (void)accountZanForum:(NSDictionary *)dic block:(void (^)(ForumZanResponse *response,NSString *errorMsg,NSString *errorcode))block{
    
    NSString *url = @"forum/saveForumThumbs.do";
    
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"errorcode"]isEqualToString:@"0"]) {
            
            ForumZanResponse *response = [MTLJSONAdapter modelOfClass:[ForumZanResponse class] fromJSONDictionary:responseObject[@"result"] error:nil];
            block(response,responseObject[@"error"],responseObject[@"errorcode"]);
            
        }else{
            block(nil,responseObject[@"error"],responseObject[@"errorcode"]);
        }
        
    } failure:^(NSError *error) {
        
        block(nil,@"请检查网络",nil);
    }];
}

+(void)accountLunForum:(ForumLunParameter*)parameter block:(void(^)(ForumLunResponse *response,NSString *errorMsg,NSString *code))block{
    
    NSString *url = @"forum/addForumDiscuss.do";
    NSDictionary *dic = @{
                          @"forumId":parameter.forumId,
                          @"content":parameter.content,
                          @"userId":parameter.userId
                          };
    
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        
        
        if ([responseObject[@"errorcode"]isEqualToString:@"0"]) {
            
            ForumLunResponse *response = [MTLJSONAdapter modelOfClass:[ForumLunResponse class] fromJSONDictionary:responseObject[@"result"] error:nil];
            block(response,responseObject[@"error"],responseObject[@"errorcode"]);
            
        }else{
            block(nil,responseObject[@"error"],responseObject[@"errorcode"]);
        }
        
    } failure:^(NSError *error) {
        block(nil,@"请检查网络",nil);
    }];
}

+(void)accountQiandao:(NSString*)userId block:(void(^)(QiandaoResponse *response, NSString *errorcode,NSString *errorMsg))block{
    
    NSString *url = @"user/userSign.do";
    NSDictionary *dic = @{
                          @"userId":userId
                          };
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        if ([responseObject[@"errorcode"]isEqualToString:@"0"]) {
            
            QiandaoResponse *resposne = [MTLJSONAdapter modelOfClass:[QiandaoResponse class] fromJSONDictionary:responseObject[@"result"] error:nil];
            [[MXAppConfig shareInstance]saveQiandaoResonse:resposne];
            block(resposne,responseObject[@"errorcode"],responseObject[@"error"]);
            
        }else{
           block(nil,responseObject[@"errprcode"],responseObject[@"error"]);
        }
        
    } failure:^(NSError *error) {
        
        block(nil,nil,@"请检查网络");
    }];
}


+(void)accountGrateDetial:(NSString *)userId blcok:(void (^)(NSMutableArray* response,NSString *errorcode,NSString *errorMsg))block{
    
    NSString *url = @"user/showCoreDetail.do";
    NSDictionary *dic = @{
                          @"userId":userId
                          };
    
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
     
        NSMutableArray *arr = [NSMutableArray array];
        
        if ([responseObject[@"errorcode"]isEqualToString:@"0"]) {
            
            for (NSDictionary *dic in responseObject[@"result"]) {
             GradeDetialResponse *resposne = [MTLJSONAdapter modelOfClass:[GradeDetialResponse class] fromJSONDictionary:dic error:nil];
                
                [arr addObject:resposne];
            }
            
            block(arr,responseObject[@"errorcode"],responseObject[@"error"]);
            
        }else{
            block(nil,responseObject[@"errprcode"],responseObject[@"error"]);
        }
    
    } failure:^(NSError *error) {
       
          block(nil,nil,@"请检查网络");
    }];
}

+(void)accountInforation:(InformationParamter*)paraneter block:(void(^)(NSMutableArray* responses,NSString *errorcode,NSString *erorMsg))block{
    NSDictionary *dic = @{
                      @"pageNo":paraneter.pageNo,
                      @"pageSize":@"30",
                      @"typeId":paraneter.typeId
                      };
    NSString *url = @"news/newsList.do";

    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
       
        NSMutableArray *arr = [NSMutableArray array];

        if ([responseObject[@"errorcode"]isEqualToString:@"0"]) {
            
            for (NSDictionary *dic in responseObject[@"result"]) {
                InformationResponse *resposne = [MTLJSONAdapter modelOfClass:[InformationResponse class] fromJSONDictionary:dic error:nil];
                
                [arr addObject:resposne];
            }
            
            block(arr,responseObject[@"errorcode"],responseObject[@"error"]);
            
        }else{
            block(nil,responseObject[@"errorcode"],responseObject[@"error"]);
        }
        
    } failure:^(NSError *error) {
       
        block(nil,nil,@"请检查网络");
        
    }];
}


+(void)accountBuyLotty:(BuyLottyParameter*)parametr block:(void(^)(NSString *errorcode,NSString*error))block{
    
    NSString *url = @"lottery/saveOrder.do";
    NSDictionary *dic = @{
                          @"userId":parametr.userId,
                          @"lotteryType":parametr.lotteryType,
                          @"qihao":parametr.qihao,
                          @"lotteryNo":parametr.lotteryNo,
                          @"lotteryBets":parametr.lotteryBets
                          };
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        
        block(responseObject[@"errorcode"],responseObject[@"error"]);
        
    } failure:^(NSError *error) {
        block(nil,@"请检查网络");

    }];
    
}

+(void)accountBandInformation:(BandInformationParameter*)parameter blcok:(void(^)(NSString*errorcode,NSString *error))blcok{
    
    NSString *url = @"user/bandRealInfo.do";
    NSDictionary *dic = @{
                          @"phoneNumber":parameter.phoneNumber,
                          @"realName":parameter.realName,
                          @"idCard":parameter.idCard
                          };
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            
            BandinformationResponse *response = [MTLJSONAdapter modelOfClass:[BandinformationResponse class] fromJSONDictionary:responseObject[@"result"] error:nil];
            
            [[MXAppConfig shareInstance]saveBandInformation:response];
    
        }
        blcok(responseObject[@"errorcode"],responseObject[@"error"]);
        
    } failure:^(NSError *error) {
        blcok(nil,@"请检查网络");

    }];
}

+(void)accountBuyLottyHistory:(BuyLottyHistoryParameter*)parameter block:(void(^)(NSMutableArray *responses,NSString *errorcode,NSString*error))block{
    
    NSString *url = @"user/findUserBuyInfo.do";
    NSDictionary *dic = @{
                          @"userId":[NSString stringWithFormat:@"%ld",[MXAppConfig shareInstance].userId],
                          @"typeId":parameter.typeId
                          };
    [MXHttpRequestManger POST:[MXBASE_URL stringByAppendingString:url] parameters:dic success:^(id responseObject) {
        NSMutableArray *arr = [NSMutableArray array];
        
        if ([responseObject[@"errorcode"]isEqualToString:@"0"]) {
            
            for (NSDictionary *dic in responseObject[@"result"]) {
                
                BuyLottyHistoryResponse *resposne = [MTLJSONAdapter modelOfClass:[BuyLottyHistoryResponse class] fromJSONDictionary:dic error:nil];
                
                [arr addObject:resposne];
            }
            
            block(arr,responseObject[@"errorcode"],responseObject[@"error"]);
        }else{
            block(nil,responseObject[@"errorcode"],responseObject[@"error"]);
  
        }
        
    } failure:^(NSError *error) {
        block(nil,nil,@"请检查网络");

    }];
}

@end
