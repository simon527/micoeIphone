//
//  RbtTianQiYuBaoViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-12.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"

@interface RbtTianQiYuBaoViewController : RbtBaseViewController

@property (strong,nonatomic) NSDictionary *weatherInfo;
@property (assign,nonatomic) BOOL isShouYe;
@property (strong,nonatomic) NSString *xiaBiao;
@property (assign,nonatomic) BOOL isFirstJia;

- (void)initViews;
- (void)initViewswithBaidu;

@end
