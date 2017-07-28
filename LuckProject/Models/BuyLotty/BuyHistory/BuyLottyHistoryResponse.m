//
//  BuyLottyHistoryResponse.m
//  LuckProject
//
//  Created by moxi on 2017/7/27.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "BuyLottyHistoryResponse.h"

@implementation BuyLottyHistoryResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"lotteryTypeName":@"lotteryTypeName",
             @"lotteryNo":@"lotteryNo",
             @"orderCode":@"orderCode",
             @"lotteryType":@"lotteryType",
             @"orderPrice":@"orderPrice",
             @"lotteryBets":@"lotteryBets",
             @"totalAmt":@"totalAmt",
             @"qihao":@"qihao",
             @"createTime":@"createTime"
             };
}

@end
