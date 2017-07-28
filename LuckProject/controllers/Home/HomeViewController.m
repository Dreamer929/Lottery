//
//  HomeViewController.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "HomeViewController.h"

#import "InformationViewController.h"
#import "BirthNumberViewController.h"
#import "DoubleBallViewController.h"
#import "PailieFireViewController.h"
#import "ThreeAndFireViewController.h"
#import "SevenLottyViewController.h"


@interface HomeViewController ()
@property (nonatomic, strong)NSArray *dataSouce;

@property (nonatomic, strong)UIScrollView *baseScrollview;
@property (nonatomic, strong)UIView *lottyBaseView;
@property (nonatomic, strong)MXAppConfig *config;
@property (nonatomic, strong)MXPopView *popView;
@property (nonatomic, strong)UILabel *msgLable;

@property (nonatomic, assign)NSInteger msgCount;

@property (nonatomic, strong)NSMutableArray *responseDatas;


@end

@implementation HomeViewController

-(void)viewDidAppear:(BOOL)animated {
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self netrequest];
    self.dataSouce = [NSMutableArray array];
    self.responseDatas = [NSMutableArray array];
    
    
    //播放第一条并加入Timer设定切换间隔时间
    [self msgChange];
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(msgChange) userInfo:nil repeats:YES];
    
    self.config = [MXAppConfig shareInstance];
    
    self.msgCount = 0;
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -request 

-(void)netrequest{
    
    InformationParamter *parameter = [[InformationParamter alloc]init];
    parameter.pageNo = @"0";
    parameter.typeId = @"5";
    [UserAccountApi accountInforation:parameter block:^(NSMutableArray *responses, NSString *errorcode, NSString *erorMsg) {
        
        if ([errorcode isEqualToString:@"0"]) {
            
            [self.responseDatas addObjectsFromArray:responses];
            
        }else{
            
        }
    }];
}

#pragma mark tableview



