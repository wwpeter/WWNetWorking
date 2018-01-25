//
//  DWPublishButton.h
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DWPublishButtonBlock)();
@interface DWPublishButton : UIButton

+(instancetype)publishButton;

@property (nonatomic, copy) DWPublishButtonBlock block;
- (void)setBlock:(DWPublishButtonBlock)block;
@end
