//
//  AZLogger.h
//  AZNetworking
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZLoggerConfiguration.h"
#import "AZURLResponse.h"
#import "AZService.h"

@interface AZLogger : NSObject

@property (nonatomic, strong, readonly) AZLoggerConfiguration *configParams;

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(AZService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod;

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response resposeString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error;

+ (void)logDebugInfoWithCachedResponse:(AZURLResponse *)response methodName:(NSString *)methodName serviceIdentifier:(AZService *)service;

+ (instancetype)sharedInstance;

- (void)logWithActionCode:(NSString *)actionCode params:(NSDictionary *)params;

@end
