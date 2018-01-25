//
//  WZBFinancialListTableViewCell.m
//  Wzbao
//
//  Created by wangwei on 16/10/2.
//  Copyright © 2016年 WZBaoWW. All rights reserved.
//

#import "WZBFinancialListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WZBFinancialListTableViewCell()

@property (nonatomic, strong) UILabel *financialNameLabel;//名字
@property (nonatomic, strong) UILabel *incomeRateTitleLabel;//预期年化
@property (nonatomic, strong) UILabel *incomeRateLabel;//年化百分比
@property (nonatomic, strong) UILabel *percentageLabel;//100元投
@property (nonatomic, strong) UILabel *periodLabel;//期限
@property (nonatomic, strong) UIImageView *periodBackgroundImageView;
//@property (nonatomic, strong) CCCircleView *rateView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIScrollView *backView;//新手红包icon

@property (nonatomic, strong) UIButton *buyView;//购买
//@property (nonatomic, strong) UILabel *buyLabel;//购买
@property (nonatomic, strong) UIProgressView *progress;//购买进度
@property (nonatomic, strong) UILabel *scheduleProgress;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *lineImageView;
//处理加息
@property (nonatomic, strong) NSDictionary *rateLeft;
@property (nonatomic, strong) NSDictionary *rateRight;
@end
@implementation WZBFinancialListTableViewCell

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
    self.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - initialize
- (void)initViews {
    [self.contentView addSubview:self.financialNameLabel];
    [self.contentView addSubview:self.lineImageView];
    [self.contentView addSubview:self.incomeRateTitleLabel];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.incomeRateLabel];
    [self.contentView addSubview:self.percentageLabel];
    [self.contentView addSubview:self.periodLabel];
    //[self.contentView addSubview:self.rateView];
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.progress];
    [self.contentView addSubview:self.scheduleProgress];
    [self.contentView addSubview:self.buyView];
    //[self.contentView addSubview:self.buyLabel];
    [self.contentView addSubview:self.bottomView];
}

