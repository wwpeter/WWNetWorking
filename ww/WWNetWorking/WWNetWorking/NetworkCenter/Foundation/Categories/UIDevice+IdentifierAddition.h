//
//  UIDevice+IdentifierAddition.h
//  AZNetworking
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIDevice (IdentifierAddition)

/*
 * @method uuid
 * @description apple identifier support iOS6 and iOS5 below
 */

- (NSString *)AZ_uuid;
- (NSString *)AZ_udid;
- (NSString *)AZ_macaddress;
- (NSString *)AZ_macaddressMD5;
- (NSString *)AZ_machineType;
- (NSString *)AZ_ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *)AZ_createUUID;

//兼容旧版本
- (NSString *)uuid;
- (NSString *)udid;
- (NSString *)macaddress;
- (NSString *)macaddressMD5;
- (NSString *)machineType;
- (NSString *)ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *)createUUID;

@end
