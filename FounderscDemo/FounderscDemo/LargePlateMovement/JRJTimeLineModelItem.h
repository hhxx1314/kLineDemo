//
//  JRJTimeLineModelItem.h
//  FounderscDemo
//
//  Created by jrj on 2018/6/19.
//  Copyright © 2018年 JRJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRJTimeLineModelItem : NSObject

//分时的id
@property (assign, nonatomic) int item_id;
//时间
@property (strong, nonatomic) NSString *time;
///当前价
@property (assign, nonatomic) float lastPx;
///均价
@property (assign, nonatomic) float avgPx;
///成交量
@property (assign, nonatomic) float tradeVolume;
///成交额
@property (assign, nonatomic) float tradeValue;

@end