- (void)initViewLayouts {
    //@weakify(self)
    [self.financialNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.height.equalTo(@19);
        make.top.equalTo(self.contentView.mas_top).offset(12);
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.left.equalTo(self.financialNameLabel.mas_right).offset(5);
        make.centerY.equalTo(self.financialNameLabel.mas_centerY).offset(1);
        make.height.equalTo(@40);
        make.right.equalTo(@0);
    }];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.equalTo(self.contentView.mas_top).offset(45);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.height.equalTo(@56);
        make.width.equalTo(@56);
        make.top.equalTo(self.financialNameLabel.mas_bottom).offset(35);
    }];
    [self.incomeRateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.centerX.equalTo(self.contentView.mas_centerX).offset(-8);
        make.height.equalTo(@13);
        make.width.equalTo(@120);
        make.top.equalTo(self.financialNameLabel.mas_bottom).offset(40);
    }];
    [self.incomeRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {//100%
        //
        make.left.equalTo(self.incomeRateTitleLabel.mas_left).offset(7);
        make.height.equalTo(@20);
        //make.width.equalTo(@100);
        make.top.equalTo(self.incomeRateTitleLabel.mas_bottom).offset(15);
    }];
    
    [self.percentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {//100元
        //
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(@13);
        make.width.equalTo(@90);
        make.centerY.equalTo(self.incomeRateTitleLabel.mas_centerY);
    }];
    [self.periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        ////期限
        make.height.equalTo(@16);
        make.width.equalTo(@80);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.incomeRateLabel.mas_centerY);
    }];
    [self.scheduleProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(@20);
    }];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.height.equalTo(@2.1);
        make.right.equalTo(self.scheduleProgress.mas_left).offset(-5);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(19);
    }];
   
    [self.buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.equalTo(self.contentView).multipliedBy(0.83);
        make.top.equalTo(self.progress.mas_bottom).offset(18);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

#pragma mark - actions
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
    self.percentageLabel.text = [NSString stringWithFormat:@"%@元起投",data[@"qdje"]];
    self.periodLabel.text = [NSString dayConversionMonth:[NSString stringWithFormat:@"%@",data[@"qx"]]];
    NSString *str = [NSString stringWithFormat:@"%@",data[@"ytje"]];
    if ([str isEqualToString:@"<null>"]) {
        CGFloat b = 0.0;
        CGFloat a = [[NSString stringWithFormat:@"%@",data[@"cpje"]] floatValue];//产品金额
        double progress = b/a;
        if (progress>=1.0) {
            self.progress.progress = 1.0;
            self.scheduleProgress.text = @"进度100%";
        } else {
            self.progress.progress = progress;
            NSString *str = @"%";
            self.scheduleProgress.text = [NSString stringWithFormat:@"进度%0.2f%@",progress*100,str];
        }
    } else {
        CGFloat b = [[NSString stringWithFormat:@"%@",data[@"ytje"]] floatValue];
        CGFloat a = [[NSString stringWithFormat:@"%@",data[@"cpje"]] floatValue];//产品金额
        double progress = b/a;
        if (progress>=1.0) {
            self.progress.progress = 1.0;
            self.scheduleProgress.text = @"进度100%";
        } else {
            self.progress.progress = progress;
            NSString *str = @"%";
            self.scheduleProgress.text = [NSString stringWithFormat:@"进度%0.2f%@",progress*100 ,str];
        }
    }
    NSURL *calUrl = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",data[@"imgurl"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.iconImageView sd_setImageWithURL:calUrl placeholderImage:[UIImage imageNamed:@"car_logo"]];
    NSString *tagStr = [NSString stringWithFormat:@"%@",data[@"xszm"]];
    if ([tagStr isKindOfClass:[NSNull class]]||[tagStr isEqualToString:@"0"]) {
        [self.backView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    } else {
        [self.backView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        //NSArray *arr = [tagStr componentsSeparatedByString:@","];
        NSArray *arr = @[@"1"];
        [self createIcon:arr];
    }
}
- (void)createIcon:(NSArray *)tagArr{
    for (NSInteger a = 0; a <tagArr.count; a++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(a*30+a*5, 11, 30, 16);
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"fianacial%ld",[tagArr[a] integerValue]]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.backView.contentSize = CGSizeMake(40*a, 40);
        [self.backView addSubview:imageView];
    }
}
- (void)FinancialClick:(UIButton *)button {
    if (self.buyBlock) {
        self.buyBlock();
    }
}
#pragma mark - getters

- (UILabel *)financialNameLabel {
    if (!_financialNameLabel) {
        _financialNameLabel = [[UILabel alloc] init];
        _financialNameLabel.font = [UIFont systemFontOfSize:17];
        _financialNameLabel.textColor = KHexColor(0x333333);
        _financialNameLabel.adjustsFontSizeToFitWidth = YES;
        _financialNameLabel.text = @"车贷宝--期";
    }
    
    return _financialNameLabel;
}

- (UILabel *)incomeRateTitleLabel {
    if (!_incomeRateTitleLabel) {
        _incomeRateTitleLabel = [[UILabel alloc] init];
        _incomeRateTitleLabel.font = [UIFont systemFontOfSize:14];
        _incomeRateTitleLabel.textColor = KHexColor(0x666666);
        _incomeRateTitleLabel.text = @"预期年化收益率";
    }
    
    return _incomeRateTitleLabel;
}

- (UILabel *)incomeRateLabel {
    if (!_incomeRateLabel) {
        _incomeRateLabel = [[UILabel alloc] init];
        _incomeRateLabel.font = [UIFont systemFontOfSize:23];
        _incomeRateLabel.textColor = Kback;
        _incomeRateLabel.text = @"--%";
    }
    
    return _incomeRateLabel;
}

- (UILabel *)percentageLabel {
    if (!_percentageLabel) {
        _percentageLabel = [[UILabel alloc] init];
        _percentageLabel.font = [UIFont systemFontOfSize:14];
        _percentageLabel.textColor = KHexColor(0x666666);
        _percentageLabel.textAlignment = NSTextAlignmentRight;
        _percentageLabel.text = @"--元起投";
    }
    
    return _percentageLabel;
}

- (UILabel *)periodLabel {
    if (!_periodLabel) {
        _periodLabel = [[UILabel alloc] init];
        _periodLabel.font = [UIFont systemFontOfSize:14];
        _periodLabel.textColor = KHexColor(0xf23f3f);
        _periodLabel.textAlignment = NSTextAlignmentRight;
        _periodLabel.text = @"期限100天";
    }
    
    return _periodLabel;
}

- (UIImageView *)periodBackgroundImageView {
    if (!_periodBackgroundImageView) {
        _periodBackgroundImageView = [[UIImageView alloc] init];
        _periodBackgroundImageView.image = [UIImage imageNamed:@"WZB_JXZ.png"];
        _periodBackgroundImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    return _periodBackgroundImageView;
}
- (UIScrollView *)backView {
    if (!_backView) {
        _backView = [[UIScrollView alloc] init];
        _backView.backgroundColor = kClearColor;
    }
    return _backView;
}
//- (CCCircleView *)rateView {
//    if (!_rateView) {
//        _rateView = [[CCCircleView alloc] initWithFrame:CGRectMake(self.frame.size.width-22, 50, 50, 50)];
//    }
//    return _rateView;
//}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = KGroundGeneral;
    }
    return _bottomView;
}
- (UIButton *)buyView {
    if (!_buyView) {
        _buyView = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyView.layer.cornerRadius = 6;
        [_buyView setBackgroundColor:Kback];
        [_buyView setTitle:@"立即投资" forState:UIControlStateNormal];
        _buyView.titleLabel.font = kFont(15);
        [_buyView addTarget:self action:@selector(FinancialClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyView;
}
- (UIProgressView *)progress {
    if (!_progress) {
        _progress = [[UIProgressView alloc] init];
        _progress.progressTintColor = KHexColor(0xf23f3f);
        _progress.trackTintColor = KHexColor(0xffe8e8);
    }
    return _progress;
}
- (UILabel *)scheduleProgress {
    if (!_scheduleProgress) {
        _scheduleProgress = [[UILabel alloc] init];
        _scheduleProgress.text = @"进度0.0%";
        _scheduleProgress.font = kFont(12);
        _scheduleProgress.textColor = KHexColor(0x666666);
    }
    return _scheduleProgress;
}
//- (UILabel *)buyLabel {
//    if (!_buyLabel) {
//        _buyLabel = [[UILabel alloc] init];
//        _buyLabel.textColor = [UIColor whiteColor];
//        _buyLabel.font = kBoldFont(15);
//        _buyLabel.text = @"立即投资";
//    }
//    return _buyLabel;
//}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.image = [UIImage imageNamed:@"car_logo"];
        //_iconImageView.layer.cornerRadius = 28;
        //_iconImageView.layer.borderWidth = 0.8;
        _iconImageView.layer.borderColor = KHexColor(0xcccccc).CGColor;
    }
    return _iconImageView;
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
        _rateLeft = @{NSForegroundColorAttributeName: Kback, NSFontAttributeName: [UIFont systemFontOfSize:25]};
    }
    
    return _rateLeft;
}

- (NSDictionary *)rateRight {
    if (!_rateRight) {
        _rateRight = @{NSForegroundColorAttributeName: [UIColor yellowColor], NSFontAttributeName: [UIFont systemFontOfSize:18]};
    }
    
    return _rateRight;
}
@end