-(void)createUI{
    
    self.baseScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H)];
    self.baseScrollview.backgroundColor = ECCOLOR(230, 230, 230, 1);
    self.baseScrollview.contentSize = CGSizeMake(DREAMCSCREEN_W, 470 + DREAMCSCREEN_W);
    self.baseScrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.baseScrollview];
    
    NSArray *urls = @[ @"http://img1.cache.netease.com/catchpic/E/E4/E456212AD4592FCD4D00753140419985.jpg",
                       @"http://www.zhcw.com/upload/Image/xinwen5/25350747466.jpg",
                       @"https://www.h1055.com/app_image/7.jpg",
                       @"https://www.h1055.com/app_news/17.jpg",
                       @"http://p18.qhimg.com/t01be65a85d13ddd2c9.png"];
    
    ECScrollView *guangGaoView = [[ECScrollView alloc]initWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, 180) imageURLs:urls];
    [self.baseScrollview addSubview:guangGaoView];
    
    
    UIView *baseView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 190, DREAMCSCREEN_W/2 - 5, 80)];
    baseView1.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qiandaoAction)];
    [baseView1 addGestureRecognizer:tap];
    [self.baseScrollview addSubview:baseView1];
    
    UIImageView *qimageView = [[UIImageView alloc]init];
    qimageView.image = ECIMAGENAME(@"qiandao");
    qimageView.userInteractionEnabled = YES;
    [baseView1 addSubview:qimageView];
    
    [qimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView1.mas_centerY);
        make.left.mas_equalTo(baseView1.mas_left).offset(20);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    
    UILabel *qlable = [[UILabel alloc]init];
    qlable.text = @"签   到";
    qlable.userInteractionEnabled = YES;
    qlable.textAlignment = NSTextAlignmentCenter;
    [baseView1 addSubview:qlable];
    
    [qlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView1.mas_centerY);
        make.left.mas_equalTo(baseView1.mas_left);
        make.right.mas_equalTo(baseView1.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    
    UIView *baseView2 = [[UIView alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W/2 + 5, 190, DREAMCSCREEN_W/2 - 5, 80)];
    baseView2.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bithChangetap)];
    [baseView2 addGestureRecognizer:tap1];
    [self.baseScrollview addSubview:baseView2];
    
    UIImageView *cImageView = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"birth")];
    cImageView.userInteractionEnabled = YES;
    [baseView2 addSubview:cImageView];
    
    [cImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView2.mas_centerY);
        make.left.mas_equalTo(baseView2.mas_left).offset(20);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    
    UILabel *clable = [[UILabel alloc]init];
    clable.text = @"生日选号";
    clable.textAlignment = NSTextAlignmentCenter;
    [baseView2 addSubview:clable];
    
    [clable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView2.mas_centerY);
        make.left.mas_equalTo(cImageView.mas_left);
        make.right.mas_equalTo(baseView2.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    UIView *baseView3 = [[UIView alloc]initWithFrame:CGRectMake(5, 280, DREAMCSCREEN_W/2 - 30, 135)];
    baseView3.backgroundColor = [UIColor whiteColor];
    [baseView3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zixunAction)]];
    [self.baseScrollview addSubview:baseView3];
    
    UIImageView *inforImage = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"information")];
    inforImage.userInteractionEnabled = YES;
    [baseView3 addSubview:inforImage];
    
    [inforImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(baseView3);
        make.height.mas_equalTo(64);
        make.width.mas_equalTo(64);
    }];
    
    UILabel *inforLable = [[UILabel alloc]init];
    inforLable.text = @"推荐资讯";
    inforLable.textColor = ECCOLOR(199, 0, 103, 1);
    inforLable.font = [UIFont systemFontOfSize:15];
    inforLable.textAlignment = NSTextAlignmentCenter;
    [baseView3 addSubview:inforLable];
    
    [inforLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(baseView3.mas_centerX);
        make.bottom.mas_equalTo(baseView3.mas_bottom).offset(-5);
        make.left.mas_equalTo(baseView3.mas_left);
        make.right.mas_equalTo(baseView3.mas_right);
    }];
    
    UIView *baseView4 = [[UIView alloc]initWithFrame:CGRectMake(baseView3.frame.size.width + 10, 280, DREAMCSCREEN_W - 15 - baseView3.frame.size.width, 65)];
    baseView4.backgroundColor = [UIColor whiteColor];
    [baseView4 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sportAction:)]];
    [self.baseScrollview addSubview:baseView4];
    
    UIImageView *sportImage = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"sport")];
    sportImage.userInteractionEnabled = YES;
    [baseView4 addSubview:sportImage];
    
    [sportImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView4.mas_centerY);
        make.left.mas_equalTo(baseView4.mas_left).offset(20);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    
    UILabel *sportLable = [[UILabel alloc]init];
    sportLable.text = @"体育竞彩资讯";
    sportLable.textAlignment = NSTextAlignmentCenter;
    sportLable.textColor = ECCOLOR(149, 114, 192, 1);
    sportLable.font = [UIFont systemFontOfSize:14];
    [baseView4 addSubview:sportLable];
    
    [sportLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView4.mas_centerY);
        make.left.mas_equalTo(sportImage.mas_right).offset(5);
        make.right.mas_equalTo(baseView4.mas_right);
    }];
    
    
    UIView *baseView5 = [[UIView alloc]initWithFrame:CGRectMake(baseView3.frame.size.width + 10, 350, DREAMCSCREEN_W - 15 - baseView3.frame.size.width, 65)];
    baseView5.backgroundColor = [UIColor whiteColor];
    [baseView5 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(numberActipn:)]];
    [self.baseScrollview addSubview:baseView5];
    
    UIImageView *numImage = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"number")];
    numImage.userInteractionEnabled = YES;
    [baseView5 addSubview:numImage];
    
    [numImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView5.mas_centerY);
        make.left.mas_equalTo(baseView5.mas_left).offset(20);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(32);
    }];
    
    UILabel *numLable = [[UILabel alloc]init];
    numLable.text = @"数字竞彩资讯";
    numLable.textColor = [UIColor redColor];
    numLable.font = [UIFont systemFontOfSize:14];
    numLable.textAlignment = NSTextAlignmentCenter;
    [baseView5 addSubview:numLable];
    
    [numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView5.mas_centerY);
        make.left.mas_equalTo(numImage.mas_right).offset(5);
        make.right.mas_equalTo(baseView5.mas_right);
    }];
    
    
    UIView *baseView6 = [[UIView alloc]initWithFrame:CGRectMake(0, 425, DREAMCSCREEN_W, 35)];
    baseView6.backgroundColor = [UIColor whiteColor];
    [self.baseScrollview addSubview:baseView6];
    
    UIImageView *messImage = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"message")];
    [baseView6 addSubview:messImage];
    
    [messImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView6.mas_centerY);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    self.msgLable = [[UILabel alloc]init];
    self.msgLable.text = @"快报资讯";
    self.msgLable.font = [UIFont systemFontOfSize:13];
    self.msgLable.textColor = [UIColor redColor];
    [baseView6 addSubview:self.msgLable];
    
    [self.msgLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(baseView6.mas_centerY);
        make.left.mas_equalTo(messImage.mas_right);
        make.right.mas_equalTo(baseView6.mas_right).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    
    
    self.dataSouce = (NSMutableArray*)@[@"双色球",@"大乐透",@"福彩3D",@"排列三",@"排列五",@"七星彩",@"七乐彩",@"",@""];
    
    for (NSInteger index = 0; index<self.dataSouce.count; index++) {
        
        NSInteger paceH = index%3;
        NSInteger paceV = index/3;
        CGFloat viewWidth = DREAMCSCREEN_W/3;
        
        self.lottyBaseView = [[UIView alloc]initWithFrame:CGRectMake(viewWidth*paceH, 470 + paceV*viewWidth, viewWidth, viewWidth)];
        self.lottyBaseView.tag = index;
        [self.lottyBaseView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lottyStyleAction:)]];
        self.lottyBaseView.backgroundColor = [UIColor whiteColor];

        [self.baseScrollview addSubview:self.lottyBaseView];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        NSString *string = [NSString stringWithFormat:@"%ld",(long)index];
        imageView.image = ECIMAGENAME(string);
        [self.lottyBaseView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.lottyBaseView);
            make.width.mas_equalTo(64);
            make.height.mas_equalTo(64);
        }];
        
    }
    
}


