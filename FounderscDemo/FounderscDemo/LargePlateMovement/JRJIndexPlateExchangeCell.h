//
//  JRJIndexPlateExchangeCell.h
//  JRJInvestAdviser
//
//  Created by jrj on 2018/3/6.
//  Copyright © 2018年 jrj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRJIndexPlateExchangeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *plateNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *redCircleImageView;

@property (weak, nonatomic) IBOutlet UIView *firstBackView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstRateLabel;

@property (weak, nonatomic) IBOutlet UIView *secondBackView;
@property (weak, nonatomic) IBOutlet UILabel *secondNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondRateLabel;

@property (weak, nonatomic) IBOutlet UIView *thirdBackView;
@property (weak, nonatomic) IBOutlet UILabel *thirdNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdRateLabel;

@property (weak, nonatomic) IBOutlet UIView *forthBackView;
@property (weak, nonatomic) IBOutlet UILabel *forthNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *forthRateLabel;

@property (nonatomic, strong) NSString *firstStockCode;
@property (nonatomic, strong) NSString *secondStockCode;
@property (nonatomic, strong) NSString *thirdStockCode;
@property (nonatomic, strong) NSString *forthStockCode;

@property (weak, nonatomic) IBOutlet UIView *bottomBackView;

@property (nonatomic, strong)NSDictionary *myDic;

@property void (^pushBlock)(NSString *stockCode);
@property void (^pushPlateBlock)(NSDictionary *dic);
- (void)configCellWithDic:(NSDictionary *)dic isTop:(BOOL)isTopFlag;
@end
