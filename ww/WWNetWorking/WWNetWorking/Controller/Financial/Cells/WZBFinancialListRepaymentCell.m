//
//  WZBFinancialListRepaymentCell.m
//  Wzbao
//
//  Created by wangwei on 16/10/2.
//  Copyright © 2016年 WZBaoWW. All rights reserved.
//

#import "WZBFinancialListRepaymentCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WZBFinancialListRepaymentCell()

@property (nonatomic, strong) UILabel *financialNameLabel;//名字
@property (nonatomic, strong) UILabel *incomeRateTitleLabel;//预期年化
@property (nonatomic, strong) UILabel *incomeRateLabel;//年化百分比
@property (nonatomic, strong) UILabel *percentageLabel;//100元投
@property (nonatomic, strong) UILabel *periodLabel;//期限
@property (nonatomic, strong) UIImageView *periodBackgroundImageView;//图标
@property (nonatomic, strong) UIImageView *sealImageView;//盖章
@property (nonatomic, strong) UIView *bottomView;//下面的分割线
@property (nonatomic, strong) UIImageView *lineImageView;
//处理加息
@property (nonatomic, strong) NSDictionary *rateLeft;
@property (nonatomic, strong) NSDictionary *rateRight;

@end
@implementation WZBFinancialListRepaymentCell

#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViewConfigurations];
        [self initViews];
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
- (void)initViewConfigurations {
    
}

#pragma mark - initialize
- (void)initViews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.financialNameLabel];
    [self.contentView addSubview:self.lineImageView];
    [self.contentView addSubview:self.incomeRateTitleLabel];
    [self.contentView addSubview:self.incomeRateLabel];
    [self.contentView addSubview:self.percentageLabel];
    [self.contentView addSubview:self.periodLabel];
    [self.contentView addSubview:self.periodBackgroundImageView];
    [self.contentView addSubview:self.sealImageView];
    [self.contentView addSubview:self.bottomView];
}

- (void)initViewLayouts {
    [self.financialNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.height.equalTo(@19);
        make.top.equalTo(self.contentView.mas_top).offset(12);
    }];
    [self.incomeRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView.mas_centerX).offset(-8);
        make.height.equalTo(@13);
        make.width.equalTo(@120);
        make.top.equalTo(self.financialNameLabel.mas_bottom).offset(40);
    }];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(45);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    [self.incomeRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {//100%
        
        make.left.equalTo(self.incomeRateTitleLabel.mas_left).offset(7);
        make.height.equalTo(@20);
        //make.width.equalTo(@100);
        make.top.equalTo(self.incomeRateTitleLabel.mas_bottom).offset(15);
    }];
    
    [self.percentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {//100元
        
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(@13);
        make.width.equalTo(@90);
        make.centerY.equalTo(self.incomeRateTitleLabel.mas_centerY);
    }];
    [self.periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //期限
        make.height.equalTo(@16);
        make.width.equalTo(@80);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.incomeRateLabel.mas_centerY);
    }];
    [self.periodBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@56);
        make.width.equalTo(@56);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.financialNameLabel.mas_bottom).offset(35);
    }];
    [self.sealImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.contentView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@10);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}
