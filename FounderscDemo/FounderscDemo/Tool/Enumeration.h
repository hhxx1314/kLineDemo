//
//  Enumeration.h
//  FounderscDemo
//
//  Created by jrj on 2018/6/15.
//  Copyright © 2018年 JRJ. All rights reserved.
//

#ifndef Enumeration_h
#define Enumeration_h



#define WeakSelf            __weak __typeof(self) weakSelf = self
#define APPScreenWidth      [[UIScreen mainScreen] bounds].size.width
#define APPScreenHeight     [[UIScreen mainScreen] bounds].size.height


/**
 大盘假数据
 */
#define timeLine_maxVolume           100
#define timeLine_maxPrice            3062
#define timeLine_minPrice            2960
#define stockYestClosePrice          3000

#endif /* Enumeration_h */
