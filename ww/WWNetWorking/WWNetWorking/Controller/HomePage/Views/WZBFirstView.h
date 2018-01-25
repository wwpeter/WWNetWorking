//
//  WZBFirstView.h
//  Wzbao
//
//  Created by wangwei on 16/8/11.
//  Copyright © 2016年 WZBaoWW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZBFirstViewDelegate <NSObject>

- (void)didTapPurchaseAction;

//- (void)didTapTipAction;//进入web页面

@end
typedef void(^WZBFirstViewBlock)(BOOL bigORsmall);
@interface WZBFirstView : UIView

@property (nonatomic, weak) id<WZBFirstViewDelegate> delegate;
@property (nonatomic, strong) UIButton *control;

@property (nonatomic, strong) WZBFirstViewBlock block;
- (void)setBlock:(WZBFirstViewBlock)block;
- (void)configData:(NSDictionary *)data;

- (void)refresh;
@end
