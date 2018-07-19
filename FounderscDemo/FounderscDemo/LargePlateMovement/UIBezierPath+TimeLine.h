//
//  UIBezierPath+TimeLine.h
//  FounderscDemo
//
//  Created by jrj on 2018/6/19.
//  Copyright © 2018年 JRJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRJTimeLineModelItem.h"

@interface UIBezierPath (TimeLine)

- (void)drawTranstionDayTimeLine:(CGSize)gridSize timeLineArray:(NSArray *)timeLineArr transtionArray:(NSArray *)transtionArr;

//根据价格获取对应的Y坐标
- (CGFloat)pixelYForPerPrice:(CGFloat)price
                    maxPrice:(CGFloat)maxPrice
                    minPrice:(CGFloat)minPrice
                  gridHeight:(CGFloat)height;

//根据价格获取对应的X坐标
- (CGFloat)pixelXForTranstionPerPrice:(int32_t)itemId
                            gridWidth:(CGFloat)width;
@end
