//
//  Extern+Str.h
//  Wzbao
//
//  Created by wangwei on 2017/5/19.
//  Copyright © 2017年 AaronZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 通知相关的外部链接 */
extern NSString * const kWZBGetRedClick;//首页红包
extern NSString * const kWZBAdvertisingClick;//广告
extern NSString * const kWZBAssetRefresh;//资产刷新
extern NSString * const kWZBDepositAccountSuccess;//存管开户之后的刷新
extern NSString * const kWZBWillEnterForeground;//后台进来解决后台更改数据的问题
extern NSString * const kWZBFingerprintsAreUnlocked;//指纹解锁
extern NSString * const kWZBAdvertisingNotification;//广告的签到通知
extern NSString * const kWZBRedAccountNotification;//红包个数
extern NSString * const kWZBDismiss;//登陆里面的
extern NSString * const SignInRewardDate;//签到

extern NSString * const kWZBNotifityJpush;//推送

extern NSString * const kWZBNewUser;//新手弹出 沙盒

extern NSString * const kWZBMyPersonCenterShare;//处理分享

extern NSString * const kWZBLoginAgainRedMoneyNotification;//登陆的红包处理
extern NSString * const kWZBBuyFinanacialAmount;//购买余额问题

extern NSString * const kWZBPurchaseSuccessNotification;

/* 存管相关 接口相关 */
extern NSString * const kWZBDepositAccountCode;//开户验证码
extern NSString * const kWZBDepositAccount;//开户
extern NSString * const kWZBDepositRecharge;//充值
extern NSString * const kWZBDepositRechargeCode;//充值确认 快捷支付
extern NSString * const kWZBDepositUserDetail;//存管用户信息
extern NSString * const kWZBDepositWithdraw;//提现
extern NSString * const kWZBLogin;//登陆接口
extern NSString * const kWZBFinancialList;//提现

@interface Extern_Str : NSObject

@end
