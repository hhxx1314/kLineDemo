//
//  JRJIndexPlateExchangeCell.m
//  JRJInvestAdviser
//
//  Created by jrj on 2018/3/6.
//  Copyright © 2018年 jrj. All rights reserved.
//

#import "JRJIndexPlateExchangeCell.h"
#import "UIColor+ColorExtension.h"
#import "Enumeration.h"

@implementation JRJIndexPlateExchangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (APPScreenWidth < 375) {
        self.firstNameLabel.font = [UIFont systemFontOfSize:10];
        self.firstRateLabel.font = [UIFont systemFontOfSize:10];
        self.secondNameLabel.font = [UIFont systemFontOfSize:10];
        self.secondRateLabel.font = [UIFont systemFontOfSize:10];
        self.thirdNameLabel.font = [UIFont systemFontOfSize:10];
        self.thirdRateLabel.font = [UIFont systemFontOfSize:10];
        self.forthNameLabel.font = [UIFont systemFontOfSize:10];
        self.forthRateLabel.font = [UIFont systemFontOfSize:10];
        self.plateNameLabel.font = [UIFont systemFontOfSize:15];
    }
}

- (void)configCellWithDic:(NSDictionary *)dic isTop:(BOOL)isTopFlag {
    self.myDic = dic;
    if (isTopFlag) {
        self.redCircleImageView.image = [UIImage imageNamed:@"shakeDiagnoseStock_redPoint"];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = [NSNumber numberWithFloat:1.0f];
        animation.toValue = [NSNumber numberWithFloat:0.3f];
        animation.autoreverses = YES;
        animation.duration = 1;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        long randomNum = random();
        [self.redCircleImageView.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%ld",randomNum]];
    } else {
        self.redCircleImageView.image = [UIImage imageNamed:@"shakeDiagnoseStock_grayPoint"];
    }
    
    self.bottomBackView.hidden = YES;
    NSString *timeStr = [dic[@"time"] stringValue];
    if (timeStr.length == 5) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"Hmmss"];
        NSDate *date = [dateFormatter dateFromString:[dic[@"time"] stringValue]];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"H:mm"];
        NSString *time = [dateFormatter1 stringFromDate:date];
        self.timeLabel.text = time;
    } else if (timeStr.length == 6) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HHmmss"];
        NSDate *date = [dateFormatter dateFromString:[dic[@"time"] stringValue]];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"HH:mm"];
        NSString *time = [dateFormatter1 stringFromDate:date];
        self.timeLabel.text = time;
    } else {
        
    }

    NSNumber *platZdf = dic[@"platZdf"];
    NSString *ydInfo = [NSString stringWithFormat:@"%@  ",dic[@"ydInfo"]];
    NSMutableAttributedString *plateAttribute = [[NSMutableAttributedString alloc] initWithString:ydInfo attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHEX:0x333333]}];
    NSMutableAttributedString *plateLinkStr = [[NSMutableAttributedString alloc] initWithString:[self rateToString:platZdf] attributes:@{NSForegroundColorAttributeName:[self rateColor:platZdf]}];
    [plateAttribute appendAttributedString:plateLinkStr];
    self.plateNameLabel.attributedText = plateAttribute;
    
    UITapGestureRecognizer *plateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPlate)];
    [self.plateNameLabel addGestureRecognizer:plateTap];
    self.plateNameLabel.userInteractionEnabled = YES;
    NSArray *stockInfos = dic[@"stockInfos"];
    if (stockInfos.count > 0) {
        NSDictionary *firstDic = stockInfos[0];
        self.firstNameLabel.text = firstDic[@"stockName"];
        
        NSNumber *firstRate = firstDic[@"zdf"];
        self.firstRateLabel.text = [self rateToString:firstRate];
        self.firstRateLabel.textColor = [self rateColor:firstRate];
        self.firstBackView.layer.borderColor = [UIColor colorWithHEX:0xDBDBDB].CGColor;
        self.firstBackView.layer.borderWidth = 0.5;
        self.firstStockCode = firstDic[@"stockCode"];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        [self.firstBackView addGestureRecognizer:tap1];
    }
    if (stockInfos.count > 1) {
        NSDictionary *secondDic = stockInfos[1];
        self.secondNameLabel.text = secondDic[@"stockName"];
        
        NSNumber *secondRate = secondDic[@"zdf"];
        self.secondRateLabel.text = [self rateToString:secondRate];
        self.secondRateLabel.textColor = [self rateColor:secondRate];
        self.secondBackView.layer.borderColor = [UIColor colorWithHEX:0xDBDBDB].CGColor;
        self.secondBackView.layer.borderWidth = 0.5;
        self.secondStockCode = secondDic[@"stockCode"];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
        [self.secondBackView addGestureRecognizer:tap2];
    }
    if (stockInfos.count > 2) {
        self.bottomBackView.hidden = NO;
        NSDictionary *thirdDic = stockInfos[2];
        self.thirdNameLabel.text = thirdDic[@"stockName"];
        
        NSNumber *thirdRate = thirdDic[@"zdf"];
        self.thirdRateLabel.text = [self rateToString:thirdRate];
        self.thirdRateLabel.textColor = [self rateColor:thirdRate];
        self.thirdBackView.layer.borderColor = [UIColor colorWithHEX:0xDBDBDB].CGColor;
        self.thirdBackView.layer.borderWidth = 0.5;
        self.thirdStockCode = thirdDic[@"stockCode"];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3)];
        [self.thirdBackView addGestureRecognizer:tap3];
    }
    if (stockInfos.count > 3) {
        NSDictionary *forthDic = stockInfos[3];
        self.forthNameLabel.text = forthDic[@"stockName"];
        
        NSNumber *forthRate = forthDic[@"zdf"];
        self.forthRateLabel.text = [self rateToString:forthRate];
        self.forthRateLabel.textColor = [self rateColor:forthRate];
        self.forthBackView.layer.borderColor = [UIColor colorWithHEX:0xDBDBDB].CGColor;
        self.forthBackView.layer.borderWidth = 0.5;
        self.forthStockCode = forthDic[@"stockCode"];
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4)];
        [self.forthBackView addGestureRecognizer:tap4];
    }
}

- (UIColor *)rateColor:(NSNumber *)rate {
    if (rate.floatValue > 0) {
        return [UIColor colorWithHEX:0xF54949];
    } else if (rate.floatValue < 0) {
        return [UIColor colorWithHEX:0x00B267];
    } else {
        return [UIColor colorWithHEX:0x888888];
    }
}

- (NSString *)rateToString:(NSNumber *)rate {
    if (rate.floatValue > 0) {
        return [NSString stringWithFormat:@"+%.2f%%",rate.floatValue];
    } else if (rate.floatValue < 0) {
        return [NSString stringWithFormat:@"%.2f%%",rate.floatValue];
    } else {
        return @"0.00%";
    }
}

- (void)tap1 {
    WeakSelf;
    if (self.pushBlock) {
        self.pushBlock(weakSelf.firstStockCode);
    }
}

- (void)tap2 {
    WeakSelf;
    if (self.pushBlock) {
        self.pushBlock(weakSelf.secondStockCode);
    }
}

- (void)tap3 {
    WeakSelf;
    if (self.pushBlock) {
        self.pushBlock(weakSelf.thirdStockCode);
    }
}

- (void)tap4 {
    WeakSelf;
    if (self.pushBlock) {
        self.pushBlock(weakSelf.forthStockCode);
    }
}

- (void)pushPlate {
    WeakSelf;
    if (self.pushPlateBlock) {
        self.pushPlateBlock(weakSelf.myDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
