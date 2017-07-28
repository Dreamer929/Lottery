//
//  ForumLunTableViewCell.h
//  LuckProject
//
//  Created by moxi on 2017/7/19.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumLunTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;

@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@end
