//
//  InformationTableViewCell.h
//  LuckProject
//
//  Created by moxi on 2017/7/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *readLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;


@end
