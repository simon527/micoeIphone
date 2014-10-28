//
//  micLiShiShuJuView_h.h
//  micoe(ipad)
//
//  Created by Simon_Tang on 14-4-21.
//  Copyright (c) 2014年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RbtDataOfResponse.h"
#import "FYChartView.h"
#import "micWDGCView.h"

@interface micLiShiShuJuView_h : micWDGCView<UIActionSheetDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, FYChartViewDelegate, FYChartViewDataSource>
{
    UILabel *timeLabel;
    UIActionSheet *actionSheet;
    NSString *chooseTime;
    NSString *chooseName;
    
    UITableView *dataTabelView;
    UIScrollView *sc;
    
    int shebeiCount;
    NSMutableArray *shebeiArray;
    
    int numOfRow;
    NSMutableArray *timeArray;
    NSMutableArray *dataArray;
    
    int scCount;
    
    NSString *danw;
    
    FYChartView *chartView;
    NSArray *values;
    
    //    UIImageView *shadowImageView;
    UIButton *weekBtn;
    UIButton *monthBtn;
    UIButton *yearBtn;
    
    UIButton *lbBtn;
    UIButton *xxtBtn;
}

-(void)lnButtonClicked;

-(void)xxtButtonClicked;

@end
