//
//  JRJTransactionTenlineView.m
//  JRJInvestAdviser
//
//  Created by Blank on 2018/3/6.
//  Copyright © 2018年 jrj. All rights reserved.
//

#import "JRJTransactionTenlineView.h"
#import "Enumeration.h"
#import "UIColor+ColorExtension.h"
@implementation JRJTransactionTenlineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.lineHeightLayout.constant = 1/[UIScreen mainScreen].scale;
//    WeakSelf;
//    [self.nameLabel addTapGestureWithActionBlock:^(UIGestureRecognizer *gestrue) {
//        if (weakSelf.data) {
//            [JRJVCJumpCenterSharedObject showGaiNianOrHangYeInduCode:weakSelf.data[@"platCode"] induName:weakSelf.data[@"platName"] plateType:[weakSelf.data[@"platType"] integerValue]];
//        }
//    }];
//    [self.firstStockNameLabel addTapGestureWithActionBlock:^(UIGestureRecognizer *gestrue) {
//        if (weakSelf.data) {
//            NSArray *arr = weakSelf.data[@"stockInfos"];
//            if (arr.count > 0) {
//                NSDictionary *dic = arr[0];
//                [App_Delegate.TopVC showStockWithCode:dic[@"stockCode"] name:nil];
//
//            }
//        }
//    }];
//    [self.secondStockNameLabel addTapGestureWithActionBlock:^(UIGestureRecognizer *gestrue) {
//        if (weakSelf.data) {
//            NSArray *arr = weakSelf.data[@"stockInfos"];
//            if (arr.count > 1) {
//                NSDictionary *dic = arr[1];
//                [App_Delegate.TopVC showStockWithCode:dic[@"stockCode"] name:nil];
//            }
//        }
//    }];
}

- (void)updateWithData:(NSDictionary *)dic
{
    self.data = dic;
    self.nameLabel.text = dic[@"ydInfo"];
    if ([dic[@"platZdf"] floatValue] > 0) {
        self.plateUpOrDownLabel.textColor = [UIColor colorWithHEX:0xF54949];
        self.plateUpOrDownLabel.text = [NSString stringWithFormat:@"+%.2f%%",[dic[@"platZdf"] floatValue]];
    }else{
        self.plateUpOrDownLabel.textColor = [UIColor colorWithHEX:0x00B267];
        self.plateUpOrDownLabel.text = [NSString stringWithFormat:@"%.2f%%",[dic[@"platZdf"] floatValue]];
    }
    NSArray *arr = dic[@"stockInfos"];
    if (arr.count >= 2) {
        NSDictionary *firstDic = arr[0];
        NSDictionary *secondDic = arr[1];
        self.firstStockNameLabel.text = firstDic[@"stockName"];
        self.secondStockNameLabel.text = secondDic[@"stockName"];
        if ([firstDic[@"zdf"] floatValue] > 0) {
            self.firstRateLabel.textColor = [UIColor colorWithHEX:0xF54949];
            self.firstRateLabel.text = [NSString stringWithFormat:@"+%.2f%%",[firstDic[@"zdf"] floatValue]];
        }else{
            self.firstRateLabel.textColor = [UIColor colorWithHEX:0x00B267];
            self.firstRateLabel.text = [NSString stringWithFormat:@"%.2f%%",[firstDic[@"zdf"] floatValue]];
        }
        if ([secondDic[@"zdf"] floatValue] > 0) {
            self.secondRateLabel.textColor = [UIColor colorWithHEX:0xF54949];
            self.secondRateLabel.text = [NSString stringWithFormat:@"+%.2f%%",[secondDic[@"zdf"] floatValue]];
        }else{
            self.secondRateLabel.textColor = [UIColor colorWithHEX:0x00B267];
            self.secondRateLabel.text = [NSString stringWithFormat:@"%.2f%%",[secondDic[@"zdf"] floatValue]];
        }
    }
}

@end