#pragma mark - getter
- (void)dealRate:(NSDictionary *)data {
    NSString *s = @"%";
    NSString *original = kNSString(data, @"syl");
    NSString *name = kNSString(data, @"cpmc");
    if ([[NSString rateHikeIntercept:name] isEqualToString:@"NO"]) {
        self.incomeRateLabel.text = [NSString stringWithFormat:@"%.2lf%@", [data[@"syl"] doubleValue],s];
    } else {
        NSString *jiaxi = [NSString rateHikeIntercept:name];
        NSString *leftStr = [NSString stringWithFormat:@"%0.2lf",[original doubleValue]-[jiaxi doubleValue]];//总利率减去加的
        NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
        [mas appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%0.1lf%@",[leftStr doubleValue],s] attributes:self.rateLeft]];
        [mas appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"+%0.1lf%@",[jiaxi doubleValue],s] attributes:self.rateRight]];
        self.incomeRateLabel.attributedText = mas;
    }
}
- (void)configData:(NSDictionary *)data {
    self.financialNameLabel.text = [NSString interceptName:data[@"cpmc"]];
    [self dealRate:data];
    //***************************************************
    self.periodLabel.text = [NSString dayConversionMonth:[NSString stringWithFormat:@"%@",data[@"qx"]]];
    //***************************************************
    self.percentageLabel.text = [NSString stringWithFormat:@"%@元起投",data[@"qdje"]];
    if ([data[@"Zt"] isEqualToString:@"4"]) {
        _sealImageView.image = [UIImage imageNamed:@"financial_YHK"];
    } else if ([data[@"Zt"] isEqualToString:@"3"]) {
        _sealImageView.image = [UIImage imageNamed:@"financial_HKZ"];
    }
    [self.periodBackgroundImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[data[@"imgurl"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] placeholderImage:[UIImage imageNamed:@"car_logo"]];
}

#pragma mark - getters

- (UILabel *)financialNameLabel {
    if (!_financialNameLabel) {
        _financialNameLabel = [[UILabel alloc] init];
        _financialNameLabel.font = [UIFont systemFontOfSize:17];
        _financialNameLabel.textColor = KHexColor(0x999999);
        _financialNameLabel.adjustsFontSizeToFitWidth = YES;
        _financialNameLabel.text = @"车贷宝--期";
    }
    
    return _financialNameLabel;
}

- (UILabel *)incomeRateTitleLabel {
    if (!_incomeRateTitleLabel) {
        _incomeRateTitleLabel = [[UILabel alloc] init];
        _incomeRateTitleLabel.font = [UIFont systemFontOfSize:14];
        _incomeRateTitleLabel.textColor = KHexColor(0xcccccc);
        _incomeRateTitleLabel.text = @"预期年化收益率";
    }
    
    return _incomeRateTitleLabel;
}

- (UILabel *)incomeRateLabel {
    if (!_incomeRateLabel) {
        _incomeRateLabel = [[UILabel alloc] init];
        _incomeRateLabel.font = [UIFont systemFontOfSize:23];
        _incomeRateLabel.textColor = KHexColor(0xffaeae);
        _incomeRateLabel.text = @"--%";
    }
    
    return _incomeRateLabel;
}

- (UILabel *)percentageLabel {
    if (!_percentageLabel) {
        _percentageLabel = [[UILabel alloc] init];
        _percentageLabel.font = [UIFont systemFontOfSize:14];
        _percentageLabel.textColor = KHexColor(0xcccccc);
        _percentageLabel.textAlignment = NSTextAlignmentCenter;
        _percentageLabel.text = @"--元起投";
    }
    
    return _percentageLabel;
}

- (UILabel *)periodLabel {
    if (!_periodLabel) {
        _periodLabel = [[UILabel alloc] init];
        _periodLabel.font = [UIFont systemFontOfSize:14];
        _periodLabel.textColor = KHexColor(0xcccccc);
        _periodLabel.textAlignment = NSTextAlignmentCenter;
        _periodLabel.text = @"期限--天";
    }
    
    return _periodLabel;
}

- (UIImageView *)periodBackgroundImageView {
    if (!_periodBackgroundImageView) {
        _periodBackgroundImageView = [[UIImageView alloc] init];
        _periodBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _periodBackgroundImageView.clipsToBounds = YES;
        _periodBackgroundImageView.image = [UIImage imageNamed:@"car_logo"];
        //_periodBackgroundImageView.layer.cornerRadius = 28;
        //_periodBackgroundImageView.layer.borderWidth = 0.8;
        _periodBackgroundImageView.layer.borderColor = KHexColor(0xcccccc).CGColor;
    }
    
    return _periodBackgroundImageView;
}
- (UIImageView *)sealImageView {
    if (!_sealImageView) {
        _sealImageView = [[UIImageView alloc] init];
        _sealImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _sealImageView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = KGroundGeneral;
    }
    return _bottomView;
}
- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"financial_line"]];
        _lineImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _lineImageView;
}
- (NSDictionary *)rateLeft {
    if (!_rateLeft) {
        _rateLeft = @{NSForegroundColorAttributeName: KHexColor(0xffaeae), NSFontAttributeName: [UIFont systemFontOfSize:23]};
    }
    
    return _rateLeft;
}

- (NSDictionary *)rateRight {
    if (!_rateRight) {
        _rateRight = @{NSForegroundColorAttributeName: KHexColor(0xffaeae), NSFontAttributeName: [UIFont systemFontOfSize:17]};
    }
    
    return _rateRight;
}
@end
