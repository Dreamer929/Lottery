//
//  RootViewController.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()

@property (nonatomic, strong)NSMutableArray *viewControllerData;

@end

@implementation RootViewController

-(instancetype)init{
    
    if (self = [super init]) {
        
        [self configTabBarModel];
        [self createContentViewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark meatch

-(void)configTabBarModel{
    
    self.viewControllerData = [NSMutableArray array];
    
    RootModel *homeModel = [RootModel modelWithTitle:@"首页" normalImage:@"home" selectedImage:@"home_s" className:@"HomeViewController"];
    RootModel *MineModel = [RootModel modelWithTitle:@"我的" normalImage:@"mine" selectedImage:@"mine_s" className:@"MineViewController"];
    RootModel *secondMode = [RootModel modelWithTitle:@"圈子" normalImage:@"quanzi" selectedImage:@"quanzi_s" className:@"LottyCircleViewController"];
    
    [self.viewControllerData addObject:homeModel];
    [self.viewControllerData addObject:secondMode];
    [self.viewControllerData addObject:MineModel];
}

-(void)createContentViewControllers{
    
    NSMutableArray *viewcontrollerArr = [NSMutableArray array];
    
    for (NSInteger index = 0; index < self.viewControllerData.count; index++) {
        
        RootModel *model = self.viewControllerData[index];
        
        UIViewController *viewcontroller = [[NSClassFromString(model.className) alloc]init];
        viewcontroller.title = model.tabbarTitle;
        
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:viewcontroller];
        nvc.tabBarItem.title = model.tabbarTitle;
        nvc.tabBarItem.image = [model normalImage];
        nvc.tabBarItem.selectedImage = [model selectedImage];
        nvc.navigationBar.tintColor = [UIColor whiteColor];
        nvc.navigationBar.barTintColor = [UIColor redColor];
        [nvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        
        [viewcontrollerArr addObject:nvc];
    }
    
    self.tabBar.tintColor = [UIColor redColor];
    
    self.viewControllers = viewcontrollerArr;
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
