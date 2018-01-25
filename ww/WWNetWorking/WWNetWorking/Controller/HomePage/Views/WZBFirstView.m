//
//  WZBFirstView.m
//  Wzbao
//
//  Created by wangwei on 16/8/11.
//  Copyright © 2016年 WZBaoWW. All rights reserved.
//

#import "WZBFirstView.h"
#import "WZBRecommendAPIManager.h"//首页的 接口api

@interface WZBFirstView() <AZAPIManagerAPICallBackDelegate,AZAPIManagerParamSourceDelegate>

@property (nonatomic, strong) WZBRecommendAPIManager *recommendManager;
@property (nonatomic) UIImageView *rightImageView;
@property (nonatomic) UILabel *financialNameLabel;
@property (nonatomic) UILabel *yearLabel;
@property (nonatomic) UILabel *rateLabel;

@property (nonatomic) UILabel *beginLabel;
@property (nonatomic) UILabel *dateLabel;

@property (nonatomic, assign) BOOL needNewbie;
@property (nonatomic, strong) UIView *typeView;
//处理加息
@property (nonatomic, strong) NSDictionary *rateLeft;
@property (nonatomic, strong) NSDictionary *rateRight;
@end
@implementation WZBFirstView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.recommendManager loadData];
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
    [self addSubview:self.financialNameLabel];
    [self addSubview:self.typeView];
    [self addSubview:self.rateLabel];
    [self addSubview:self.beginLabel];
    [self addSubview:self.control];
}
- (void)initViewLayouts {
    [self.financialNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhone4) {
          make.top.equalTo(self.mas_top).offset(10);
        } else {
            make.top.equalTo(self.mas_top).offset(10);
        }
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@30);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
    }];
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        make.top.equalTo(self.financialNameLabel.mas_bottom).offset(15);
    }];
    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhone4) {
            make.bottom.equalTo(self.mas_bottom).offset(-13);
        } if (iPhone5) {
            make.bottom.equalTo(self.mas_bottom).offset(-20);
        } else{
            make.bottom.equalTo(self.mas_bottom).offset(-25);
        }
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@44);
        make.width.equalTo(self.mas_width).multipliedBy(0.88);
    }];
    [self.beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.control.mas_top).offset(-10);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@30);
        make.left.equalTo(@20);
    }];
}
- (void)initViewConfigurations {

}
#pragma mark - public methods
- (void)refresh {}
- (void)dealRate:(NSDictionary *)data {
    data = data[@"List"];
    NSString *s = @"%";
    NSString *original = kNSString(data, @"syl");
    NSString *name = kNSString(data, @"cpmc");
    if ([[NSString rateHikeIntercept:name] isEqualToString:@"NO"]) {
        self.rateLabel.text = [NSString stringWithFormat:@"%.2lf%@", [data[@"syl"] doubleValue],s];
    } else {
        NSString *jiaxi = [NSString rateHikeIntercept:name];
        NSString *leftStr = [NSString stringWithFormat:@"%0.2lf",[original doubleValue]-[jiaxi doubleValue]];//总利率减去加的
        NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
        [mas appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%0.1lf%@",[leftStr doubleValue],s] attributes:self.rateLeft]];
        [mas appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"+%0.1lf%@",[jiaxi doubleValue],s] attributes:self.rateRight]];
        self.rateLabel.attributedText = mas;
    }
}
- (void)configData:(NSDictionary *)data {
    [self dealRate:data];
    NSNumber *periodNumber = [data valueForKeyPath:@"List.qx"];
    NSString *financial = [NSString stringWithFormat:@"%@",[data valueForKeyPath:@"List.cpje"]];//融资金额
    NSString *finishMoney = [NSString stringWithFormat:@"%@",[data valueForKeyPath:@"List.ytje"]];//已投金额
    NSString *dateStr = [NSString dayConversionMonth:[NSString stringWithFormat:@"%@",periodNumber]];
    // 产品名称
    self.financialNameLabel.text = [NSString stringWithFormat:@"%@ |期限 %@",[NSString interceptName:[data valueForKeyPath:@"List.cpmc"]],dateStr];
    //起投金额
     double rate = ([finishMoney doubleValue]/[financial doubleValue])*100;
    if (rate>=100.0) {
        rate = 100;
    }
    NSString *baifen = @"%";
    self.beginLabel.text = [NSString stringWithFormat:@"%@元起投   融资%@元   已融%0.2lf%@",[data valueForKeyPath:@"List.qdje"],financial,rate,baifen];
    // 收益率
    //NSNumber *rateNumber = [data valueForKeyPath:@"List.syl"];
    
    NSInteger surplus = [financial doubleValue]-[finishMoney doubleValue];
    if (surplus<=0) {
        surplus = 0;
    }
}
#pragma mark - 网络请求
- (NSDictionary *)paramsForAPI:(AZAPIBaseManager *)manager {
    if (manager == self.recommendManager) {
        return @{@"userid": @"", @"ticket": @""};
    }
    return nil;
}
- (void)managerCallAPIDidFailed:(AZAPIBaseManager *)manager {}
- (void)managerCallAPIDidSuccess:(AZAPIBaseManager *)manager {
    if (manager == self.recommendManager) {
        NSDictionary *data = [manager fetchDataWithReformer:nil];
        if (data) {
            [self configData:data];
        }
    }
}
#pragma mark - 购买
- (void)buyClick:(UIButton *)button {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didTapPurchaseAction)]) {
        [self.delegate didTapPurchaseAction];
    }
}
#pragma mark - getter
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        //_rightImageView.image = [UIImage imageNamed:@"WZB_first_new.png"];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImageView;
}
- (UILabel *)financialNameLabel {
    if (!_financialNameLabel) {
        _financialNameLabel = [[UILabel alloc] init];
        _financialNameLabel.textColor = KHexColor(0x333333);
        _financialNameLabel.text = @"稳赚宝新手专享计划18期";
        _financialNameLabel.font = kFont(18);
        _financialNameLabel.textAlignment = NSTextAlignmentCenter;
        _financialNameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _financialNameLabel;
}
- (UILabel *)yearLabel {
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc] init];
        _yearLabel.text = @"预期年化收益率";
        _yearLabel.textColor = KHexColor(0x666666);
        _yearLabel.font = kFont(13);
        _yearLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yearLabel;
}
- (UILabel *)rateLabel {
    if (!_rateLabel) {
        _rateLabel = [[UILabel alloc] init];
        _rateLabel.textAlignment = NSTextAlignmentCenter;
        _rateLabel.text = @"--.-%";
        _rateLabel.textColor = KHexColor(0xe93434);
        _rateLabel.font = kFont(36);
        if (iPhone6P) {
            _rateLabel.font = kFont(46);
        }
    }
    return _rateLabel;
}
- (UILabel *)beginLabel {
    if (!_beginLabel) {
        _beginLabel = [[UILabel alloc] init];
        _beginLabel.text = @"-- 元起投";
        _beginLabel.font = kFont(13);
        _beginLabel.textColor = KHexColor(0x333333);
        _beginLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _beginLabel;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = @"期限--天";
        _dateLabel.textColor = KHexColor(0x333333);
        _dateLabel.font = kFont(13);
        _dateLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _dateLabel;
}

- (UIButton *)control {
    if (!_control) {
        _control = [[UIButton alloc] init];
        [_control setTitle:@"立即投资" forState:UIControlStateNormal];
        [_control setBackgroundColor:KHexColor(0xe93434)];
        [_control setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_control addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        _control.layer.cornerRadius = 8;
    }
    return _control;
}

- (UIView *)typeView {
    if (!_typeView) {
        _typeView = [[UIView alloc] init];
        _typeView.backgroundColor = kClearColor;
    }
    return _typeView;
}
- (NSDictionary *)rateLeft {
    if (!_rateLeft) {
        _rateLeft = @{NSForegroundColorAttributeName: Kback, NSFontAttributeName: [UIFont systemFontOfSize:35]};
    }
    
    return _rateLeft;
}

- (NSDictionary *)rateRight {
    if (!_rateRight) {
        _rateRight = @{NSForegroundColorAttributeName: [UIColor yellowColor], NSFontAttributeName: [UIFont systemFontOfSize:22]};
    }
    
    return _rateRight;
}
- (WZBRecommendAPIManager *)recommendManager {
    if (!_recommendManager) {
        _recommendManager = [[WZBRecommendAPIManager alloc] init];
        _recommendManager.delegate = self;
        _recommendManager.paramSource = self;
    }
    return _recommendManager;
}
@end
