//
//  RbtLiShiShuJuViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtTabViewController.h"
#import "RbtDataOfResponse.h"
#import "FYChartView.h"

@interface RbtLiShiShuJuViewController : RbtTabViewController <UIActionSheetDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource,FYChartViewDataSource, FYChartViewDelegate>
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
    //总的数据数组
    NSMutableArray *xxtimeArray;
    NSMutableArray *values;
    
    int scCount;
    
    NSString *danw;
    
    FYChartView *chartView;
    
    UIButton *weekBtn;
    UIButton *monthBtn;
    UIButton *yearBtn;
    
    UIButton *lbBtn;
    UIButton *xxtBtn;
    
}

-(void)lnButtonClicked;

-(void)xxtButtonClicked;

-(void)timeButtonWithName:(NSString *)name;

-(void)typeButtonWithIndex:(NSString *)index;

@end
