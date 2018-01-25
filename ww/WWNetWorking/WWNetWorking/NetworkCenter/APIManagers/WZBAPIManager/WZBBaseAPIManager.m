//
//  WZBBaseAPIManager.m
//  Wzbao
//
//  Created by WangWei on 15/10/16.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import "WZBBaseAPIManager.h"
#import "WZBErrorManager.h"

@implementation WZBBaseAPIManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - AZAPIManagerValidator

- (BOOL)manager:(AZAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    self.errorMessage = [[WZBErrorManager sharedInstance] retrieveErrorMessage:data];
    return [[WZBErrorManager sharedInstance] manager:manager isCorrectCallbackData:data];
}

- (BOOL)manager:(AZAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

@end
