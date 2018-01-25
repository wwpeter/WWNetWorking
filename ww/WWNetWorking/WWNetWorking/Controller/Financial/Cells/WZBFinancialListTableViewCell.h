//
//  WZBFinancialListTableViewCell.h
//  Wzbao
//
//  Created by wangwei on 16/10/2.
//  Copyright © 2016年 WZBaoWW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BuyFinancialBlock)();
@interface WZBFinancialListTableViewCell : UITableViewCell

@property (nonatomic, copy) BuyFinancialBlock buyBlock;
- (void)configData:(NSDictionary *)data;
- (void)setBuyBlock:(BuyFinancialBlock)buyBlock;

@end
