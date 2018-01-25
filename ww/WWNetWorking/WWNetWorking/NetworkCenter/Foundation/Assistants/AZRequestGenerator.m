//
//  AZRequestGenerator.m
//  AZNetworking
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WangWei. All rights reserved.
//

#import "AZRequestGenerator.h"
#import "NSObject+AZNetworkingMethods.h"
#import "AZLogger.h"
#import "AZService.h"
#import "NSDictionary+AZNetworkingMethods.h"
#import "AZNetworkingConfiguration.h"
#import "AZServiceFactory.h"
#import "AZCommonParamsGenerator.h"
#import <AFNetworking/AFNetworking.h>
#import "AZSignatureGenerator.h"
#import "NSURLRequest+AZNetworkingMethods.h"

@interface AZRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation AZRequestGenerator

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kAZNetworkingTimeoutSeconds;//请求的时间
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    
    return _httpRequestSerializer;
}

#pragma mark - public methods
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static AZRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AZRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName {
    AZService *service = [[AZServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];//工厂类 public methods
    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    sigParams[@"api_key"] = service.publicKey;
    NSString *signature = [AZSignatureGenerator signGetWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[AZCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:sigParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@", service.apiBaseUrl, methodName, [requestParams AZ_urlParamsStringSignature:NO]];
    if (signature != nil && signature.length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams AZ_urlParamsStringSignature:NO], signature];
    }
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kAZNetworkingTimeoutSeconds;
    request.requestParams = requestParams;
    [AZLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"GET"];
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                methodName:(NSString *)methodName {
    AZService *service = [[AZServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *signature = [AZSignatureGenerator signPostWithApiParams:requestParams privateKey:service.privateKey publicKey:service.publicKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    if (signature != nil && signature.length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@/%@?api_key=%@&sig=%@&%@", service.apiBaseUrl, service.apiVersion, methodName, service.publicKey, signature, [[AZCommonParamsGenerator commonParamsDictionary] AZ_urlParamsStringSignature:NO]];
    }

    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    request.requestParams = requestParams;
    [AZLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"POST"];
    return request;
}

- (NSURLRequest *)generateBodyPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                                 requestParams:(NSDictionary *)requestParams
                                                    methodName:(NSString *)methodName {
    AZService *service = [[AZServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *signature = [AZSignatureGenerator signPostWithApiParams:requestParams privateKey:service.privateKey publicKey:service.publicKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    if (signature != nil && signature.length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@/%@?api_key=%@&sig=%@&%@", service.apiBaseUrl, service.apiVersion, methodName, service.publicKey, signature, [[AZCommonParamsGenerator commonParamsDictionary] AZ_urlParamsStringSignature:NO]];
    }
    NSString *jsonStr = [self convertToJsonData:requestParams];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
    request.timeoutInterval = 30.0;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
//    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
//    request.requestParams = requestParams;
    [AZLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"POST"];
    return request;
}

- (NSString *)convertToJsonData:(NSDictionary *)dict {
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@"" withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}
- (NSURLRequest *)generatePutRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    AZService *service = [[AZServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];//工厂类 public methods
    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    sigParams[@"api_key"] = service.publicKey;
    NSString *signature = [AZSignatureGenerator signGetWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[AZCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:sigParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@", service.apiBaseUrl, methodName, [requestParams AZ_urlParamsStringSignature:NO]];
    if (signature != nil && signature.length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams AZ_urlParamsStringSignature:NO], signature];
    }
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kAZNetworkingTimeoutSeconds;
    request.requestParams = requestParams;
    [AZLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"PUT"];
    return request;
}

- (NSURLRequest *)generateDeleteRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    AZService *service = [[AZServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];//工厂类 public methods
    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    sigParams[@"api_key"] = service.publicKey;
    NSString *signature = [AZSignatureGenerator signGetWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[AZCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:sigParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@", service.apiBaseUrl, methodName, [requestParams AZ_urlParamsStringSignature:NO]];
    if (signature != nil && signature.length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams AZ_urlParamsStringSignature:NO], signature];
    }
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"Delete" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kAZNetworkingTimeoutSeconds;
    request.requestParams = requestParams;
    [AZLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"Delete"];
    return request;
}

@end
