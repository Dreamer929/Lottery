//
//  ForumTableViewCell.h
//  LuckProject
//
//  Created by moxi on 2017/7/18.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userheadView;
@property (weak, nonatomic) IBOutlet UILabel *userNickLable;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;

@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@property (weak, nonatomic) IBOutlet UIImageView *zanImage;
@property (weak, nonatomic) IBOutlet UILabel *zanLable;


@end
