//
//  BuyLottyHistoryResponse.h
//  LuckProject
//
//  Created by moxi on 2017/7/27.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BuyLottyHistoryResponse : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy)NSString *lotteryTypeName;
@property (nonatomic, copy)NSString *lotteryNo;
@property (nonatomic, copy)NSString *orderCode;
@property (nonatomic, copy)NSString *lotteryType;
@property (nonatomic, copy)NSString *qihao;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, assign)NSInteger orderPrice;
@property (nonatomic, assign)NSInteger lotteryBets;
@property (nonatomic, assign)NSInteger totalAmt;

@end
