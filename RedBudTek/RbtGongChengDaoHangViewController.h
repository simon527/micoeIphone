//
//  RbtGongChengDaoHangViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"
#import "RbtWodeGongChengViewController.h"
#import "RbtWenTiFanKuiViewController.h"
#import "RbtTianQiYuBaoViewController.h"
#import "RbtSettingViewController.h"
#import "RbtGisDingWeiViewController.h"
@class RbtTabbarView;


@interface RbtGongChengDaoHangViewController : RbtBaseViewController
{
    int showViewTag;
    RbtWodeGongChengViewController *wodeGongChengVc;
    RbtWenTiFanKuiViewController *wenTiVc;
    RbtTianQiYuBaoViewController *anliVc;
    RbtSettingViewController *settingVc;
    
    UIImageView *customTabbar;

}

@property (strong, nonatomic) NSMutableArray *controllersArray;

@property (strong, nonatomic) NSMutableArray *imagesArray;
@property (strong, nonatomic) NSMutableArray *selectImagesArray;

@property (strong, nonatomic) NSMutableArray *tabBarButtonsArray;

@property (strong, nonatomic) RbtGisDingWeiViewController *gisVc;

@property (strong, nonatomic) UIButton *btn_wodegongcheng;

@property (strong, nonatomic) UIButton *btn_wentifankui;

@property (strong, nonatomic) UIButton *btn_sijimuge;

@property (strong, nonatomic) UIButton *btn_shezhi;
@property (strong, nonatomic) RbtTabbarView *tabView;
@property (strong,nonatomic) NSString *jsonString;


@end
