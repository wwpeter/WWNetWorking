//
//  AZServiceFactory.m
//  AZNetworking
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WangWei. All rights reserved.
//

#import "AZServiceFactory.h"
#import "WZBService.h"
#import "WZBCustodyService.h"

NSString * const kAZServiceWZB = @"kAZServiceWZB";
NSString * const kAZServiceCustodyWZB = @"kAZServiceCustodyWZB";

@interface AZServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation AZServiceFactory

#pragma mark - getters and setters

- (NSMutableDictionary *)serviceStorage {
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    
    return _serviceStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static AZServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AZServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (AZService<AZServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier {
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (AZService<AZServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier {
    if ([identifier isEqualToString:kAZServiceWZB]) {
        return [[WZBService alloc] init];
    } else if ([identifier isEqualToString:kAZServiceCustodyWZB]) {
        return [[WZBCustodyService alloc] init];
    }
    return nil;
}

@end
