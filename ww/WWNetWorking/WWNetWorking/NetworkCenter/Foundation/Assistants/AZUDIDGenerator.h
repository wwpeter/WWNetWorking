//
//  AZUDIDGenerator.h
//  AZNetworking
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AZUDIDGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSString *)UDID;
- (void)saveUDID:(NSString *)udid;

@end
