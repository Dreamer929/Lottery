//
//  GradeDetailTableViewCell.h
//  LuckProject
//
//  Created by moxi on 2017/7/24.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *styleLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UIImageView *stylImage;
@property (weak, nonatomic) IBOutlet UILabel *gradeLable;


@end
