//
//  AZServiceFactory.h
//  AZNetworking
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZService.h"

@interface AZServiceFactory : NSObject

+ (instancetype)sharedInstance;
- (AZService<AZServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
