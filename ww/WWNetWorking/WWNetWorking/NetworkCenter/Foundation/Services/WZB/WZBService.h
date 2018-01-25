//
//  WZBService.h
//  AZNetworking
//
//  Created by wangwei on 15/10/12.
//  Copyright © 2015年 wangwei. All rights reserved.
//

#import "AZService.h"

//#define kServerAddres @"http://192.168.16.21/wzb2/app3/"
#define kServerAddres @"https://app.52wzb.com/wzb2/app3/"
//#define kServerAddres @"https://dev.52wzb.com/wzb2/app3/"
//#define kServerAddres @"https://pre.52wzb.com/wzb2/app3/"

@interface WZBService : AZService<AZServiceProtocol>

@end
