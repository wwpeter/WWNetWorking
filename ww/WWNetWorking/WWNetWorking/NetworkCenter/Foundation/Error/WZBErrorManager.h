//
//  WZBErrorManager.h
//  Wzbao
//
//  Created by WangWei on 15/10/13.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZAPIBaseManager.h"

@interface WZBErrorManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)manager:(AZAPIBaseManager *)manager isCorrectCallbackData:(id)responseData;

- (NSString *)retrieveErrorMessage:(id)responseData;

@end
