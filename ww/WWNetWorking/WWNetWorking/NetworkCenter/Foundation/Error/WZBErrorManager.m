//
//  WZBErrorManager.m
//  Wzbao
//
//  Created by WangWei on 15/10/13.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import "WZBErrorManager.h"

NSString * const kWZBTicketExpiredNotification = @"kWZBTicketExpiredNotification";

@implementation WZBErrorManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static WZBErrorManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WZBErrorManager alloc] init];
    });
    
    return sharedInstance;
}

- (BOOL)manager:(AZAPIBaseManager *)manager isCorrectCallbackData:(id)responseData {
    NSDictionary *data = responseData;
    if ([data[@"Result"] isEqualToString:@"01"]||[data[@"result"] isEqualToString:@"01"]) {
        return YES;
    } else if ([data[@"Result"] isEqualToString:@"03"]||[data[@"result"] isEqualToString:@"03"]||[data[@"Result"] isEqualToString:@"06"]||[data[@"result"] isEqualToString:@"06"]) {
        // Token过期
        [[NSNotificationCenter defaultCenter] postNotificationName:kWZBTicketExpiredNotification object:manager];
    }
    
    return NO;
}

- (NSString *)retrieveErrorMessage:(id)responseData {
    NSDictionary *data = responseData;
    NSString *message = data[@"Msg"];
    return message;
}

@end
