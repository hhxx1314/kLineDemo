//
//  JRJTransactionLineView.m
//  JRJInvestAdviser
//
//  Created by jrj on 2018/3/5.
//  Copyright © 2018年 jrj. All rights reserved.
//

#import "JRJTransactionLineView.h"
#import "UIColor+ColorExtension.h"
#import "Enumeration.h"
#import "JRJTimeLineModelItem.h"
#import "UIBezierPath+TimeLine.h"

@implementation JRJTransactionLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftAndRightMargin = 10;
        self.backgroundColor = [UIColor whiteColor];
        self.tenLineView = [[UIView alloc] init];
        self.tenLineView.backgroundColor = [UIColor colorWithHEX:0x000000];
        [self addSubview:self.tenLineView];
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.backgroundColor = [UIColor colorWithHEX:0x333333];
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        self.timeLabel.textColor = [UIColor colorWithHEX:0xFFFFFF];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeLabel];
        self.transactionTenLineView = [[[NSBundle mainBundle] loadNibNamed:@"JRJTransactionTenlineView" owner:nil options:nil] firstObject];
        [self addSubview:self.transactionTenLineView];
        self.transactionTenLineView.hidden = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
        [self addGestureRecognizer:longPress];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //画边框线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat dash[] = {1,1.5};
    CGFloat dashMid[] = {4,4};
    for (int i = 0; i < 3; i++) {
        CGContextMoveToPoint(context, self.leftAndRightMargin, 10+175.f/4.f+175.f/4.f*i);
        CGContextAddLineToPoint(context, self.frame.size.width - self.leftAndRightMargin, 10+175.f/4.f+175.f/4.f*i);
        CGContextSetLineWidth(context, 1/[UIScreen mainScreen].scale);
        if (i == 1) {
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithHEX:0xD1D1D1].CGColor);
            CGContextSetLineDash(context, 0, dashMid, 2);
        }else{
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithHEX:0xE6E6E6].CGColor);
            CGContextSetLineDash(context, 0, dash, 2);
        }
        CGContextStrokePath(context);
    }
    CGContextSetLineDash(context, 0, dash, 0);
    
    for (int i = 0; i < 3; i++) {
        CGContextMoveToPoint(context, (self.frame.size.width - 20)/4.f+(self.frame.size.width - 20)/4.f*i, 10);
        CGContextAddLineToPoint(context, (self.frame.size.width - 20)/4.f+(self.frame.size.width - 20)/4.f*i, 185);
        CGContextSetLineWidth(context, 1/[UIScreen mainScreen].scale);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHEX:0xE6E6E6].CGColor);
        CGContextSetLineDash(context, 0, dash, 2);
        CGContextStrokePath(context);
    }
    CGContextSetLineDash(context, 0, dash, 0);
    
    for (int i = 0; i < 2; i++) {
        CGContextMoveToPoint(context, self.leftAndRightMargin, 10+175*i);
        CGContextAddLineToPoint(context,self.frame.size.width-self.leftAndRightMargin, 10+175*i);
        CGContextSetLineWidth(context, 0.5);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHEX:0xE6E6E6].CGColor);
        CGContextStrokePath(context);
    }
    
    for (int i = 0; i < 2; i++) {
        CGContextMoveToPoint(context, self.leftAndRightMargin+(self.frame.size.width-self.leftAndRightMargin*2)*i, 10);
        CGContextAddLineToPoint(context,self.leftAndRightMargin+(self.frame.size.width-self.leftAndRightMargin*2)*i, 185);
        CGContextSetLineWidth(context, 0.5);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHEX:0xE6E6E6].CGColor);
        CGContextStrokePath(context);
    }
    
    for (int i = 0; i < 2; i++) {
        CGContextMoveToPoint(context, self.leftAndRightMargin, 191+70*i);
        CGContextAddLineToPoint(context,self.frame.size.width-self.leftAndRightMargin, 191+70*i);
        CGContextSetLineWidth(context, 0.5);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHEX:0xE6E6E6].CGColor);
        CGContextStrokePath(context);
    }
    
    for (int i = 0; i < 2; i++) {
        CGContextMoveToPoint(context, self.leftAndRightMargin+(self.frame.size.width-self.leftAndRightMargin*2)*i, 191);
        CGContextAddLineToPoint(context,self.leftAndRightMargin+(self.frame.size.width-self.leftAndRightMargin*2)*i, 261);
        CGContextSetLineWidth(context, 0.5);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHEX:0xE6E6E6].CGColor);
        CGContextStrokePath(context);
    }
    
    for (int i = 0; i < 3; i++) {
        CGContextMoveToPoint(context, (self.frame.size.width - 20)/4.f+(self.frame.size.width - 20)/4.f*i, 191);
        CGContextAddLineToPoint(context, (self.frame.size.width - 20)/4.f+(self.frame.size.width - 20)/4.f*i, 261);
        CGContextSetLineWidth(context, 1/[UIScreen mainScreen].scale);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHEX:0xE6E6E6].CGColor);
        CGContextSetLineDash(context, 0, dash, 2);
        CGContextStrokePath(context);
    }
    CGContextSetLineDash(context, 0, dash, 0);
    
    // 大盘假数据
    NSString *maxString = [NSString stringWithFormat:@"3082.34"];
    NSString *midString = [NSString stringWithFormat:@"3021.90"];
    NSString *minString = [NSString stringWithFormat:@"2961.46"];
    NSString *maxRate = nil;
    NSString *minRate = nil;
    if (stockYestClosePrice > 0) {
        maxRate = [NSString stringWithFormat:@"%.2f%%",(CGFloat)(timeLine_maxPrice-stockYestClosePrice)/stockYestClosePrice*100];
        minRate = [NSString stringWithFormat:@"%.2f%%",(CGFloat)(timeLine_minPrice-stockYestClosePrice)/stockYestClosePrice*100];
    } else {
        maxRate = @"";
        minRate = @"";
    }
    
    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);
    UIFont *font = [UIFont systemFontOfSize:12];
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.alignment = NSTextAlignmentLeft;
    NSMutableParagraphStyle *textRightStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textRightStyle.alignment = NSTextAlignmentRight;
    
    [maxString drawInRect:CGRectMake(self.leftAndRightMargin+2.5, 12.5, 50, 15) withAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888],NSFontAttributeName:font,NSParagraphStyleAttributeName:textStyle}];
    [midString drawInRect:CGRectMake(self.leftAndRightMargin+2.5, 185-87.5-17.5, 50, 15) withAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888],NSFontAttributeName:font,NSParagraphStyleAttributeName:textStyle}];
    [minString drawInRect:CGRectMake(self.leftAndRightMargin+2.5, 185-17.5, 50, 15) withAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888],NSFontAttributeName:font,NSParagraphStyleAttributeName:textStyle}];
    [maxRate drawInRect:CGRectMake(self.frame.size.width-10-50-2.5, 12.5, 50, 15) withAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0xF54949],NSFontAttributeName:font,NSParagraphStyleAttributeName:textRightStyle}];
    [minRate drawInRect:CGRectMake(self.frame.size.width-10-50-2.5, 185-17.5, 50, 15) withAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x00B267],NSFontAttributeName:font,NSParagraphStyleAttributeName:textRightStyle}];
    
    NSArray *arr_timelines = [self timeLineArray];
    UIBezierPath *timeline = [UIBezierPath bezierPath];
    [timeline drawTranstionDayTimeLine:CGSizeMake(self.frame.size.width-20, 185) timeLineArray:arr_timelines transtionArray:self.transtionArray]; //画异动图
    
    CGFloat timeline_line_width = (self.frame.size.width - 20)/241;
    for (NSInteger index = 0; index < arr_timelines.count; index++) {//画成交量图
        JRJTimeLineModelItem *item = arr_timelines[index];
        CGFloat left_margin = timeline_line_width * item.item_id + timeline_line_width / 2 + 10;
        UIBezierPath *path_bar = [self timelineTradeVolumePath:item leftMargin:left_margin lineWidth:timeline_line_width chartHeight:70 drawTop:191 maxValue:timeLine_maxVolume minValue:0];
        UIColor *color;
        if (rand()%2) {
            color = [UIColor colorWithHEX:0xFF4040];
        } else {
            color = [UIColor colorWithHEX:0x26be6a];
        }
        [color setStroke];
        [path_bar stroke];
    }
}


