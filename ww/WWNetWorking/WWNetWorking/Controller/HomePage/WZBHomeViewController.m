//
//  WZBHomeViewController.m
//  WWNetWorking
//
//  Created by wangwei on 2018/1/25.
//  Copyright © 2018年 wangwei-WW. All rights reserved.
//

#import "WZBHomeViewController.h"
#import "WZBFirstView.h"

@interface WZBHomeViewController () <WZBFirstViewDelegate>

@property (nonatomic, strong) WZBFirstView *homePageView;
@end

@implementation WZBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self initViewLayouts];
}

#pragma mark - initializa
- (void)initViews {
    [self.view addSubview:self.homePageView];
}
- (void)initViewLayouts {
    self.view.backgroundColor = KGroundGeneral;
}
#pragma mark - 代理
- (void)didTapPurchaseAction {}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (WZBFirstView *)homePageView {
    if (!_homePageView) {
        _homePageView = [[WZBFirstView alloc] init];
        _homePageView.delegate = self;
        _homePageView.backgroundColor = [UIColor cyanColor];
        _homePageView.frame = CGRectMake(0, SCREEN_HEIGHT*0.32, SCREEN_WIDTH, 260);
    }
    return _homePageView;
}

@end
