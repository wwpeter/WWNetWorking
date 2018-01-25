//
//  WZBLoginAPIManager.m
//  Wzbao
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import "WZBLoginAPIManager.h"

@interface WZBLoginAPIManager()<AZAPIManager>

@end

@implementation WZBLoginAPIManager

#pragma mark - AZAPIManager

- (NSString *)methodName {
    return kWZBLogin;
}

- (NSString *)serviceType {
    return kAZServiceWZB;
}

- (AZAPIManagerRequestType)requestType {
    return AZAPIManagerRequestTypePost;
}
- (BOOL)manager:(AZAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    //对用户输入的参数进行判断 不用放在 controller  或者viewModel层
    NSString *tel = data[@"tel"];
    NSString *password = data[@"dlmm"];
    
    NSString *message = @"";
    if (isEmptyString(tel)) {
        message = @"请您输入手机号";
    } else if (isEmptyString(password)) {
        message = @"请您输入密码";
    }//等等
    
    if (message.length > 0) {
        self.errorMessage = message;
        return NO;
    }
    
    return YES;
}

@end