/**
 分时图 假数据
 */
- (NSMutableArray *)timeLineArray {
    NSMutableArray *timeArr = [NSMutableArray array];
    float lastPX = 3021;
    float lastVolume = timeLine_maxVolume/2;
    for (int i = 0; i < 241; i ++) {
        JRJTimeLineModelItem * timeModel = [[JRJTimeLineModelItem alloc] init];
        timeModel.item_id = i;
        timeModel.time = @"time";
        timeModel.lastPx = lastPX + rand()%7 - 3;
        timeModel.avgPx = 3021;
        timeModel.tradeVolume = lastVolume + rand()%5 - 2;
        [timeArr addObject:timeModel];
        lastPX = timeModel.lastPx;
        lastVolume = timeModel.tradeVolume;
    }
    return timeArr;
}

/**
 成交量图
 @param barItem 分时图Item   JRJTimeLineModelItem
 */
- (UIBezierPath *)timelineTradeVolumePath:(JRJTimeLineModelItem *)barItem
                               leftMargin:(CGFloat)leftMargin
                                lineWidth:(CGFloat)lineWidth
                              chartHeight:(CGFloat)chartHeight
                                  drawTop:(CGFloat)top
                                 maxValue:(CGFloat)maxValue
                                 minValue:(CGFloat)minValue
{
    CGFloat min_max_gap = maxValue - minValue;
    CGFloat bar_left = leftMargin;
    CGFloat bar_top = (maxValue - [barItem tradeVolume] + minValue) / min_max_gap * chartHeight + top;
    CGFloat bar_height = ([barItem tradeVolume] - minValue) / min_max_gap * chartHeight;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = lineWidth * 0.9;
    path.lineJoinStyle = kCGLineJoinRound;
    if (min_max_gap > 0) {
        [path moveToPoint:CGPointMake(bar_left, bar_top)];
        [path addLineToPoint:CGPointMake(bar_left, bar_top + bar_height)];
    }
    return path;
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)longPress
{
    UIGestureRecognizerState state = longPress.state;
    
    switch (state) {
        case UIGestureRecognizerStatePossible: {
            
            break;
        }
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            if (state == UIGestureRecognizerStateBegan) {
            }
            CGPoint point = [longPress locationInView:self];
            if (point.x < 10 || point.x > self.frame.size.width-10) {
                return;
            }
            int index = (point.x-10)/((APPScreenWidth-20)/241.f);
            NSArray *arr_timelines = [self timeLineArray];
            if (index >= arr_timelines.count) {
                return;
            }
            self.tenLineView.frame = CGRectMake(point.x-0.5, 10, 1, 175);
            self.tenLineView.hidden = NO;
            self.timeLabel.frame = CGRectMake(point.x- 17, 185, 34, 14);
            JRJTimeLineModelItem *item = arr_timelines[index];
            if (item.time.length >= 4) {
                self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",[item.time substringWithRange:NSMakeRange(0, 2)],[item.time substringWithRange:NSMakeRange(2, 2)]];
            }
            self.timeLabel.hidden = NO;
            
            CGFloat y = [[UIBezierPath bezierPath] pixelYForPerPrice:item.lastPx maxPrice:timeLine_maxPrice minPrice:timeLine_minPrice gridHeight:185];
            if (y+68>185) {
                y = 185-137;
            }else if (y-68<10) {
                y = 10;
            }else{
                y = y-68;
            }
            if (point.x < self.frame.size.width/2) {
                self.transactionTenLineView.frame = CGRectMake(point.x+5, y, 120, 137);
            }else{
                self.transactionTenLineView.frame = CGRectMake(point.x-5-120, y, 120, 137);
            }
            for (int i = 0; i < self.transtionArray.count; i++) {
                NSDictionary *dic = self.transtionArray[i];
                int number = [dic[@"id"] intValue];
                if (number == index) {
                    // 赋值
                    self.transactionTenLineView.priceLabel.text = [NSString stringWithFormat:@"%.2f",item.lastPx];
                    if ((item.lastPx-stockYestClosePrice)/stockYestClosePrice > 0) {
                        self.transactionTenLineView.upOrdownLabel.text = [NSString stringWithFormat:@"+%.2f",(item.lastPx-stockYestClosePrice)/stockYestClosePrice*100];
                        self.transactionTenLineView.upOrdownLabel.textColor = [UIColor colorWithHEX:0xF54949];
                    }else{
                        self.transactionTenLineView.upOrdownLabel.text = [NSString stringWithFormat:@"%.2f",(item.lastPx-stockYestClosePrice)/stockYestClosePrice*100];
                        self.transactionTenLineView.upOrdownLabel.textColor = [UIColor colorWithHEX:0x00B267];
                    }
                    [self.transactionTenLineView updateWithData:dic];
                    self.transactionTenLineView.hidden = NO;
                    return;
                }
            }
            self.transactionTenLineView.hidden = YES;
            break;
        }
        case UIGestureRecognizerStateEnded: {
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            break;
        }
        case UIGestureRecognizerStateFailed: {
            
            break;
        }
        default: {
            break;
        }
    }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    if (self.tenLineView.hidden == NO) {
        self.tenLineView.hidden = YES;
        self.timeLabel.hidden = YES;
        self.transactionTenLineView.hidden = YES;
        return;
    }
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    if (self.tenLineView.hidden == YES) {
        
    }else{
        CGPoint point = [pan locationInView:self];
        if (point.x < 10 || point.x > self.frame.size.width-10) {
            return;
        }
        int index = (point.x-10)/((APPScreenWidth-20)/241.f);
        NSArray *arr_timelines = [self timeLineArray];
        if (index >= arr_timelines.count) {
            return;
        }
        self.tenLineView.frame = CGRectMake(point.x-0.5, 10, 1, 175);
        self.tenLineView.hidden = NO;
        self.timeLabel.frame = CGRectMake(point.x- 17, 185, 34, 14);
        JRJTimeLineModelItem *item = arr_timelines[index];
        if (item.time.length >= 4) {
            self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",[item.time substringWithRange:NSMakeRange(0, 2)],[item.time substringWithRange:NSMakeRange(2, 2)]];
        }
        self.timeLabel.hidden = NO;
        CGFloat y = [[UIBezierPath bezierPath] pixelYForPerPrice:item.lastPx maxPrice:timeLine_maxPrice minPrice:timeLine_minPrice gridHeight:185];
        if (y+68>185) {
            y = 185-150;
        }else if (y-68<10) {
            y = 10;
        }else{
            y = y-68;
        }
        if (point.x < self.frame.size.width/2) {
            self.transactionTenLineView.frame = CGRectMake(point.x+5, y, 140, 150);
        } else {
            self.transactionTenLineView.frame = CGRectMake(point.x-5-140, y, 140, 150);
        }
        for (int i = 0; i < self.transtionArray.count; i++) {
            NSDictionary *dic = self.transtionArray[i];
            int number = [dic[@"id"] intValue];
            if (number == index) {
                // 赋值
                self.transactionTenLineView.priceLabel.text = [NSString stringWithFormat:@"%.2f",item.lastPx];
                if ((item.lastPx-stockYestClosePrice)/stockYestClosePrice > 0) {
                    self.transactionTenLineView.upOrdownLabel.text = [NSString stringWithFormat:@"+%.2f%%",(item.lastPx-stockYestClosePrice)/stockYestClosePrice*100];
                    self.transactionTenLineView.upOrdownLabel.textColor = [UIColor colorWithHEX:0xF54949];
                }else{
                    self.transactionTenLineView.upOrdownLabel.text = [NSString stringWithFormat:@"%.2f%%",(item.lastPx-stockYestClosePrice)/stockYestClosePrice*100];
                    self.transactionTenLineView.upOrdownLabel.textColor = [UIColor colorWithHEX:0x00B267];
                }
                [self.transactionTenLineView updateWithData:dic];
                self.transactionTenLineView.hidden = NO;
                return;
            }
        }
        self.transactionTenLineView.hidden = YES;
    }
}

@end
