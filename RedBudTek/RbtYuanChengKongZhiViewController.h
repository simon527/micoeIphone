//
//  RbtYuanChengKongZhiViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtTabViewController.h"
#import "RbtYckzDsView.h"
#import "RbtYuanChengSelectView.h"

@interface RbtYuanChengKongZhiViewController : RbtTabViewController

@property(strong,nonatomic) UILabel *lab_controlModel;

@property(strong,nonatomic) RbtYckzDsView *ssDsView;
@property(strong,nonatomic) RbtYckzDsView *jrDsView;
@property(strong,nonatomic) RbtYuanChengSelectView *ssSelectView;
@property(strong,nonatomic) RbtYuanChengSelectView *jrSelectView;
@property(strong,nonatomic) UIScrollView *sbSelectView;
@property(strong,nonatomic) UILabel *lab_ssDsinfo;
@property(strong,nonatomic) UILabel *lab_jrDsinfo;

@property(strong,nonatomic) NSString *startTime1_ss;
@property(strong,nonatomic) NSString *endTime1_ss;
@property(strong,nonatomic) NSString *startTime2_ss;
@property(strong,nonatomic) NSString *endTime2_ss;
@property(strong,nonatomic) NSString *startTime3_ss;
@property(strong,nonatomic) NSString *endTime3_ss;


@property(strong,nonatomic) NSString *startTime1_jr;
@property(strong,nonatomic) NSString *endTime1_jr;
@property(strong,nonatomic) NSString *startTime2_jr;
@property(strong,nonatomic) NSString *endTime2_jr;
@property(strong,nonatomic) NSString *startTime3_jr;
@property(strong,nonatomic) NSString *endTime3_jr;

@end
