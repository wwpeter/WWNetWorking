//
//  WZBPagingAPIManagr.m
//  Wzbao
//
//  Created by WangWei on 15/10/18.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import "WZBPagingAPIManager.h"

@interface WZBPagingAPIManager ()<AZAPIManagerInterceptor>//

@property (nonatomic, assign) NSInteger totalPageCount;

@end

@implementation WZBPagingAPIManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.interceptor = self;
        self.nextPageNumber = 1;
        self.pageSize = 10;
    }
    return self;
}

- (void)loadNewData {
    if (self.isLoading) {
        NSLog(@"loadNewData");
        return;
    }
    self.nextPageNumber = 1;
    [self loadData];
}

- (void)loadNextPage {
    if (self.isLoading) {
        NSLog(@"loadNextPage");
        return;
    }
    
    if (self.totalPageCount > 1 && self.nextPageNumber <= self.totalPageCount) {
        [self loadData];
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
            self.errorMessage = @"没用更多了";
            [self.delegate managerCallAPIDidFailed:self];
        }
    }
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:params];
    requestParams[@"showCount"] = @(self.pageSize);
    requestParams[@"currentPage"] = @(self.nextPageNumber);
    return requestParams;
}

#pragma mark - AZAPIManagerInterceptor

- (void)manager:(AZAPIBaseManager *)manager beforePerformSuccessWithResponse:(AZURLResponse *)response {
    if ([response.content isKindOfClass:[NSDictionary class]]) {
        self.totalPageCount = [response.content[@"Totalpage"] integerValue];
    }
    
    ++self.nextPageNumber;
}

- (void)manager:(AZAPIBaseManager *)manager beforePerformFailWithResponse:(AZURLResponse *)response {
    --self.nextPageNumber;
}

@end
