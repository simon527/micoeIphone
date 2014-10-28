//
//  RbtGeDiGongChengViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtGeDiGongChengViewController.h"
#import "RbtGongChengJianJieViewController.h"
#import "RbtProjectInfoModel.h"
#import "MyAnnotation.h"

@interface RbtGeDiGongChengViewController ()<UISearchBarDelegate,UIActionSheetDelegate,UISearchDisplayDelegate>

@end

@implementation RbtGeDiGongChengViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self mapViewAddPointAnnotation];
}

-(void)viewWillDisappear:(BOOL)animated {
    self.kehuleixing_XialaView.hidden = YES;
    [self.citySheetView dismissWithClickedButtonIndex:0 animated:NO];
     [super viewWillDisappear:animated];
}

- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([RbtCommonTool getJinRuMode] == WoDeGongCheng) {
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        backButton.frame = CGRectMake(0, 0, 24, 44);
//        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        
//        self.navigationItem.leftBarButtonItem = backBar;
//        
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setImage:[UIImage imageNamed:@"backbar"] forState:UIControlStateNormal];
//        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        backButton.frame = CGRectMake(0, 0, 24, 44);
//        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        
//        self.navigationItem.leftBarButtonItem = backBar;
    }
    
    isMore = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setTitle:@"各地工程"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:20],UITextAttributeFont, nil]];

//    self.searchBar = [[UISearchBar alloc] init];
//    self.searchBar.frame = CGRectMake(60, 0, 120, 40);
//    self.searchBar.delegate = self;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"searchBtn"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 40, 40);
    searchBtn.tag = 301;
    [searchBtn addTarget:self action:@selector(showSearchBar) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = searchBarItem;

    self.arr_Projects =[[NSMutableArray alloc] init];
    if ([RbtCommonTool getJinRuMode] == WoDeGongCheng) {
        self.arr_OriginProjects =[RbtCommonModel sharedInstance].arr_myProject;
    }
    else if([RbtCommonTool getJinRuMode] == GongGGC){
        self.arr_OriginProjects = [RbtCommonModel sharedInstance].arr_publicProject;
    }
    else if ([RbtCommonTool getJinRuMode] == LiXianGongCheng)
    {
        self.arr_OriginProjects = [RbtCommonModel sharedInstance].arr_liXianProject;
    }
    
    [self setCityIndexTable];
    
    self.arr_LiuLanProjects = [[NSMutableArray alloc] init];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[RbtCommonTool liuLanFilePath]]) {
        self.arr_LiuLanProjects = [NSKeyedUnarchiver unarchiveObjectWithFile:[RbtCommonTool liuLanFilePath]];
    }
    
    if (self.isLishijilu) {
        self.arr_Projects = self.arr_LiuLanProjects;
    }
    else{
        self.arr_Projects = self.arr_OriginProjects;
    }

    self.h = [self.arr_OriginProjects count]/100;
    if (self.h>0) {
        isMore = YES;
    }
    [self initViews];
//    [self.view addSubview:self.hud1];
}

- (void)setCityIndexTable{
    NSMutableArray *arr_state = [[NSMutableArray alloc] init];
    [arr_state addObject:@"全国"];
    for (int i = 0; [self.arr_OriginProjects count]>i; i++) {
        RbtProjectModel *oneModel = [self.arr_OriginProjects objectAtIndex:i];
        NSString *cityString = oneModel.city;
        NSArray *arr = [cityString componentsSeparatedByString:@","];
        if ([arr count] == 2) {
            if (![arr_state containsObject:[arr objectAtIndex:0]] ) {
                [arr_state addObject:[arr objectAtIndex:0]];
            }
        }
    }

    NSMutableArray *arr_Allcity = [[NSMutableArray alloc] init];
    for (int x = 0; [arr_state count]>x; x++) {
         NSMutableDictionary *dic_Procity = [[NSMutableDictionary alloc] init];
        [dic_Procity setObject:[arr_state objectAtIndex:x] forKey:@"State"];
        NSMutableArray *arr_city = [[NSMutableArray alloc] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"city", nil], nil];
        for (int i = 0; [self.arr_OriginProjects count]>i; i++) {
            RbtProjectModel *oneModel = [self.arr_OriginProjects objectAtIndex:i];
            NSString *cityString = oneModel.city;
            NSArray *arr = [cityString componentsSeparatedByString:@","];
            if ([arr count] == 2) {
                if ([(NSString *)[arr_state objectAtIndex:x] isEqualToString:(NSString *)[arr objectAtIndex:0]] ) {
                    BOOL isHasCity = NO;
//                    NSLog(@"arr_city = %@",arr_city);
                    for (int y = 0; [arr_city count]>y; y++) {
                        if ([(NSString *)[(NSDictionary *)[arr_city objectAtIndex:y] objectForKey:@"city"] isEqualToString:(NSString *) [arr objectAtIndex:1]]) {
                            isHasCity = YES;
                            break;
                        }
                    }
                    if (!isHasCity) {
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[arr objectAtIndex:1],@"city", nil];
                        [arr_city addObject:dic];
                    }
                }
            }
        }
        [dic_Procity setObject:arr_city forKey:@"Cities"];
        [arr_Allcity addObject:dic_Procity];
    }
    [RbtCommonTool setProvincesAndCities:arr_Allcity];
}

