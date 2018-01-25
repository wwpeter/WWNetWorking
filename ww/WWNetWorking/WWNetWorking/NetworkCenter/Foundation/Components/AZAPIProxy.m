//
//  AZAPIProxy.m
//  AZNetworking
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WangWei. All rights reserved.
//

#import "AZAPIProxy.h"
#import "AZServiceFactory.h"
#import "AZLogger.h"
#import "NSURLRequest+AZNetworkingMethods.h"
#import <AFNetworking/AFNetworking.h>
#import "AZRequestGenerator.h"//Assistants
#import "AZNetworkingConfiguration.h"//Assistants

static NSString * const kAZAPIProxyDispatchItemKeyCallbackSuccess = @"kAZAPIProxyDispatchItemKeyCallbackSuccess";
static NSString * const kAZAPIProxyDispatchItemKeyCallbackFail = @"kAZAPIProxyDispatchItemKeyCallbackFail";

@interface AZAPIProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;

//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation AZAPIProxy

#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable {
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
//        _sessionManager.securityPolicy.validatesDomainName = NO;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",@"text/plain", nil];
    }
    return _sessionManager;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static AZAPIProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AZAPIProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AZCallback)success fail:(AZCallback)fail {
    NSURLRequest *request = [[AZRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callAPIWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AZCallback)success fail:(AZCallback)fail {
    NSURLRequest *request = [[AZRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callAPIWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}
- (NSInteger)callBodyPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AZCallback)success fail:(AZCallback)fail {
    NSURLRequest *request = [[AZRequestGenerator sharedInstance] generateBodyPOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callAPIWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}
- (NSInteger)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AZCallback)success fail:(AZCallback)fail {
    NSURLRequest *request = [[AZRequestGenerator sharedInstance] generateBodyPOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callAPIWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}
- (NSInteger)callDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AZCallback)success fail:(AZCallback)fail {
    NSURLRequest *request = [[AZRequestGenerator sharedInstance] generateBodyPOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callAPIWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}
- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    NSOperation *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList {
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark - private methods
/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber *)callAPIWithRequest:(NSURLRequest *)request success:(AZCallback)success fail:(AZCallback)fail {
    // 之所以不用getter，是因为如果放到getter里面的话，每次调用self.recordedRequestId的时候值就都变了，违背了getter的初衷
    NSLog(@"请求的链接~~~~~~~~~~~~~~~~~~%@",request);
    // 跑到这里的block的时候，就已经是主线程了。
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];//response
        if (error) {
            [AZLogger logDebugInfoWithResponse:httpResponse
                                 resposeString:responseString
                                       request:request
                                         error:error];
            AZURLResponse *response = [[AZURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
            success?success(response):nil;
            
        } else {
            [AZLogger logDebugInfoWithResponse:httpResponse
                                 resposeString:responseString
                                       request:request
                                         error:error];
            
            AZURLResponse *response = [[AZURLResponse alloc] initWithResponseString:responseString
                                                                          requestId:requestID
                                                                            request:request
                                                                       responseData:responseData
                                                                              error:error];
            fail?fail(response):nil;
        }
    }];
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    return requestId;
}

- (NSNumber *)generateRequestId {
    if (_recordedRequestId == nil) {
        _recordedRequestId = @(1);
    } else {
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            _recordedRequestId = @(1);
        } else {
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
        }
    }
    return _recordedRequestId;
}

@end
