//
//  RbtSettingViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"
#import "RbtXiuGaiMiMaViewController.h"
#import "RbtLoginViewController.h"

@interface RbtSettingViewController : RbtBaseViewController
{
    UIButton *zhanghaozhuxiao;
    UIButton *banbenhao;
    UIButton *xiugaimima;
    UIButton *serviceURL;
}

@property (strong, nonatomic) RbtXiuGaiMiMaViewController *xiugaimimaController;
@property (strong, nonatomic) RbtLoginViewController *lg;

@end
