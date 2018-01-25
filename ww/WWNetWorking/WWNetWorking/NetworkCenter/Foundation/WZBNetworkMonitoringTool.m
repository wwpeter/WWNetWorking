//
//  WZBNetworkMonitoringTool.m
//  Wzbao
//
//  Created by wangwei on 2018/1/12.
//  Copyright © 2018年 AaronZhang. All rights reserved.
//

#import "WZBNetworkMonitoringTool.h"
#import <AFNetworking/AFNetworking.h>

@implementation WZBNetworkMonitoringTool
//+ (instancetype)sharedInstance {
//    static dispatch_once_t onceToken;
//    static WZBNetworkMonitoringTool *sharedInstance;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[WZBNetworkMonitoringTool alloc] init];
//    });
//
//    return sharedInstance;
//}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self networkMonitring];
    }
    return self;
}

- (void)networkMonitring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status ==AFNetworkReachabilityStatusNotReachable||status==AFNetworkReachabilityStatusUnknown) {
            if (self.block) {
                self.block(YES);
            }
        } else {
//            if (self.block) {
//                self.block(YES);
//            }
        }
    }];
}

@end