#pragma mark -action

-(void)qiandaoAction{
  
    if (self.config.isLogin) {
        
        [self showBaseHud];
        
        if ([MXAppConfig shareInstance].isSign) {
            [self dismissHudWithInfoTitle:@"您已经签过到了明天再来吧" After:1.f];
        }else{
            [UserAccountApi accountQiandao:[NSString stringWithFormat:@"%ld",self.config.userId] block:^(QiandaoResponse *response, NSString *errorcode, NSString *errorMsg) {
                
                if ([errorcode isEqualToString:@"0"]) {
                    
                    self.popView = [[MXPopView alloc]initInView:[UIApplication sharedApplication].keyWindow score:[NSString stringWithFormat:@"%ld",response.score] doneBlock:^{
                        
                    }];
                    
                    [self dismissHudWithSuccessTitle:errorMsg After:1.f];
                    [self.popView showView];
                    
                }else{
                    [self dismissHudWithErrorTitle:errorMsg After:1.f];
                }
            }];
        }
        
    }else{
        LoginViewController *vc = [[LoginViewController alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        nvc.navigationBar.barTintColor = [UIColor redColor];
        [nvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

-(void)bithChangetap{
   
    BirthNumberViewController *vc = [[BirthNumberViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)sportAction:(UITapGestureRecognizer*)tap{
    
    InformationViewController *vc = [[InformationViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    vc.typeId = @"2";
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)zixunAction{
   
    InformationViewController *vc = [[InformationViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    vc.typeId = @"1";
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}


-(void)numberActipn:(UITapGestureRecognizer*)tap{
    InformationViewController *vc = [[InformationViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    vc.typeId = @"3";
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)lottyStyleAction:(UITapGestureRecognizer*)tap{
    self.hidesBottomBarWhenPushed = YES;

    switch (tap.view.tag) {
        case 0:
        {
            DoubleBallViewController *vc = [[DoubleBallViewController alloc]init];
            vc.flag = 0;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            DoubleBallViewController *vc = [[DoubleBallViewController alloc]init];
            vc.flag = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            ThreeAndFireViewController *vc = [[ThreeAndFireViewController alloc]init];
            vc.flag = 2;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            ThreeAndFireViewController *vc = [[ThreeAndFireViewController alloc]init];
            vc.flag = 3;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            SevenLottyViewController *vc = [[SevenLottyViewController alloc]init];
            vc.flag = 5;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            SevenLottyViewController *vc = [[SevenLottyViewController alloc]init];
            vc.flag = 6;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            PailieFireViewController *vc = [[PailieFireViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark -scrollLable

- (void)msgChange {
    
    
    if (self.msgCount < self.responseDatas.count) {
        InformationResponse *response = self.responseDatas[self.msgCount];
        self.msgLable.text = response.title;
        self.msgCount++;
        
        if (self.msgCount == self.responseDatas.count) {
            self.msgCount = 0;
        }
        
    } else {
        
    }
    
    CGRect frame = self.msgLable.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    self.msgLable.frame = frame;
    
    [UIView beginAnimations:@"scrollLabelTest" context:NULL];
    [UIView setAnimationDuration:5.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:0];
    
    frame = self.msgLable.frame;
    frame.origin.x = -frame.size.width;
    self.msgLable.frame = frame;
    [UIView commitAnimations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
