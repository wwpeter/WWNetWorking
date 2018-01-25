//
//  DWTabBarController.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWTabBarController.h"

#import "WZBHomeViewController.h"
#import "WZBFinancialLisController.h"
#import "WZBBrandViewController.h"
#import "WZBMyAssetViewController.h"
#import "WZBPersonCenterViewController.h"

#import "Extern+Str.h"
#import "DWTabBar.h"

@interface DWTabBarController() <UITabBarControllerDelegate>
@end

#define DWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0] //<<< 用10进制表示颜色，例如（255,255,255）黑色
#define DWRandomColor DWColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@implementation DWTabBarController

#pragma mark - Life Cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    // 设置 TabBarItemTestAttributes 的颜色。
    [self setUpTabBarItemTextAttributes];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    
    //去除 TabBar 自带的顶部阴影
    //[[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //设置导航控制器颜色为黄色
    [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:kWhiteColor] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark -
#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    
    DWTabBar *tabbar = [[DWTabBar alloc] init];
    [tabbar setBlock:^{
        WZBBrandViewController *vc = [[WZBBrandViewController alloc] init];
        UINavigationController *niv = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:niv animated:YES completion:nil];
    }];
    [self setValue:tabbar forKey:@"tabBar"];
}


/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes{
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = Kback;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}
/**
 *  添加子控制器，我这里值添加了4个，没有占位自控制器
 */
- (void)setUpChildViewController{
    self.delegate = self;
    self.tabBar.translucent = NO;
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[WZBHomeViewController alloc]init]]
                          WithTitle:@"首页"
                          imageName:@"BZ_tabbarjx"
                  selectedImageName:@"BZ_tabbarjx"];//_selected
    
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[WZBFinancialLisController alloc] init]]
                          WithTitle:@"理财"
                          imageName:@"BZ_tabbarFinancial"
                  selectedImageName:@"BZ_tabbarFinancial"];
    
    
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[WZBMyAssetViewController alloc]init]]
                          WithTitle:@"资产"
                          imageName:@"BZ_tabbar_myrich"
                  selectedImageName:@"BZ_tabbar_myrich"];
    
    WZBPersonCenterViewController *vc= [[WZBPersonCenterViewController alloc]init];
    //vc.share = @"YES";
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:vc]
                          WithTitle:@"我的"
                          imageName:@"BZ_tabbar_share"
                  selectedImageName:@"BZ_tabbar_share"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    viewController.view.backgroundColor     = DWRandomColor;
    viewController.tabBarItem.title         = title;
    //viewController.tabBarItem.image         = [UIImage imageNamed:imageName];
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image         = image;
    
    UIImage *imageSelect = [UIImage imageNamed:selectedImageName];
    imageSelect = [imageSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = imageSelect;
    [self addChildViewController:viewController];
}

//这个方法可以抽取到 UIImage 的分类中
- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    if ([viewController isKindOfClass:[UINavigationController class]]) {
//        UINavigationController *nav = (UINavigationController *)viewController;
//        if ([nav.viewControllers[0] isKindOfClass:[WZBMyAssetViewController class]] || [nav.viewControllers[0] isKindOfClass:[WZBPersonCenterViewController class]]) {
//            if (![WZBUserCache sharedInstance].isLogin) {
//                WZBNewLoginViewController *vc = [[WZBNewLoginViewController alloc] init];
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//                nav.navigationBar.translucent = NO;
//                [self presentViewController:nav animated:YES completion:nil];
//                return NO;
//            }
//        }
//    }
    
    return YES;
}
@end
