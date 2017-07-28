//
//  NSString+GetCutttenDate.m
//  LuckProject
//
//  Created by moxi on 2017/7/13.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "NSString+GetCutttenDate.h"

@implementation NSString (GetCutttenDate)


+(NSString*)currtenDate{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    NSString *locationString=[formatter stringFromDate:date];
    
    return locationString;
}

@end
