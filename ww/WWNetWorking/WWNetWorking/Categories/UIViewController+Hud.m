//
//  UIViewController+Hud.m
//  Wzbao
//
//  Created by WangWei on 15/10/14.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import "UIViewController+Hud.h"
#import "objc/runtime.h"
#import "WZBNetworkMonitoringTool.h"

#define UILABEL_LINE_SPACE 8

#define HEIGHT [ [ UIScreen mainScreen ] bounds ].size.height

static void * kWZBHUDKey;

@interface UIViewController()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation UIViewController (Hud)

- (MBProgressHUD *)hud {
    MBProgressHUD *_hud = objc_getAssociatedObject(self, &kWZBHUDKey);
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        objc_setAssociatedObject(self, &kWZBHUDKey, _hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return _hud;
}

- (void)showMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
}

- (void)showHUD {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showInfoAlertView:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)showInfoAlertView:(NSString *)message delegate:(id)delegate {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)showInfoAlertView:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.tag = tag;
    [alertView show];
}
- (void)showInfoAlertViewCancle:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = tag;
    [alertView show];
}
- (void)configBackTitle {
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    //返回
    backBarButtonItem.title = @"";
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    [[UINavigationBar appearance] setTintColor:Kback];
}
- (WZBMyTitleView *)createTitle:(NSInteger)font color:(UIColor *)colcor titileStr:(NSString *)str {
    CGFloat width = 0.6;
    if (iPhone4||iPhone5) {
        width = 0.45;
    }
    WZBMyTitleView *titil = [[WZBMyTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*width, 25)];
    titil.titleStr = str;
    titil.myColor = colcor;
    titil.font = font;
    
    return titil;
}
- (void)goBack {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WZB_back.png"]];
    imageView.frame = CGRectMake(0, 14, 18, 16);
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(clickPopButton)];
    [imageView addGestureRecognizer:tap];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 70, 44);
    
    [button addTarget:self action:@selector(clickPopButton) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:imageView];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}
- (void)clickPopButton {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goBack1 {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WZB_back.png"]];
    imageView.frame = CGRectMake(0, 14, 18, 16);
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(clickPopButton1)];
    [imageView addGestureRecognizer:tap];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 70, 44);
    //[button setBackgroundImage:[UIImage imageNamed:@"WZB_back.png"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickPopButton1) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:imageView];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}
- (void)clickPopButton1 {
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)myGoBack {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WZB_back.png"]];
    imageView.frame = CGRectMake(0, 14, 18, 16);
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(dismissButton)];
    [imageView addGestureRecognizer:tap];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 70, 44);
    [button addTarget:self action:@selector(dismissButton) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:imageView];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}
- (void)dismissButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width withHeight:(CGFloat)height {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode =NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = height; //设置行间距
    
    paraStyle.hyphenationFactor = width;
    
    paraStyle.firstLineHeadIndent =0.0;
    
    paraStyle.paragraphSpacingBefore =0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@1.5f
    
    NSDictionary *dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@1.5f
                         };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    label.attributedText = attributeStr;
    
}
//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode =NSLineBreakByCharWrapping;
    
    paraStyle.alignment =NSTextAlignmentLeft;
    
    //paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.lineSpacing = 6; //设置行间距
    if (iPhone5) {
        paraStyle.lineSpacing = 4; //设置行间距
    }
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent =0.0;
    
    paraStyle.paragraphSpacingBefore =0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@1.5f
                         };
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}

- (void)pushControllerWithHideTabbar:(Class)cls {
    UIViewController *controller = [[cls alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)pushControllerWithShowTabbar:(Class)cls {
    UIViewController *controller = [[cls alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (NSString *)dayConversionMonth:(NSString *)day {
    NSInteger staticday = [day integerValue];
    if (staticday<30) {
        return [NSString stringWithFormat:@"%@天", day];
    } else {
        NSInteger day = staticday%30;
        NSInteger month = staticday/30;
        if (day==0) {
            return  [NSString stringWithFormat:@"%ld个月", month];
        } else {
            return [NSString stringWithFormat:@"%ld个月%ld天", month,day];
        }
    }
}
- (void)notificationSend:(NSString *)notifiStr {
    //通知我的资产刷新
    NSNotification * notice = [NSNotification notificationWithName:notifiStr object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}
//缩放
- (void)reansformImage:(UIView *)reansformImage {
    //缩放
    reansformImage.transform=CGAffineTransformMakeScale(0.01f, 0.01f);
    reansformImage.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        
        reansformImage.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        reansformImage.alpha = 1;
    }];
}
+ (BOOL)getIsIpad {
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"]) {
        return NO;
    }
    
    else if([deviceType isEqualToString:@"iPod touch"]) {
        return NO;
    }
    
    else if([deviceType isEqualToString:@"iPad"]) {
        return YES;
    }
    
    return NO;
}
- (void)reachabilityNetWorking {
    WZBNetworkMonitoringTool *netWorkTool = [[WZBNetworkMonitoringTool alloc] init];
    [netWorkTool setBlock:^(BOOL monitoring) {
        if (monitoring) {
            [self showMessage:@"请您检查网络！"];
        }
    }];
}
@end
