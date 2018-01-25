//
//  WZBNetworkMonitoringTool.h
//  Wzbao
//
//  Created by wangwei on 2018/1/12.
//  Copyright © 2018年 AaronZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WZBNetworkMonitoringToolBlock)(BOOL monitoring);
@interface WZBNetworkMonitoringTool : NSObject

//+ (instancetype)sharedInstance;
//
@property (nonatomic, copy) WZBNetworkMonitoringToolBlock block;
- (void)setBlock:(WZBNetworkMonitoringToolBlock)block;

@end
