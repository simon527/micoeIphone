//
//  RbtGeDiGongChengViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"
#import "TSLocateView.h"
#import "EGORefreshTableHeaderView.h"
#import <MapKit/MapKit.h>

@interface RbtGeDiGongChengViewController : RbtBaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EGORefreshTableHeaderDelegate,MKMapViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    UIView *_refreshFooterView;
    UIActivityIndicatorView *_activityView;
    BOOL _reloading;
    BOOL isMore;
}

@property(strong,nonatomic) UIView *kehuleixing_XialaView;
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *arr_Projects;
@property(strong,nonatomic) NSMutableArray *arr_OriginProjects;
@property(strong,nonatomic) UISearchBar *searchBar;
@property(strong,nonatomic) NSMutableArray *arr_LiuLanProjects;
@property(assign,nonatomic) BOOL isLishijilu;
@property(assign,nonatomic) NSInteger h;
@property (nonatomic,strong)MKMapView *myMapView;
@property(nonatomic,copy) NSString *gonggProjectPid;

@property(strong,nonatomic) TSLocateView *citySheetView;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;


@end
