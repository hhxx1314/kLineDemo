//
//  JRJTransactionTenlineView.h
//  JRJInvestAdviser
//
//  Created by Blank on 2018/3/6.
//  Copyright © 2018年 jrj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRJTransactionTenlineView : UIView

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *upOrdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *plateUpOrDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstStockNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondStockNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondRateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightLayout;


@property (nonatomic,strong)NSDictionary *data;

- (void)updateWithData:(NSDictionary *)dic;

@end