- (void)initViews{
    UIButton *btn_Kehuleixing = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Kehuleixing.frame = CGRectMake(0, 64, 80, 36);
    [btn_Kehuleixing setBackgroundImage:[UIImage imageNamed:@"gehuleixing"] forState:UIControlStateNormal];
    [btn_Kehuleixing setBackgroundImage:[UIImage imageNamed:@"gehuleixing_pressed"] forState:UIControlStateSelected];
    NSAttributedString *btn_KehuleixingTitle = [[NSAttributedString alloc] initWithString:@"客户类型" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    [btn_Kehuleixing setAttributedTitle:btn_KehuleixingTitle forState:UIControlStateNormal];
    btn_Kehuleixing.tag = 101;
    [btn_Kehuleixing addTarget:self action:@selector(daoHangBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Kehuleixing];
    
    UIButton *btn_Chengshisuoying = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Chengshisuoying.frame = CGRectMake(80, 64, 80, 36);
    [btn_Chengshisuoying setBackgroundImage:[UIImage imageNamed:@"chengshisuoying"] forState:UIControlStateNormal];
    [btn_Chengshisuoying setBackgroundImage:[UIImage imageNamed:@"chengshisuoying_on"] forState:UIControlStateSelected];
    NSAttributedString *btn_ChengshisuoyingTitle = [[NSAttributedString alloc] initWithString:@"城市索引" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    [btn_Chengshisuoying setAttributedTitle:btn_ChengshisuoyingTitle forState:UIControlStateNormal];
    btn_Chengshisuoying.tag = 102;
    [btn_Chengshisuoying addTarget:self action:@selector(daoHangBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Chengshisuoying];
    
    UIButton *btn_Ditusuoying = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Ditusuoying.frame = CGRectMake(80*2, 64, 80, 36);
    [btn_Ditusuoying setBackgroundImage:[UIImage imageNamed:@"ditusuoyin"] forState:UIControlStateNormal];
    [btn_Ditusuoying setBackgroundImage:[UIImage imageNamed:@"ditusuoyin_on"] forState:UIControlStateSelected];
    NSAttributedString *btn_DitusuoyingTitle = [[NSAttributedString alloc] initWithString:@"地图索引" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    [btn_Ditusuoying setAttributedTitle:btn_DitusuoyingTitle forState:UIControlStateNormal];
    btn_Ditusuoying.tag = 103;
    [btn_Ditusuoying addTarget:self action:@selector(daoHangBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Ditusuoying];
    
    UIButton *btn_Liulanjilu = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Liulanjilu.frame = CGRectMake(80*3, 64, 80, 36);
    [btn_Liulanjilu setBackgroundImage:[UIImage imageNamed:@"liulanjilu"] forState:UIControlStateNormal];
    [btn_Liulanjilu setBackgroundImage:[UIImage imageNamed:@"liulanjilu_on"] forState:UIControlStateSelected];
    NSAttributedString *btn_LiulanjiluTitle = [[NSAttributedString alloc] initWithString:@"浏览记录" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    [btn_Liulanjilu setAttributedTitle:btn_LiulanjiluTitle forState:UIControlStateNormal];
    btn_Liulanjilu.tag = 104;
    [btn_Liulanjilu addTarget:self action:@selector(daoHangBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Liulanjilu];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, ScreenHeight-100)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    if ([RbtCommonTool getJinRuMode] == WoDeGongCheng) {
        if (_refreshHeaderView == nil) {
            
            EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
            view.delegate = self;
            [self.tableView addSubview:view];
            _refreshHeaderView = view;
        }
        
        //  update the last update date
        [_refreshHeaderView refreshLastUpdatedDate];
    }
    
    self.myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 100, 320, ScreenHeight-100)];
    self.myMapView.mapType = MKMapTypeStandard;
    self.myMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.myMapView.delegate = self;
    CLLocationCoordinate2D center;
    center.latitude = 39.910;
    center.longitude = 106.404;
    MKCoordinateSpan span;
    span = MKCoordinateSpanMake(40.0, 50.0);
    MKCoordinateRegion regionCenter = MKCoordinateRegionMake(center, span);
    self.myMapView.region = regionCenter;
    self.myMapView.hidden = YES;
    [self.view addSubview:self.myMapView];
    
    self.kehuleixing_XialaView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+36, 80, 149)];
    [self initkehuleixing_XialaView];
    self.kehuleixing_XialaView.hidden = YES;
    [self.view addSubview:self.kehuleixing_XialaView];
    
    if (([RbtUserModel sharedInstance].userName== nil)||[[RbtUserModel sharedInstance].userName length]<1) {
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            UIView *maskView = [[UIView alloc] init];
            maskView.backgroundColor = [UIColor blackColor];
            maskView.alpha = 0.5;
            maskView.frame = CGRectMake(0, 64, 320, 36);
            [self.view addSubview:maskView];
        }
    }
    else{
        if (self.isLishijilu) {
            [btn_Liulanjilu setSelected:YES];
        }
        else{
            [btn_Kehuleixing setSelected:YES];
        }
    }
}

- (void)initkehuleixing_XialaView{
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pull-down_kehuleixing_background"]];
    bg.frame = CGRectMake(0, 0, 80, 149);
    [self.kehuleixing_XialaView addSubview:bg];
    
    for (int i = 201; i<207; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, (i-201)*25, 80, 25);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"kehuleixing_%d",i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(kehuleixing_XialaViewBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.kehuleixing_XialaView addSubview:btn];
    }
}

- (void)mapViewAddPointAnnotation{
    for (RbtProjectModel *oneModel in self.arr_OriginProjects) {
        CLLocationCoordinate2D center;
        center.latitude = (double)[oneModel.latitude doubleValue];
        center.longitude = (double)[oneModel.longitude doubleValue];
        MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:center
                                            title:oneModel.name
                                         subTitle:oneModel.city];
        [self.myMapView addAnnotation:annotation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- actions
- (void)daoHangBtnPressed:(UIButton *)sender{
    if (sender.tag == 101) {
        self.kehuleixing_XialaView.hidden = NO;
        [self.citySheetView dismissWithClickedButtonIndex:0 animated:NO];
        self.myMapView.hidden = YES;
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
        self.citySheetView = nil;
    }
    else if (sender.tag == 102)
    {
        self.kehuleixing_XialaView.hidden = YES;
        [self changeBackBtnKehuleixing];
        if (!self.citySheetView) {
            self.citySheetView = [[TSLocateView alloc] initWithTitle:@"城市索引" delegate:self];
            [self.citySheetView showInView:self.view];
        }
        self.myMapView.hidden = YES;
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
    }
    else if (sender.tag == 103)
    {
        self.kehuleixing_XialaView.hidden = YES;
        [self changeBackBtnKehuleixing];
        [self.citySheetView dismissWithClickedButtonIndex:0 animated:NO];
        self.myMapView.hidden = NO;
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
        self.citySheetView = nil;
    }
    else if (sender.tag == 104)
    {
        self.kehuleixing_XialaView.hidden = YES;
        [self changeBackBtnKehuleixing];
        self.arr_Projects = self.arr_LiuLanProjects;
        [self.tableView reloadData];
        [self.citySheetView dismissWithClickedButtonIndex:0 animated:NO];
         self.myMapView.hidden = YES;
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
        self.citySheetView = nil;
    }
    UIButton *btn101 =  (UIButton *)[self.view viewWithTag:101];
    [btn101 setSelected:NO];
    UIButton *btn102 =  (UIButton *)[self.view viewWithTag:102];
    [btn102 setSelected:NO];
    UIButton *btn103 =  (UIButton *)[self.view viewWithTag:103];
    [btn103 setSelected:NO];
    UIButton *btn104 =  (UIButton *)[self.view viewWithTag:104];
    [btn104 setSelected:NO];
    sender.selected = YES;
    
    [self hiddenSearchBar];
}

- (void)changeBackBtnKehuleixing{
    UIButton *btn101 =  (UIButton *)[self.view viewWithTag:101];
    NSAttributedString *btn_KehuleixingTitle = [[NSAttributedString alloc] initWithString:@"客户类型" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    [btn101 setAttributedTitle:btn_KehuleixingTitle forState:UIControlStateNormal];
    [btn101 setAttributedTitle:btn_KehuleixingTitle forState:UIControlStateSelected];
}

- (void)kehuleixing_XialaViewBtnPressed:(UIButton *)sender{
    self.arr_Projects = [[NSMutableArray alloc] init];
    UIButton *btn101 =  (UIButton *)[self.view viewWithTag:101];
    NSAttributedString *btn_KehuleixingTitle = [[NSAttributedString alloc] initWithString:@"客户类型" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    if (sender.tag == 201) {
        self.arr_Projects = self.arr_OriginProjects;
        btn_KehuleixingTitle = [[NSAttributedString alloc] initWithString:@"全部" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    }
    else if (sender.tag == 202)
    {
        for (RbtProjectModel *oneP in self.arr_OriginProjects) {
            if ([oneP.leixing isEqualToString:@"地产住宅类"]) {
                [self.arr_Projects addObject:oneP];
            }
        }
        btn_KehuleixingTitle = [[NSAttributedString alloc] initWithString:@"地产住宅类" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    }
    else if (sender.tag == 203)
    {
        for (RbtProjectModel *oneP in self.arr_OriginProjects) {
            if ([oneP.leixing isEqualToString:@"酒店宾馆类"]) {
                [self.arr_Projects addObject:oneP];
            }
        }
        btn_KehuleixingTitle = [[NSAttributedString alloc] initWithString:@"酒店宾馆类" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    }
    else if (sender.tag == 204)
    {
        for (RbtProjectModel *oneP in self.arr_OriginProjects) {
            if ([oneP.leixing isEqualToString:@"学校医院类"]) {
                [self.arr_Projects addObject:oneP];
            }
        }
        btn_KehuleixingTitle = [[NSAttributedString alloc] initWithString:@"学校医院类" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    }
    else if (sender.tag == 205)
    {
        for (RbtProjectModel *oneP in self.arr_OriginProjects) {
            if ([oneP.leixing isEqualToString:@"企业单位类"]) {
                [self.arr_Projects addObject:oneP];
            }
        }
        btn_KehuleixingTitle = [[NSAttributedString alloc] initWithString:@"企业单位类" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    }
    else if (sender.tag == 206)
    {
        for (RbtProjectModel *oneP in self.arr_OriginProjects) {
            if ([oneP.leixing isEqualToString:@"其它"]) {
                [self.arr_Projects addObject:oneP];
            }
        }
        btn_KehuleixingTitle = [[NSAttributedString alloc] initWithString:@"其它" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor, nil]];
    }
    [btn101 setAttributedTitle:btn_KehuleixingTitle forState:UIControlStateSelected];
    [btn101 setAttributedTitle:btn_KehuleixingTitle forState:UIControlStateNormal];
    [self.tableView reloadData];
    self.kehuleixing_XialaView.hidden = YES;
}
#pragma mark - tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([RbtCommonTool getJinRuMode] == WoDeGongCheng) {
        if ([self.arr_Projects count] > 100) {
            if (isMore) {
                return [self.arr_Projects count];
            }
            else{
                return 100;
            }
        }
        else{
            return [self.arr_Projects count];
        }
    }
    else{
        return [self.arr_Projects count];
    }
     return [self.arr_Projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *result = nil;
    if ([tableView isEqual:self.tableView]){
        static NSString *TableViewCellIdentifier = @"MyCells";
        result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (result == nil){
            result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TableViewCellIdentifier];
            result.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"text_background"]];
            result.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
            }
        RbtProjectModel *oneProject =(RbtProjectModel *)[self.arr_Projects objectAtIndex:indexPath.row];
        result.textLabel.text = oneProject.name;
        result.textLabel.font = [UIFont fontWithName:kFontName size:15];
        NSString *detailString = [oneProject.leixing stringByAppendingFormat:@" | %@",oneProject.city];
        result.detailTextLabel.text = detailString;
        result.detailTextLabel.font = [UIFont fontWithName:kFontName size:11];
        result.detailTextLabel.textColor = [UIColor grayColor];
    }
    return result;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 59;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL doit = YES;
    if ([RbtCommonTool getJinRuMode] == GongGGC) {
        doit = NO;
        if (indexPath.row == 0) {
            doit = YES;
        }
    }
    
    if (doit) {
        RbtProjectModel *oneProject =(RbtProjectModel *)[self.arr_Projects objectAtIndex:indexPath.row];
        [RbtProjectModel sharedInstance].projectid = oneProject.projectid;
        [RbtProjectModel sharedInstance].name = oneProject.name;
        [RbtProjectModel sharedInstance].city = oneProject.city;
        [RbtProjectModel sharedInstance].citycode = oneProject.citycode;
        [RbtProjectModel sharedInstance].longitude = oneProject.longitude;
        [RbtProjectModel sharedInstance].latitude = oneProject.latitude;
        
        //保存浏览记录
        if ([RbtCommonTool getJinRuMode] == WoDeGongCheng) {
            for (RbtProjectModel *p in self.arr_LiuLanProjects) {
                if ([p.projectid isEqualToString:oneProject.projectid]) {
                    [self.arr_LiuLanProjects removeObject:p];
                    break;
                }
            }
            [self.arr_LiuLanProjects insertObject:oneProject atIndex:0];
            [self liuLanBaoCun];
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [RbtProjectInfoModel sharedInstance].pid = oneProject.projectid;
        [self.hud1 show:YES];
        
        RbtWebManager *webmanager;
        if ([RbtCommonTool getJinRuMode] != LiXianGongCheng) {
            webmanager = [RbtWebManager getRbtManager:YES];
        }
        else{
            webmanager = [RbtWebManager getRbtManager:NO];
        }
        webmanager.name = @"getProjectInfo";
        webmanager.delegate = self;
        [webmanager getProjectInfo:oneProject.projectid];
    }
    else{
        [RbtCommonTool showInfoAlert:@"请登录后查看"];
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_refreshFooterView == nil) {
        _refreshFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(130, 0, 60, 40);
        [_refreshFooterView addSubview:_activityView];
        [_activityView startAnimating];
        _refreshFooterView.hidden = YES;
        [self.tableView.tableFooterView addSubview:_refreshFooterView];
    }
    return _refreshFooterView;
}

- (void)liuLanBaoCun{
    NSString *liuLanFilePath = [RbtCommonTool liuLanFilePath];
    if ([self.arr_LiuLanProjects count]>5) {
        [self.arr_LiuLanProjects removeLastObject];
    }
    BOOL success = [NSKeyedArchiver archiveRootObject:self.arr_LiuLanProjects toFile:liuLanFilePath];
    if (!success) {
        NSLog(@"保存浏览记录失败");
    }
}

#pragma mark -searchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *test = searchBar.text;
    [self hiddenSearchBar];
    self.arr_Projects =[[NSMutableArray alloc] init];
    for (RbtProjectModel *oneProject in self.arr_OriginProjects) {
        if ([oneProject.name rangeOfString:test].length != NSNotFound&&[oneProject.name rangeOfString:test].length != 0) {
            [self.arr_Projects addObject:oneProject];
        }
    }
    [self.tableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self hiddenSearchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [self hiddenSearchBar];
}

- (void)showSearchBar{
    UIButton *btn =  (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    btn.userInteractionEnabled = NO;
    self.citySheetView.hidden = YES;
    self.kehuleixing_XialaView.height = YES;
    
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0,100, 320, 36)];
    self.searchBar.delegate=self;
    [self.searchBar setShowsCancelButton:YES];
    [self.searchBar becomeFirstResponder];
    [self.view addSubview:self.searchBar];
    UISearchDisplayController *search=[[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    search.searchResultsDataSource=self;//---这里是重中之重，用来显示搜索结果的代理。这个必须有
    search.searchResultsDelegate=self;//-----还有这个也是
    search.delegate=self;
}

- (void)hiddenSearchBar{
    [self.searchBar resignFirstResponder];
    self.searchBar.hidden = YES;
    UIButton *btn =  (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    btn.userInteractionEnabled = YES;
}

#pragma mark -UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        self.arr_Projects =[[NSMutableArray alloc] init];
        for (RbtProjectModel *oneProject in self.arr_OriginProjects) {
            if ([location.city isEqualToString:@"全部"]) {
                if ([oneProject.city rangeOfString:location.state].length != NSNotFound&&[oneProject.city rangeOfString:location.state].length != 0) {
                    [self.arr_Projects addObject:oneProject];
                }
                else if([location.state isEqualToString:@"全国"]){
                    [self.arr_Projects addObject:oneProject];
                }
            }
            else{
                if ([oneProject.city rangeOfString:location.city].length != NSNotFound&&[oneProject.city rangeOfString:location.city].length != 0) {
                    [self.arr_Projects addObject:oneProject];
                }
            }
        }
        [self.tableView reloadData];
    }
    self.citySheetView = nil;
}

#pragma mark - mapView delegate
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"select");
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"calloutAccessoryControlTapped");
    
    BOOL doit = YES;
    if ([RbtCommonTool getJinRuMode] == GongGGC) {
        doit = NO;
        [RbtCommonTool showInfoAlert:@"请登录后查看"];
    }
    
    if (doit) {
        if ([view.annotation isKindOfClass:[MyAnnotation class]]) {
            MyAnnotation *myAnn = (MyAnnotation *)view.annotation;
            for (RbtProjectModel *oneProject in self.arr_OriginProjects) {
                if([myAnn.title isEqualToString:oneProject.name]){
                    [RbtProjectModel sharedInstance].projectid = oneProject.projectid;
                    [RbtProjectModel sharedInstance].name = oneProject.name;
                    [RbtProjectModel sharedInstance].city = oneProject.city;
                    [RbtProjectModel sharedInstance].citycode = oneProject.citycode;
                    [RbtProjectModel sharedInstance].longitude = oneProject.longitude;
                    [RbtProjectModel sharedInstance].latitude = oneProject.latitude;
                    
                    //保存浏览记录
                    if ([RbtCommonTool getJinRuMode] == WoDeGongCheng) {
                        for (RbtProjectModel *p in self.arr_LiuLanProjects) {
                            if ([p.projectid isEqualToString:oneProject.projectid]) {
                                [self.arr_LiuLanProjects removeObject:p];
                                break;
                            }
                        }
                        [self.arr_LiuLanProjects insertObject:oneProject atIndex:0];
                        [self liuLanBaoCun];
                    }
                    
                    [RbtProjectInfoModel sharedInstance].pid = oneProject.projectid;
                    [self.hud1 show:YES];
                    
                    RbtWebManager *webmanager;
                    if ([RbtCommonTool getJinRuMode] != LiXianGongCheng) {
                        webmanager = [RbtWebManager getRbtManager:YES];
                    }
                    else{
                        webmanager = [RbtWebManager getRbtManager:NO];
                    }
                    webmanager.name = @"getProjectInfo";
                    webmanager.delegate = self;
                    [webmanager getProjectInfo:oneProject.projectid];
                    break;
                }
            }
        }
    }
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
    NSLog(@"load map error = %@",error);
    [RbtCommonTool showInfoAlert:@"加载地图失败"];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation{
    //判断是否为当前设备位置的annotation
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        //返回nil，就使用默认的标注视图
        return nil;
    }
    //-------------------创建大头针视图---------------------
    static NSString *identifier = @"Annotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        //MKPinAnnotationView 是大头针视图
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        //设置是否显示标题视图
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:@"map"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//        
//        //标题右边视图
        annotationView.rightCalloutAccessoryView = button;
        //标题左边视图
        //        annotationView.leftCalloutAccessoryView
    }
    annotationView.annotation = annotation;
    //设置大头针的颜色
//    annotationView.pinColor = MKPinAnnotationColorRed;
    //从天上落下的动画
//    annotationView.animatesDrop = NO;
    return annotationView;
    //-------------------使用图片作为标注视图---------------------
}

//- (void)buttonAction{
//    NSLog(@"buttonAction");
//}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if([webService.name isEqualToString:@"getProjectInfo"]){
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            RbtGongChengJianJieViewController *gcjjVc = [[RbtGongChengJianJieViewController alloc] init];
            [self.navigationController pushViewController:gcjjVc animated:YES];
        }
        else{
            if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
                responseDic = [responseDic objectForKey:@"rt"];
                [RbtProjectInfoModel sharedInstance].n = [responseDic objectForKey:@"n"];
                [RbtProjectInfoModel sharedInstance].i = [responseDic objectForKey:@"i"];
                [RbtProjectInfoModel sharedInstance].w = [responseDic objectForKey:@"w"];
                [RbtProjectInfoModel sharedInstance].c = [responseDic objectForKey:@"c"];
                [RbtProjectInfoModel sharedInstance].t = [responseDic objectForKey:@"t"];
                [RbtProjectInfoModel sharedInstance].p = [responseDic objectForKey:@"p"];
                [RbtProjectInfoModel sharedInstance].ct = [responseDic objectForKey:@"ct"];
                RbtGongChengJianJieViewController *gcjjVc = [[RbtGongChengJianJieViewController alloc] init];
                [self.navigationController pushViewController:gcjjVc animated:YES];
            }
            else if ([[responseDic objectForKey:@"rc"] isEqualToString:@"0"]){
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
    }
    else if([webService.name isEqualToString:@"getMyProjectWebManager"]){
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
            [RbtCommonModel sharedInstance].arr_myProject = [[NSMutableArray alloc] init];
            NSArray *arrRt = [responseDic objectForKey:@"rt"];
            for (int i = 0;i < [arrRt count]; i++) {
                NSDictionary *oneLeixing = [arrRt objectAtIndex:i];
                NSArray *arr = [oneLeixing objectForKey:@"l"];
                NSString *string_leixing =[oneLeixing objectForKey:@"ct"];
                for (int j = 0; j<[arr count]; j++) {
                    NSDictionary *onePro = [arr objectAtIndex:j];
                    RbtProjectModel *oneProject = [[RbtProjectModel alloc] init];
                    oneProject.leixing = string_leixing;
                    oneProject.name = [onePro objectForKey:@"n"];
                    oneProject.projectid = [onePro objectForKey:@"id"];
                    oneProject.city = [onePro objectForKey:@"a"];
                    oneProject.citycode = [onePro objectForKey:@"c"];
                    [[RbtCommonModel sharedInstance].arr_myProject addObject:oneProject];
                }
            }
            self.arr_Projects = [RbtCommonModel sharedInstance].arr_myProject;
            [self.tableView reloadData];
            [self doneLoadingTableViewData];
        }
        else if ([[responseDic objectForKey:@"rc"] isEqualToString:@"0"]){
            [RbtCommonTool showInfoAlert:@"用户名不存在"];
        }
    }
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)hideNow{
    _refreshFooterView.hidden = YES;
    [self.tableView reloadData];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    if (isMore) {
        float sh = [self.arr_Projects count]*59-self.tableView.bounds.size.height;
        if (sh > 0) {
            if (self.tableView.bounds.origin.y > sh) {
                _refreshFooterView.hidden = NO;
                if (self.h>0) {
                    NSLog(@"reloaddata");
                }
                isMore = NO;
                [self performSelector:@selector(hideNow) withObject:self afterDelay:0.3];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self hiddenSearchBar];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
    RbtWebManager *getMyProjectWebManager = [RbtWebManager getRbtManager:YES];
    getMyProjectWebManager.name = @"getMyProjectWebManager";
    getMyProjectWebManager.delegate = self;
    NSString *userName =[RbtUserModel sharedInstance].userName;
    [getMyProjectWebManager getMyProjectWithUser:userName andH:@"1"];
    [self.hud1 show:YES];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}

@end

//废弃代码
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    if (IS_IPHONE_5) {
//        bgImageView.image = [UIImage imageNamed:@"gdgc"];
//    }
//    else{
//        bgImageView.image = [UIImage imageNamed:@"gdgc"];
//    }
//    [self.view addSubview:bgImageView];

/*
 self.arr_Projects = [RbtCommonModel sharedInstance].arr_publicProject;
 NSArray *arr_myProject =[RbtCommonModel sharedInstance].arr_myProject;
 for (RbtProjectModel *oneP in arr_myProject) {
 BOOL isChongfu = NO;
 for (RbtProjectModel *onePublic in [RbtCommonModel sharedInstance].arr_publicProject) {
 if ([oneP.projectid isEqualToString:onePublic.projectid]) {
 isChongfu = YES;
 break;
 }
 }
 if (!isChongfu) {
 [self.arr_Projects addObject:oneP];
 }
 }
 self.arr_OriginProjects = self.arr_Projects;
 */