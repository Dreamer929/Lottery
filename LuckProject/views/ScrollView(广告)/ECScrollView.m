//
//  ECScrollView.m
//  SmartHR2.0
//
//  Created by 微知软件 on 16/10/7.
//  Copyright © 2016年 Microseer. All rights reserved.
//

#import "ECScrollView.h"


@interface ECScrollView ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSArray *imageURLs;
@property (nonatomic,strong)UIPageControl *pageController;
//设置定时器，用户拖拽时，不需要自动滑动
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation ECScrollView

- (instancetype)initWithFrame:(CGRect)frame imageURLs:(NSArray *)imageURLs{
    self = [super initWithFrame:frame];
    if (self) {
        if (imageURLs.count == 0) {
            return nil;
        }
        self.imageURLs = imageURLs;
        [self createScrollView];
        [self initImages];
        [self createPageController];
        // 两张图以上才创建timer
        if (self.imageURLs.count >= 2) {
            [self createTimer];
        }
    }
    return self;
}
//创建分页控制器
- (void)createPageController {
    self.pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 60, self.frame.size.height - 20, 120, 20)];
    self.pageController.pageIndicatorTintColor = [UIColor grayColor];
    self.pageController.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:self.pageController];
    // 一共几个diandian
    self.pageController.numberOfPages = self.imageURLs.count;
}
//创建滚动视图
- (void)createScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width *  self.imageURLs.count, 0);
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
}
//初始化图片
- (void)initImages{
    // 如果只有一个网址（一张图片）不用循环轮播 直接创建一张imageView
    if (self.imageURLs.count == 1) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs[0]] placeholderImage:ECIMAGENAME(@"pachImage.png")];
        [self.scrollView addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickFunction)];
        // 给每一张图片都添加一个点击事件
        [imageView addGestureRecognizer:tap];
        // 打开imageView交互
        imageView.userInteractionEnabled = YES;
        return;
    }
    // 在左右两边各添加一张imageView
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * (self.imageURLs.count + 2), 0);
    // 整夜滚动
    self.scrollView.pagingEnabled = YES;
    // 一上来就显示第一个
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    for (int i = 0; i < self.imageURLs.count + 2; i++) {
        //创建手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickFunction)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        // 给每一张图片都添加一个点击事件
        [imageView addGestureRecognizer:tap];
        // 打开imageView交互
        imageView.userInteractionEnabled = YES;
        // 第一张显示最后一张的内容
        if (i == 0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs.lastObject] placeholderImage:ECIMAGENAME(@"zhanwei")];
            // 最后一张显示第一张的内容
        } else if (i == self.imageURLs.count + 1) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs.firstObject] placeholderImage:ECIMAGENAME(@"zhanwei")];
        } else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs[i - 1]]placeholderImage:ECIMAGENAME(@"zhanwei")];
        }
        [self.scrollView addSubview:imageView];
    }
}

//图片点击
- (void)imageClickFunction {
    // 回调block
    if (self.imageBlock) {
        self.imageBlock(self.pageController.currentPage);
    }
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 如果偏移到第0个 回到最后一个
    if (self.scrollView.contentOffset.x <= 0) {
        self.scrollView.contentOffset = CGPointMake(self.imageURLs.count * self.frame.size.width, 0);
    }
    if (self.scrollView.contentOffset.x >= (self.imageURLs.count + 1) * self.frame.size.width) {
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    self.pageController.currentPage = self.scrollView.contentOffset.x / self.frame.size.width - 1;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 定时器没有提供暂停的方法  我们可以设置他在什么时间开启
    [self.timer setFireDate:[NSDate distantFuture]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // [self createTimer];
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:ECScrollViewTime]];
}
//定时器
- (void)createTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeHander) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];//把定时器添加到runloop的追踪模式上确保定时器不会在滑动其他界面的时候失效
}
- (void)timeHander {
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x += self.frame.size.width;
    [self.scrollView setContentOffset:offSet animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
