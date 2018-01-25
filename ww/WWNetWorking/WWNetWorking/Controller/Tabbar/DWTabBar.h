//
//  DWTabBar.h
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DWTabBarBlcok)();
@interface DWTabBar : UITabBar

@property (nonatomic, copy) DWTabBarBlcok block;
- (void)setBlock:(DWTabBarBlcok)block;

@end
