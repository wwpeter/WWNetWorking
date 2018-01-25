//
//  WZBRecommendAPIManager.m
//  Wzbao
//
//  Created by WangWei on 15/10/13.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import "WZBRecommendAPIManager.h"
#import "AZServiceFactory.h"
#import "WZBErrorManager.h"

@interface WZBRecommendAPIManager()<AZAPIManager>


@end

@implementation WZBRecommendAPIManager


#pragma mark - AZAPIManager

- (NSString *)methodName {
    return @"product/wzjx2.do";//product/wzjx2.do
}

- (NSString *)serviceType {
    return kAZServiceWZB;
}

- (AZAPIManagerRequestType)requestType {
    return AZAPIManagerRequestTypePost;
}

@end
