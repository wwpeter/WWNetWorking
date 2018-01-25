//
//  AZNetworkingConfiguration.h
//  AZNetworking
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WangWei. All rights reserved.
//


#ifndef AZNetworkingConfiguration_h
#define AZNetworkingConfiguration_h

typedef NS_ENUM(NSUInteger, AZURLResponseStatus) {
    // 作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，
    // 返回的数据是否完整，由上层的AZAPIBaseManager来决定。
    AZURLResponseStatusSuccess,
    AZURLResponseStatusErrorTimeout,
    // 默认除了超时以外的错误都是无网络错误。
    AZURLResponseStatusErrorNoNetwork
};

static NSTimeInterval kAZNetworkingTimeoutSeconds = 20.0f;

static NSString *AZKeychainServiceName = @"com.Apps";
static NSString *AZUDIDName = @"AppsUDID";
static NSString *AZPasteboardType = @"AppsContent";

static BOOL kAZShouldCache = NO;
static NSTimeInterval kAZCacheOutdateTimeSeconds = 300; // 5分钟的cache过期时间
static NSUInteger kAZCacheCountLimit = 1000; // 最多1000条cache

extern NSString * const kWZBTicketExpiredNotification;

extern NSString * const kAZServiceWZB;
extern NSString * const kAZServiceCustodyWZB;

#endif /* AZNetworkingConfiguration_h */
