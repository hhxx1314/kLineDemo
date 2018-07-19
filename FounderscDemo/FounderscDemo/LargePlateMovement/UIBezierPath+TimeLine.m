//
//  UIBezierPath+TimeLine.m
//  FounderscDemo
//
//  Created by jrj on 2018/6/19.
//  Copyright © 2018年 JRJ. All rights reserved.
//

#import "UIBezierPath+TimeLine.h"
#import "UIColor+ColorExtension.h"
#import "Enumeration.h"

@implementation UIBezierPath (TimeLine)

+ (UIBezierPath *)strokeLinePath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1.;
    path.lineJoinStyle = kCGLineJoinRound;
    return path;
}

-(void)strokeWithColor:(UIColor *)color
{
    if (color) {
        [color setStroke];
    }
    [self stroke];
}

- (void)fillWithColor:(UIColor *)color
{
    if (color) {
        [color setFill];
    }
    [self fill];
}

- (void)drawLinesWithPoints:(NSArray *)points
{
    BOOL isFirst = FALSE;
    for (NSValue *pointValue in points) {
        if (!isFirst) {
            isFirst = TRUE;
            [self moveToPoint:[pointValue CGPointValue]];
        } else {
            [self addLineToPoint:[pointValue CGPointValue]];
        }
    }
}


/**
 大盘异动图
 @param timeLineArr 分时数组
 @param transtionArr 异动数组
 */
