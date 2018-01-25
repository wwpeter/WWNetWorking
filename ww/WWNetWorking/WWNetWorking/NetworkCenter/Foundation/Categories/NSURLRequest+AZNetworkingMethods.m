//
//  NSURLRequest+AZNetworkingMethods.m
//  AZNetworking
//
//  Created by wangwei on 15/10/12.
//  Copyright © 2015年 wangwei. All rights reserved.
//

#import "NSURLRequest+AZNetworkingMethods.h"
#import <objc/runtime.h>

static void *AZNetworkingRequestParams;

@implementation NSURLRequest (AZNetworkingMethods)

- (void)setRequestParams:(NSDictionary *)requestParams {
    objc_setAssociatedObject(self, &AZNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)requestParams {
    return objc_getAssociatedObject(self, &AZNetworkingRequestParams);
}

@end
