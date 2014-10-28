//
//  RbtWenTiFanKuiListViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"
#import "TQMultistageTableView.h"
#import "RbtTabViewController.h"

@interface RbtWenTiFanKuiListViewController : RbtTabViewController<TQTableViewDataSource,TQTableViewDelegate>

@property (nonatomic ,strong) TQMultistageTableView *mTableView;
@property (nonatomic ,strong) NSArray *arr_wenTiList;
@property (nonatomic,strong) NSMutableArray *arr_cellDetail;

@end
