//
//  micJieNengShiTu.h
//  micoe(ipad)
//
//  Created by Simon on 14-1-17.
//  Copyright (c) 2014年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "micWDGCView.h"


@interface micJieNengShiTu : micWDGCView
{
    UILabel *timeLabel;
    UILabel *titleLbel;
    UILabel *showLabel;
    UILabel *unitLabel;
    
    UIButton *btn_jireqi;
    UIButton *btn_leijijianpai;
    UIButton *btn_leijijieyue;
    
    UIActionSheet *actionSheet;
    
    NSString *chooseType;
    NSString *chooseTime;
    
    UIButton *btn_week;
    UIButton *btn_month;
    UIButton *btn_year;
}

@end
