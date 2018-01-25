//
//  NSDictionary+AZNetworkingMethods.h
//  AZNetworking
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AZNetworkingMethods)

- (NSString *)AZ_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)AZ_jsonString;
- (NSArray *)AZ_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
