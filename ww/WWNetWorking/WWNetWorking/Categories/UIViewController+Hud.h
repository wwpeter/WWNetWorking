//
//  UIViewController+Hud.h
//  Wzbao
//
//  Created by WangWei on 15/10/14.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "WZBMyTitleView.h"

@interface UIViewController (Hud)

- (void)showMessage:(NSString *)message;

- (void)showHUD;
- (void)hideHUD;

- (void)showInfoAlertView:(NSString *)message;
- (void)showInfoAlertView:(NSString *)message delegate:(id)delegate;
- (void)showInfoAlertView:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag;

- (void)configBackTitle;
- (WZBMyTitleView *)createTitle:(NSInteger)font color:(UIColor *)colcor titileStr:(NSString *)str;
- (void)goBack;
- (void)goBack1;
- (void)myGoBack;

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width withHeight:(CGFloat)height;
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;//获取uilabel的高度

- (void)presentLogin;
- (void)showInfoAlertViewCancle:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag;

//封装push
- (void)pushControllerWithHideTabbar:(Class)cls;
- (void)pushControllerWithShowTabbar:(Class)cls;

//时间转换
- (NSString *)dayConversionMonth:(NSString *)day;
//通知中心
- (void)notificationSend:(NSString *)notifiStr;
//缩放
- (void)reansformImage:(UIView *)reansformImage;
+ (BOOL)getIsIpad;//判断是不是ipad

- (void)reachabilityNetWorking;
@end
