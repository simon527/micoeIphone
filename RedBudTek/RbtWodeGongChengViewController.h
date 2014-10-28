//
//  RbWodeGongChengViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-16.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"
#import "RbtReShuiGongChengYuanLiTuViewController.h"
#import "RbtYuanChengKongZhiViewController.h"
#import "RbtShiShiViewController.h"
#import "RbtLiShiShuJuViewController.h"
#import "RbtJieNengViewController.h"
#import "RbtGisDingWeiViewController.h"


@interface RbtWodeGongChengViewController : RbtBaseViewController<UIScrollViewDelegate>
{
    UIScrollView *sc;
    
    RbtReShuiGongChengYuanLiTuViewController *yuanlituVC;
    RbtYuanChengKongZhiViewController *yuanchengVC;
    RbtShiShiViewController *shishiVC;
    RbtLiShiShuJuViewController *lishiVC;
    RbtJieNengViewController *jienengVC;
    RbtGisDingWeiViewController *dingweiVC;
    
    int tag;
}



@end