- (void)drawTranstionDayTimeLine:(CGSize)gridSize timeLineArray:(NSArray *)timeLineArr transtionArray:(NSArray *)transtionArr
{
    if (!timeLineArr) {
        return;
    }
    JRJTimeLineModelItem *last_valid_model = nil;
    NSArray *arr_current_group = timeLineArr;
    
    NSMutableArray *pricePoints = [NSMutableArray arrayWithCapacity:arr_current_group.count];
    
    for (NSInteger index = 0; index < arr_current_group.count; index++) {
        JRJTimeLineModelItem *current_timeline = arr_current_group[index];
            last_valid_model = current_timeline;
            CGFloat current_price = current_timeline.lastPx;
            CGFloat x_axis = [self pixelXForTranstionPerPrice:current_timeline.item_id gridWidth:gridSize.width];
        CGFloat y_axis = [self pixelYForPerPrice:current_price maxPrice:timeLine_maxPrice minPrice:timeLine_minPrice gridHeight:gridSize.height];
            [pricePoints addObject:[NSValue valueWithCGPoint:CGPointMake(x_axis, y_axis)]];
    }
    
    UIBezierPath *path_price = [UIBezierPath strokeLinePath];
    UIBezierPath *shadow_path = [UIBezierPath strokeLinePath];
    
    
    [path_price drawLinesWithPoints:pricePoints];
    [shadow_path drawLinesWithPoints:pricePoints];
    
    
    
    CGFloat x_axis_last = [self pixelXForTranstionPerPrice:last_valid_model.item_id gridWidth:gridSize.width];
    
    [shadow_path addLineToPoint:CGPointMake(x_axis_last, gridSize.height)];
    [shadow_path addLineToPoint:CGPointMake(10, gridSize.height)];
    [shadow_path closePath];
    
    [shadow_path fillWithColor:[[UIColor colorWithHEX:0x8EDAFF] colorWithAlphaComponent:.2]];
    ///绘制当前价走势
    [path_price strokeWithColor:[UIColor colorWithHEX:0x08A9F9]];
    
    UIFont *font = [UIFont systemFontOfSize:10];
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.alignment = NSTextAlignmentCenter;
    int number = 0;
    
    NSMutableArray *newTranstactionArr = [NSMutableArray array];
    for (int i = 0; i < transtionArr.count; i++) {
        NSDictionary *dic = transtionArr[i];
        int sfjx = [dic[@"sfjx"] intValue];
        if (sfjx == 1) {
            [newTranstactionArr addObject:dic];
        }
    }

    for (int i = 0; i < newTranstactionArr.count; i++) {
        NSDictionary *dic = newTranstactionArr[i];
        NSString *platName = dic[@"platName"];
        int index = [dic[@"id"] intValue];
        int color = [dic[@"color"] intValue];
        if (arr_current_group.count <= index) {
            continue;
        }
        JRJTimeLineModelItem *current_timeline = arr_current_group[index];
        CGFloat current_price = current_timeline.lastPx;
        CGFloat y_axis = [self pixelYForPerPrice:current_price maxPrice:timeLine_maxPrice minPrice:timeLine_minPrice gridHeight:gridSize.height];
        NSString *imageName;
        NSString *borderImageStr;
        UIColor *textColor;
        float height;
        float borderHeight;
        float textHeight;
        float widthLeft = (int)(9+(gridSize.width)/241.f*index);
        if (number%2 != 0) {
            height = y_axis-17;
            borderHeight = y_axis-35;
            textHeight = y_axis-31;
            if (color == 1) {
                if (y_axis-35 > 10) {
                    imageName = @"red_up";
                    height = y_axis-17;
                    borderHeight = y_axis-35;
                    textHeight = y_axis-31;
                }else{
                    imageName = @"red_down";
                    height = y_axis;
                    borderHeight = y_axis+15;
                    textHeight = y_axis+19;
                }
                borderImageStr = @"red_border";
                textColor = [UIColor colorWithHEX:0xF54949];
                if (i == 0) {
                    borderImageStr = @"red_high";
                    textColor = [UIColor colorWithHEX:0xFFFFFF];
                }
            }else{
                if (y_axis+35 <= 185) {
                    imageName = @"green_up";
                    height = y_axis-17;
                    borderHeight = y_axis-35;
                    textHeight = y_axis-31;
                }else{
                    imageName = @"green_down";
                    height = y_axis;
                    borderHeight = y_axis+15;
                    textHeight = y_axis+19;
                }
                borderImageStr = @"green_border";
                textColor = [UIColor colorWithHEX:0x00B267];
                if (i == 0) {
                    borderImageStr = @"green_high";
                    textColor = [UIColor colorWithHEX:0xFFFFFF];
                }
            }
        }else{
            height = y_axis;
            borderHeight = y_axis+15;
            textHeight = y_axis+19;
            if (color == 1) {
                if (y_axis+35 > 185) {
                    imageName = @"red_up";
                    height = y_axis-17;
                    borderHeight = y_axis-35;
                    textHeight = y_axis-31;
                }else{
                    imageName = @"red_down";
                    height = y_axis;
                    borderHeight = y_axis+15;
                    textHeight = y_axis+19;
                }
                borderImageStr = @"red_border";
                textColor = [UIColor colorWithHEX:0xF54949];
                if (i == 0) {
                    borderImageStr = @"red_high";
                    textColor = [UIColor colorWithHEX:0xFFFFFF];
                }
            }else{
                if (y_axis-35 <= 10) {
                    imageName = @"green_up";
                    height = y_axis-17;
                    borderHeight = y_axis-35;
                    textHeight = y_axis-31;
                }else{
                    imageName = @"green_down";
                    height = y_axis;
                    borderHeight = y_axis+15;
                    textHeight = y_axis+19;
                }
                borderImageStr = @"green_border";
                textColor = [UIColor colorWithHEX:0x00B267];
                if (i == 0) {
                    borderImageStr = @"green_high";
                    textColor = [UIColor colorWithHEX:0xFFFFFF];
                }
            }
        }


        if (9+(gridSize.width)/241.f*index + 10*platName.length+15 > gridSize.width-10) {
            widthLeft = 9+gridSize.width - (10*platName.length+15);
        }
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *borderImage = [[UIImage imageNamed:borderImageStr] resizableImageWithCapInsets:UIEdgeInsetsMake(4.0, 4.0, 4.0, 4.0)];
        borderHeight = (int)borderHeight;
        textHeight = (int)textHeight;
        [image drawInRect:CGRectMake(10+(gridSize.width)/241.f*index-4, height, 8, 18.5)];
        [borderImage drawInRect:CGRectMake(widthLeft, borderHeight, 10*platName.length+15, 20)];
        [platName drawInRect:CGRectMake(widthLeft, textHeight, 10*platName.length+15, 12) withAttributes:@{NSForegroundColorAttributeName: textColor,NSFontAttributeName:font,NSParagraphStyleAttributeName:textStyle}];
        number++;
    }
}

//根据价格获取对应的X坐标
- (CGFloat)pixelXForTranstionPerPrice:(int32_t)itemId
                            gridWidth:(CGFloat)width
{
    return width/241 * itemId +10;
}

//根据价格获取对应的Y坐标
- (CGFloat)pixelYForPerPrice:(CGFloat)price
                    maxPrice:(CGFloat)maxPrice
                    minPrice:(CGFloat)minPrice
                  gridHeight:(CGFloat)height
{
    CGFloat timeline_height = height - 20;
    CGFloat max_min_gap = maxPrice - minPrice;
    if (max_min_gap <= 0.00001 && max_min_gap >= -0.0001) {
        return 10;
    }
    return (maxPrice - price) / max_min_gap * timeline_height + 10+1;
}

@end
