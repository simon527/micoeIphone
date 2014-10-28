//
//  RbtReShuiGongChengYuanLiTuViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"
#import "RbtTabViewController.h"
#import "RbtYLT903-I-H.h"
#import "RbtYLT903-I-V.h"
#import "RbtYLT903-II-H.h"
#import "RbtYLT903-II-V.h"
#import "RbtYLT905-H.h"
#import "RbtYLT905-V.h"
#import "RbtYLT906-H.h"
#import "RbtYLT906-V.h"
#import "RbtYLT906-H-2.h"
#import "RbtYLT906-V-2.h"


@interface RbtReShuiGongChengYuanLiTuViewController : RbtTabViewController
{
    
    float IphoneGap;
    
    RbtYLT903_I_V *YLT903_I_V;
    RbtYLT903_I_H *YLT903_I_H;
    
    RbtYLT903_II_V *YLT903_II_V;
    RbtYLT903_II_H *YLT903_II_H;
    
    RbtYLT905_V *YLT905_V;
    RbtYLT905_H *YLT905_H;
    
    RbtYLT906_V *YLT906_V;
    RbtYLT906_H *YLT906_H;
    
    RbtYLT906_V_2 *YLT906_V_2;
    RbtYLT906_H_2 *YLT906_H_2;
    
    int viewTag;
    
    NSTimer *timer;
}

@property (strong, nonatomic) NSString *yltName;

@property (strong, nonatomic) NSDictionary *yltDic;

@end
