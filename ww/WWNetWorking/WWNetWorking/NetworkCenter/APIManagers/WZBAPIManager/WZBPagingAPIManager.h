//
//  WZBPagingAPIManagr.h
//  Wzbao
//
//  Created by WangWei on 15/10/18.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import "WZBBaseAPIManager.h"

@interface WZBPagingAPIManager : WZBBaseAPIManager
@property (nonatomic, assign) NSInteger nextPageNumber;
@property (nonatomic, assign) NSInteger pageSize;

- (void)loadNewData;
- (void)loadNextPage;

@end
