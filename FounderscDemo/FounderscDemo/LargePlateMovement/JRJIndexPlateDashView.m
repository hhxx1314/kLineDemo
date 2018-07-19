//
//  JRJIndexPlateDashView.m
//  JRJInvestAdviser
//
//  Created by jrj on 2018/3/7.
//  Copyright © 2018年 jrj. All rights reserved.
//

#import "JRJIndexPlateDashView.h"
#import "UIColor+ColorExtension.h"

@implementation JRJIndexPlateDashView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat dash[] = {1,1.5};
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, self.bounds.size.height);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHEX:0xB3B3B3].CGColor);
    CGContextSetLineDash(context, 0, dash, 2);
    CGContextStrokePath(context);
}

@end
