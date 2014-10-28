//
//  RbtTabViewController.h
//  RedBudTek
//
//  Created by Simon on 13-11-28.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"
//#import "RbtWodeGongChengViewController.h"
//#import "RbtWenTiFanKuiListViewController.h"
//#import "RbtAnLiJiGongSiJianJieViewController.h"
//#import "RbtSettingViewController.h"
#import "RbtTabbarView.h"

@interface RbtTabViewController : RbtBaseViewController
{
    int showViewTag;
//    
//    RbtWodeGongChengViewController *wodeGongChengVc;
//    RbtWenTiFanKuiListViewController *wenTiVc;
//    RbtAnLiJiGongSiJianJieViewController *anliVc;
//    RbtSettingViewController *settingVc;
    
    NSMutableArray *controllersArray;
}

@property (strong, nonatomic) UIButton *btn_wodegongcheng;

@property (strong, nonatomic) UIButton *btn_wentifankui;

@property (strong, nonatomic) UIButton *btn_sijimuge;

@property (strong, nonatomic) UIButton *btn_shezhi;

@property (strong, nonatomic) RbtTabbarView *customTabbar;

-(void)setTabbarHidden:(BOOL)isHidden;

@end
