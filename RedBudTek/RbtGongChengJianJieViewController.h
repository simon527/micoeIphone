//
//  RbtGongChengJianJieViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

//    NSLog(@"潢川大帅哥");

#import "RbtBaseViewController.h"

@interface RbtGongChengJianJieViewController : RbtBaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    BOOL row2BtnClicked;
    UILabel *jieshaoLabel;
    float labelHeight;
}

@property (strong, nonatomic) UITableView *gcTableView;

@end
