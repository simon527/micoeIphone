//
//  RbtJieNengViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtTabViewController.h"

@interface RbtJieNengViewController : RbtTabViewController<UIActionSheetDelegate>
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
    
}

-(void)postData;

@end
