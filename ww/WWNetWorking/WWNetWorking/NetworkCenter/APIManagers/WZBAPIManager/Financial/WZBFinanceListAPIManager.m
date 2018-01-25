//
//  WZBFinanceListAPIManager.m
//  Wzbao
//
//  Created by WangWei on 15/10/18.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import "WZBFinanceListAPIManager.h"

@interface WZBFinanceListAPIManager ()<AZAPIManager>

@end

@implementation WZBFinanceListAPIManager

#pragma mark - AZAPIManager

- (NSString *)methodName {
    return kWZBFinancialList;
}

- (NSString *)serviceType {
    return kAZServiceWZB;//区分配置文件
}

- (AZAPIManagerRequestType)requestType {
    return AZAPIManagerRequestTypePost;//区分什么请求 post get put， post上传json 数据等等
}

@end
