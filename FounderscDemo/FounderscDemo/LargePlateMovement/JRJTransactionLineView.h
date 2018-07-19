//
//  JRJTransactionLineView.h
//  JRJInvestAdviser
//
//  Created by jrj on 2018/3/5.
//  Copyright © 2018年 jrj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRJTransactionTenlineView.h"

@interface JRJTransactionLineView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *transtionArray;

@property (nonatomic, assign) int leftAndRightMargin;

@property (nonatomic, strong) UIView *tenLineView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) JRJTransactionTenlineView *transactionTenLineView;

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end
