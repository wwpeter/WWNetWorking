//
//  WZBMyTitleView.m
//  Wzbao
//
//  Created by wangwei on 16/8/12.
//  Copyright © 2016年 WZBaoWW. All rights reserved.
//

#import "WZBMyTitleView.h"

@interface WZBMyTitleView()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation WZBMyTitleView
- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        [self initViewConfigurations];
    }
    return self;
}
- (void)updateConstraints {
    [super updateConstraints];
    [self initViewLayouts];
}
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
- (void)initViews {
    [self addSubview:self.titleLabel];
}
- (void)initViewLayouts {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
}
- (void)initViewConfigurations {
    
}
#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont(17);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}
#pragma mark - setter
- (void)setTitleStr:(NSString *)titleStr {
    _titleLabel.text = titleStr;
}
- (void)setFont:(NSInteger)font {
    long a = font;
    _titleLabel.font = kFont(a);
}
- (void)setMyColor:(UIColor *)myColor {
    _titleLabel.textColor = myColor;
}

@end
