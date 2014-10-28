//
//  RbtYuanChengKongZhiViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtYuanChengKongZhiViewController.h"
#import "RbtSheBeiView.h"
#import "RbtYckzDsViewController.h"


@interface RbtYuanChengKongZhiViewController ()<RbtYuanChengSelectViewDelegate,RbtSheBeiViewDelegate,RbtDsDelegate>
{
    RbtSheBeiView *oneSheBei;
    BOOL isSs;
    NSDictionary *timeInfo;
    
    UILabel *timeLab1;
    UILabel *timeLab2;
    UILabel *timeLab3;
    
    UIImageView *timeBgView;
    
    
    UILabel *timeLab1_jr;
    UILabel *timeLab2_jr;
    UILabel *timeLab3_jr;
    
    UIImageView *timeBgView_jr;
    
    BOOL isTime_ss;
    BOOL isTime_jr;
}
@end

@implementation RbtYuanChengKongZhiViewController

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

    //-------debug------
//    [webManager getcontrolmodeandstatusWithU:[RbtUserModel sharedInstance].userName andP:@"12"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"远程控制";
    isSs = YES;
    
    int i = 0;
    
    if (IS_IPHONE_5) {
        i = 30;
    }
    
    UIImageView *bgShang = [[UIImageView alloc] init];
    bgShang.image = [UIImage imageNamed:@"yckz_shangbg"];
    bgShang.frame = CGRectMake(6, 8+64+i, 307, 199);
    [self.view addSubview:bgShang];
    
    UIImageView *bgXia = [[UIImageView alloc] init];
    bgXia.image = [UIImage imageNamed:@"yckz_xiabg"];
    bgXia.frame = CGRectMake(6, 210+64+i*2, 307, 149);
    [self.view addSubview:bgXia];
    
    self.lab_controlModel = [[UILabel alloc] initWithFrame:CGRectMake(128, 68+i, 80, 40)];
    self.lab_controlModel.textColor = [UIColor blackColor];
    self.lab_controlModel.text = @"";
    self.lab_controlModel.font = [UIFont fontWithName:kFontName size:15];
    [self.view addSubview:self.lab_controlModel];
    
    
    timeBgView = [[UIImageView alloc] init];
    [timeBgView setFrame:CGRectMake(0, 220, 320, 64)];
    timeBgView.hidden = YES;
    [self.view addSubview:timeBgView];
    
    timeLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0+10, 0, 100, 64)];
    [timeBgView addSubview:timeLab1];
    timeLab2 = [[UILabel alloc] initWithFrame:CGRectMake(100+10, 0, 100, 64)];
    [timeBgView addSubview:timeLab2];
    timeLab3 = [[UILabel alloc] initWithFrame:CGRectMake(200+10, 0, 100, 64)];
    [timeBgView addSubview:timeLab3];
    
    timeLab1.textAlignment  = NSTextAlignmentCenter;
    timeLab2.textAlignment  = NSTextAlignmentCenter;
    timeLab3.textAlignment  = NSTextAlignmentCenter;
    
    timeBgView_jr = [[UIImageView alloc] init];
    [timeBgView_jr setFrame:CGRectMake(0, 220, 320, 64)];
    timeBgView_jr.hidden = YES;
    [self.view addSubview:timeBgView_jr];
    
    timeLab1_jr = [[UILabel alloc] initWithFrame:CGRectMake(0+10, 0, 100, 64)];
    [timeBgView_jr addSubview:timeLab1_jr];
    timeLab2_jr = [[UILabel alloc] initWithFrame:CGRectMake(100+10, 0, 100, 64)];
    [timeBgView_jr addSubview:timeLab2_jr];
    timeLab3_jr = [[UILabel alloc] initWithFrame:CGRectMake(200+10, 0, 100, 64)];
    [timeBgView_jr addSubview:timeLab3_jr];
    
    timeLab1_jr.textAlignment  = NSTextAlignmentCenter;
    timeLab2_jr.textAlignment  = NSTextAlignmentCenter;
    timeLab3_jr.textAlignment  = NSTextAlignmentCenter;
    
    NSArray *arr_xiaImages = @[@"yckz_ss",@"yckz_ssselect",@"yckz_jr",@"yckz_jrselect",@"yckz_sb",@"yckz_sbselect"];
    NSArray *arr_xiaParam = @[@"82",@"127",@"15.25",@"21"];
    RbtYuanChengSelectView *xiaSelectView = [[RbtYuanChengSelectView alloc] initWithFrame:bgXia.frame withImages:arr_xiaImages andParam:arr_xiaParam];
    xiaSelectView.name = @"xiaSelectView";
    xiaSelectView.delegate = self;
    [xiaSelectView setSelectBtn:10];
    [self.view addSubview:xiaSelectView];
    
    //上水
    NSArray *arr_shangImages = @[@"yckz_zd",@"yckz_zdselect",@"yckz_ds",@"yckz_dsselect",@"yckz_tz",@"yckz_tzselect"];
    NSArray *arr_shangParam = @[@"85",@"109",@"13",@"50"];
    self.ssSelectView = [[RbtYuanChengSelectView alloc] initWithFrame:bgShang.frame withImages:arr_shangImages andParam:arr_shangParam];
    self.ssSelectView.name = @"ss_shangSelectView";
    self.ssSelectView.delegate = self;
    [self.view addSubview:self.ssSelectView];
    
    //加热
    self.jrSelectView = [[RbtYuanChengSelectView alloc] initWithFrame:bgShang.frame withImages:arr_shangImages andParam:arr_shangParam];
    self.jrSelectView.name = @"jr_shangSelectView";
    self.jrSelectView.delegate = self;
    self.jrSelectView.hidden = YES;
    [self.view addSubview:self.jrSelectView];
    
    //设备
    self.sbSelectView = [[UIScrollView alloc] initWithFrame:bgShang.frame];
    self.sbSelectView.backgroundColor = [UIColor whiteColor];
    self.sbSelectView.hidden = YES;
    [self.view addSubview:self.sbSelectView];
    
    //定时model
//    self.ssDsView = [[RbtYckzDsView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
//    self.ssDsView.hidden = YES;
//    self.ssDsView.name = @"ssDsView";
//    self.ssDsView.delegate = self;
//    [self.view addSubview:self.ssDsView];
    
//    self.jrDsView = [[RbtYckzDsView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
//    self.jrDsView.hidden = YES;
//    self.jrDsView.name = @"jrDsView";
//    self.jrDsView.delegate = self;
//    [self.view addSubview:self.jrDsView];
    
    
    [self.hud1 show:YES];
    RbtWebManager *webManager;
    if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
        webManager = [RbtWebManager getRbtManager:NO];
    }
    else
    {
        webManager = [RbtWebManager getRbtManager:YES];
        
    }
    webManager.name = @"yckzweb";
    webManager.delegate = self;
    [webManager getcontrolmodeandstatusWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)chageShangView:(NSInteger) x{
    self.ssSelectView.hidden = YES;
    self.jrSelectView.hidden = YES;
    self.sbSelectView.hidden = YES;
    [self showTheTime:@"ss" show:NO];
    [self showTheTime:@"jr" show:NO];
    if (x == 10) {
        self.ssSelectView.hidden = NO;
        [self showTheTime:@"ss" show:YES];
    }
    else if (x == 11)
    {
        self.jrSelectView.hidden = NO;
        [self showTheTime:@"jr" show:YES];
    }
    else if  (x == 12)
    {
        self.sbSelectView.hidden = NO;
    }
}

//#pragma mark- RbtYuanChengSelectViewdelegate
//- (void)buttonAcitons: (NSInteger) thebutton andView:(RbtYuanChengSelectView *)theView{
//    if ([theView.name isEqualToString:@"xiaSelectView"]) {
//        [self chageShangView:thebutton];
//    }
//    if ([RbtCommonTool getJinRuMode] != LiXianGongCheng) {
//        if([theView.name isEqualToString:@"ss_shangSelectView"]){
//            RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
//            webManager.delegate = self;
//            if (thebutton == 10) {
//                webManager.name = @"ss_auto";
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"auto",@"s", nil];
//                NSDictionary *dic_w = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"w", nil];
//        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_w,@"c", nil];
//                [self.hud1 show:YES];
//                [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_w];
//                
//            }
//            else if(thebutton == 11){
//        //            self.ssDsView.hidden = NO;
//                webManager.name = @"ss_time";
//                NSMutableArray *arr_time = [[NSMutableArray alloc] init];
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"timing",@"s",arr_time,@"t", nil];
//                NSDictionary *dic_w = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"w", nil];
//        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_w,@"c", nil];
//                [self.hud1 show:YES];
//                [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_w];
//            }
//            else if(thebutton == 12){
//                webManager.name = @"ss_stop";
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"stop",@"s", nil];
//                NSDictionary *dic_w = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"w", nil];
//        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_w,@"c", nil];
//                [self.hud1 show:YES];
//                [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_w];
//                
//            }
//        }
//        else if([theView.name isEqualToString:@"jr_shangSelectView"]){
//            RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
//            webManager.delegate = self;
//            if (thebutton == 10) {
//                webManager.name = @"jr_auto";
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"auto",@"s", nil];
//                NSDictionary *dic_h = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"h", nil];
//        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_h,@"c", nil];
//                [self.hud1 show:YES];
//                [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_h];
//            }
//            else if(thebutton == 11){
//                webManager.name = @"jr_time";
//        //            self.jrDsView.hidden = NO;
//                NSMutableArray *arr_time = [[NSMutableArray alloc] init];
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"timing",@"s",arr_time,@"t", nil];
//                NSDictionary *dic_h = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"h", nil];
//        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_h,@"c", nil];
//                [self.hud1 show:YES];
//                [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_h];
//            }
//            else if(thebutton == 12){
//                webManager.name = @"jr_stop";
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"stop",@"s", nil];
//                NSDictionary *dic_h = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"h", nil];
//        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_h,@"c", nil];
//                [self.hud1 show:YES];
//                [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_h];
//            }
//        }
//    }
//}

#pragma mark- RbtYuanChengSelectViewdelegate
- (void)buttonAcitons: (NSInteger) thebutton andView:(RbtYuanChengSelectView *)theView{
    if ([theView.name isEqualToString:@"xiaSelectView"]) {
        [self chageShangView:thebutton];
    }
    if ([RbtCommonTool getJinRuMode] != LiXianGongCheng) {
        if([theView.name isEqualToString:@"ss_shangSelectView"]){
            if (thebutton == 10) {
                RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
                webManager.delegate = self;
                webManager.name = @"ss_auto_per";
                [self.hud1 show:YES];
                [webManager getgetpermissionWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
            }
            else if(thebutton == 11){
//                RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
//                webManager.delegate = self;
//                webManager.name = @"ss_time_per";
//                [self.hud1 show:YES];
//                [webManager getgetpermissionWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
                isSs = YES;
                RbtYckzDsViewController *dsVc = [[RbtYckzDsViewController alloc] init];
                dsVc.delegate = self;
                dsVc.startTime1 = self.startTime1_ss;
                dsVc.endTime1  =self.endTime1_ss;
                dsVc.startTime2 = self.startTime2_ss;
                dsVc.endTime2  =self.endTime2_ss;
                dsVc.startTime3 = self.startTime3_ss;
                dsVc.endTime3  =self.endTime3_ss;
                [dsVc initPickerView];
                [self.navigationController pushViewController:dsVc animated:YES];
            }
            else if(thebutton == 12){
                RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
                webManager.delegate = self;
                webManager.name = @"ss_stop_per";
                [self.hud1 show:YES];
                [webManager getgetpermissionWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
            }
        }
        else if([theView.name isEqualToString:@"jr_shangSelectView"]){
            if (thebutton == 10) {
                RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
                webManager.delegate = self;
                webManager.name = @"jr_auto_per";
                [self.hud1 show:YES];
                [webManager getgetpermissionWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
            }
            else if(thebutton == 11){
                isSs = NO;
                RbtYckzDsViewController *dsVc = [[RbtYckzDsViewController alloc] init];
                dsVc.delegate = self;
                dsVc.startTime1 = self.startTime1_jr;
                dsVc.endTime1  =self.endTime1_jr;
                dsVc.startTime2 = self.startTime2_jr;
                dsVc.endTime2  =self.endTime2_jr;
                dsVc.startTime3 = self.startTime3_jr;
                dsVc.endTime3  =self.endTime3_jr;
                [dsVc initPickerView];
                [self.navigationController pushViewController:dsVc animated:YES];
                
//                RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
//                webManager.delegate = self;
//                webManager.name = @"jr_time_per";
//                [self.hud1 show:YES];
//                [webManager getgetpermissionWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
            }
            else if(thebutton == 12){
                RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
                webManager.delegate = self;
                webManager.name = @"jr_stop_per";
                [self.hud1 show:YES];
                [webManager getgetpermissionWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
            }
        }
    }
}

//#pragma mark- RbtYckzDsViewDelegate
//- (void)dsbuttonTag: (NSInteger)thebutton andView:(RbtYckzDsView *)theView{
//    if ([theView.name isEqualToString:@"ssDsView"]) {
//        if (thebutton == 1) {
////            [self.ssSelectView setSelectBtn:11];
//        }
//        else if(thebutton == 2){
//            
//        }
////        self.ssDsView.hidden = YES;
//    }
//    else if ([theView.name isEqualToString:@"jrDsView"]) {
//        if (thebutton == 1) {
////            [self.jrSelectView setSelectBtn:11];
//        }
//        else if(thebutton == 2){
//            
//        }
//        self.jrDsView.hidden = YES;
//    }
//}
#pragma mark- RbtSheBeiViewDelegate
- (void)sheBeiViewStateChange:(RbtSheBeiView *)theView{
//    RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
//    webManager.delegate = self;
//    webManager.name = @"sbweb";
//    NSString *zhuangtai = @"on";
//    if (theView.isOn) {
//        zhuangtai = @"off";
//    }
//    else{
//        zhuangtai = @"on";
//    }
//    oneSheBei = theView;
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:theView.name,@"n",zhuangtai,@"s",nil];
//    NSArray *arr = [NSArray arrayWithObject:dic];
//    NSDictionary *dic_d = [NSDictionary dictionaryWithObjectsAndKeys:arr,@"d", nil];
////    NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_d,@"c", nil];
//    [self.hud1 show:YES];
//    [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_d];
    
    RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
    webManager.delegate = self;
    webManager.name = @"sbweb_per";
    oneSheBei = theView;
    [self.hud1 show:YES];
    [webManager getgetpermissionWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
}

#pragma mark- control
- (void)getPermissionSuccess:(NSString *)kongzhi{
    RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
    webManager.delegate = self;
    if([kongzhi isEqualToString:@"sbweb"]){
        webManager.name = @"sbweb";
        NSString *zhuangtai = @"on";
        if (oneSheBei.isOn) {
            zhuangtai = @"on";
        }
        else{
            zhuangtai = @"off";
        }
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:oneSheBei.name,@"n",zhuangtai,@"s",nil];
        NSArray *arr = [NSArray arrayWithObject:dic];
        NSDictionary *dic_d = [NSDictionary dictionaryWithObjectsAndKeys:arr,@"d", nil];
        //    NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_d,@"c", nil];
        [self.hud1 show:YES];
        [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_d];
    }
    else if ([kongzhi isEqualToString:@"ss_auto"]) {
        webManager.name = @"ss_auto";
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"auto",@"s", nil];
        NSDictionary *dic_w = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"w", nil];
        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_w,@"c", nil];
        [self.hud1 show:YES];
        [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_w];
    }
    else if ([kongzhi isEqualToString:@"ss_time"]) {
        //            self.ssDsView.hidden = NO;
        webManager.name = @"ss_time";
        NSMutableArray *arr_time = [[NSMutableArray alloc] init];
        arr_time = [self getTimeArray];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"timing",@"s",arr_time,@"t", nil];
        NSDictionary *dic_w = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"w", nil];
        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_w,@"c", nil];
        [self.hud1 show:YES];
        [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_w];
    }
    else if([kongzhi isEqualToString:@"ss_stop"]){
        webManager.name = @"ss_stop";
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"stop",@"s", nil];
        NSDictionary *dic_w = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"w", nil];
        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_w,@"c", nil];
        [self.hud1 show:YES];
        [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_w];
    }
    else if ([kongzhi isEqualToString:@"jr_auto"]) {
        webManager.name = @"jr_auto";
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"auto",@"s", nil];
        NSDictionary *dic_h = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"h", nil];
        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_h,@"c", nil];
        [self.hud1 show:YES];
        [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_h];
    }
    else if ([kongzhi isEqualToString:@"jr_time"]) {
        webManager.name = @"jr_time";
        //            self.jrDsView.hidden = NO;
        NSMutableArray *arr_time = [[NSMutableArray alloc] init];
        arr_time = [self getTimeArray];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"timing",@"s",arr_time,@"t", nil];
        NSDictionary *dic_h = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"h", nil];
        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_h,@"c", nil];
        [self.hud1 show:YES];
        [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_h];
    }
    else if([kongzhi isEqualToString:@"jr_stop"]){
        webManager.name = @"jr_stop";
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"stop",@"s", nil];
        NSDictionary *dic_h = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"h", nil];
        //            NSDictionary *dic_c = [NSDictionary dictionaryWithObjectsAndKeys:dic_h,@"c", nil];
        [self.hud1 show:YES];
        [webManager controlWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid  andC:dic_h];
    }
}


#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    if([webService.name isEqualToString:@"yckzweb"]){
        [self.hud1 hide:YES];
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            if ([[responseDic objectForKey:@"c"] isEqualToString:@"manual"]) {
                self.lab_controlModel.text = @"手动模式";
            }
            else{
                self.lab_controlModel.text = @"自动模式";
                //------debug---------
                return;
            }
            NSDictionary *dic_w = [responseDic objectForKey:@"w"];
            NSDictionary *dic_h = [responseDic objectForKey:@"h"];
            NSArray *arr_d = [responseDic objectForKey:@"d"];
            //上水
            if ([[dic_w objectForKey:@"s"] isEqualToString:@"auto"]) {
                [self.ssSelectView setSelectBtn:10];
                self.ssSelectView.preTag = 10;
                
                isTime_ss = NO;
                [self showTheTime:@"ss" show:NO];
            }
            else if ([[dic_w objectForKey:@"s"] isEqualToString:@"timing"]) {
                [self.ssSelectView setSelectBtn:11];
                self.ssSelectView.preTag = 11;
                NSArray *arr = [dic_w objectForKey:@"t"];
                for (int i = 0; i<3; i++) {
                    NSDictionary *dic = [arr objectAtIndex:i];
                    NSString *start = [dic objectForKey:@"start"];
                    NSString *end = [dic objectForKey:@"end"];
                    if (i == 0) {
                        self.startTime1_ss = start;
                        self.endTime1_ss = end;
                    }
                    else if (i== 1){
                        self.startTime2_ss = start;
                        self.endTime2_ss = end;
                    }
                    else if (i== 2){
                        self.startTime3_ss = start;
                        self.endTime3_ss = end;
                    }
                }
                isTime_ss = YES;
                [self showTheTime:@"ss" show:YES];
            }
            else if ([[dic_w objectForKey:@"s"] isEqualToString:@"stop"]) {
                self.ssSelectView.preTag = 12;
                [self.ssSelectView setSelectBtn:12];
                
                isTime_ss = NO;
                [self showTheTime:@"ss" show:NO];
            }
            
            
            //加热
            if ([[dic_h objectForKey:@"s"] isEqualToString:@"auto"]) {
                [self.jrSelectView setSelectBtn:10];
                self.jrSelectView.preTag = 10;
                
                isTime_jr = NO;
                [self showTheTime:@"jr" show:NO];
            }
            else if ([[dic_h objectForKey:@"s"] isEqualToString:@"timing"]) {
                [self.jrSelectView setSelectBtn:11];
                self.jrSelectView.preTag = 11;
                NSArray *arr = [dic_h objectForKey:@"t"];
                for (int i = 0; i<3; i++) {
                    NSDictionary *dic = [arr objectAtIndex:i];
                    NSString *start = [dic objectForKey:@"start"];
                    NSString *end = [dic objectForKey:@"end"];
                    if (i == 0) {
                        self.startTime1_jr = start;
                        self.endTime1_jr = end;
                    }
                    else if (i== 1){
                        self.startTime2_jr = start;
                        self.endTime2_jr = end;
                    }
                    else if (i== 2){
                        self.startTime3_jr = start;
                        self.endTime3_jr = end;
                    }

                }
                isTime_jr = YES;
                [self showTheTime:@"jr" show:YES];
            }
            else if ([[dic_h objectForKey:@"s"] isEqualToString:@"stop"]) {
                [self.jrSelectView setSelectBtn:12];
                self.jrSelectView.preTag = 12;
                
                isTime_jr = NO;
                [self showTheTime:@"jr" show:NO];
            }
            
            //设备
            for (int i = 0; i<[arr_d count]; i++) {
                NSDictionary *one = [arr_d objectAtIndex:i];
                int j = i/4;
                RbtSheBeiView *oneShebei = [[RbtSheBeiView alloc] initWithFrame:CGRectMake(15+(i%4)*(58+14), 0+100*j, 58, 95)];
                oneShebei.name = [one objectForKey:@"n"];
                oneShebei.delegate = self;
                if ([[one objectForKey:@"s"] isEqualToString:@"on"]) {
                    oneShebei.isOn = YES;
                }
                else{
                    oneShebei.isOn = NO;
                }
                [oneShebei initViews];
                [self.sbSelectView addSubview:oneShebei];
            }
            if ([arr_d count]%4) {
                self.sbSelectView.contentSize = CGSizeMake(self.sbSelectView.width, 100*([arr_d count]/4)+1);
            }
            else{
                self.sbSelectView.contentSize = CGSizeMake(self.sbSelectView.width, 100*([arr_d count]/4+2));
            }
        }
        else{
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
                responseDic = [responseDic objectForKey:@"rt"];
                if ([[responseDic objectForKey:@"c"] isEqualToString:@"manual"]) {
                    self.lab_controlModel.text = @"手动模式";
                }
                else{
                    self.lab_controlModel.text = @"自动模式";
                    //------debug---------
                    return;
                }
                NSDictionary *dic_w = [responseDic objectForKey:@"w"];
                NSDictionary *dic_h = [responseDic objectForKey:@"h"];
                NSArray *arr_d = [responseDic objectForKey:@"d"];
                //上水
                if ([[dic_w objectForKey:@"s"] isEqualToString:@"auto"]) {
                    [self.ssSelectView setSelectBtn:10];
                    self.ssSelectView.preTag = 10;
                    
                    isTime_ss = NO;
                    [self showTheTime:@"ss" show:NO];
                }
                else if ([[dic_w objectForKey:@"s"] isEqualToString:@"timing"]) {
                    [self.ssSelectView setSelectBtn:11];
                     self.ssSelectView.preTag = 11;
                    NSArray *arr = [dic_w objectForKey:@"t"];
                    for (int i = 0; i<3; i++) {
                        NSDictionary *dic = [arr objectAtIndex:i];
                        NSString *start = [dic objectForKey:@"start"];
                        NSString *end = [dic objectForKey:@"end"];
                        if (i == 0) {
                            self.startTime1_ss = start;
                            self.endTime1_ss = end;
                        }
                        else if (i== 1){
                            self.startTime2_ss = start;
                            self.endTime2_ss = end;
                        }
                        else if (i== 2){
                            self.startTime3_ss = start;
                            self.endTime3_ss = end;
                        }
                    }
                    isTime_ss = YES;
                    [self showTheTime:@"ss" show:YES];
                }
                else if ([[dic_w objectForKey:@"s"] isEqualToString:@"stop"]) {
                     self.ssSelectView.preTag = 12;
                    [self.ssSelectView setSelectBtn:12];
                    isTime_ss = NO;
                    [self showTheTime:@"ss" show:NO];
                }
            
                
                //加热
                if ([[dic_h objectForKey:@"s"] isEqualToString:@"auto"]) {
                    [self.jrSelectView setSelectBtn:10];
                    self.jrSelectView.preTag = 10;
                    
                    isTime_jr = NO;
                    [self showTheTime:@"jr" show:NO];
                }
                else if ([[dic_h objectForKey:@"s"] isEqualToString:@"timing"]) {
                    [self.jrSelectView setSelectBtn:11];
                    self.jrSelectView.preTag = 11;
                    NSArray *arr = [dic_h objectForKey:@"t"];
                    for (int i = 0; i<3; i++) {
                        NSDictionary *dic = [arr objectAtIndex:i];
                        NSString *start = [dic objectForKey:@"start"];
                        NSString *end = [dic objectForKey:@"end"];
                        if (i == 0) {
                            self.startTime1_jr = start;
                            self.endTime1_jr = end;
                        }
                        else if (i== 1){
                            self.startTime2_jr = start;
                            self.endTime2_jr = end;
                        }
                        else if (i== 2){
                            self.startTime3_jr = start;
                            self.endTime3_jr = end;
                        }
                    }
                    
                    isTime_jr = YES;
                    [self showTheTime:@"jr" show:NO];
                }
                else if ([[dic_h objectForKey:@"s"] isEqualToString:@"stop"]) {
                    [self.jrSelectView setSelectBtn:12];
                    self.jrSelectView.preTag = 12;
                    
                    isTime_jr = NO;
                    [self showTheTime:@"jr" show:NO];
                }
            
                //设备
                for (int i = 0; i<[arr_d count]; i++) {
                    NSDictionary *one = [arr_d objectAtIndex:i];
                    int j = i/4;
                    RbtSheBeiView *oneShebei = [[RbtSheBeiView alloc] initWithFrame:CGRectMake(15+(i%4)*(58+14), 0+100*j, 58, 95)];
                    oneShebei.name = [one objectForKey:@"n"];
                    oneShebei.delegate = self;
                    if ([[one objectForKey:@"s"] isEqualToString:@"on"]) {
                        oneShebei.isOn = YES;
                    }
                    else{
                        oneShebei.isOn = NO;
                    }
                    [oneShebei initViews];
                    [self.sbSelectView addSubview:oneShebei];
                }
                if ([arr_d count]%4) {
                     self.sbSelectView.contentSize = CGSizeMake(self.sbSelectView.width, 100*([arr_d count]/4+1));
                }
                else{
                    self.sbSelectView.contentSize = CGSizeMake(self.sbSelectView.width, 100*([arr_d count]/4+2));
                }
            }
            else if ([[responseDic objectForKey:@"rc"] isEqualToString:@"0"]){
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
    }
    else  if ([webService.name isEqualToString:@"ss_auto"]) {
        [self.hud1 hide:YES];
        if ([[responseDic objectForKey:@"rc"] integerValue]) {
             self.ssSelectView.preTag = 10;
            isTime_ss = NO;
            [self showTheTime:@"ss" show:NO];
        }
        else{
            [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if ([webService.name isEqualToString:@"ss_time"]) {
        [self.hud1 hide:YES];
        if (![[responseDic objectForKey:@"rc"] isMemberOfClass:[NSNull class]]) {
            if ([[responseDic objectForKey:@"rc"] integerValue]) {
                self.ssSelectView.preTag = 11;
                self.startTime1_ss  = [timeInfo objectForKey:@"startTime1_ss"];
                self.endTime1_ss  = [timeInfo objectForKey:@"endTime1_ss"];
                self.startTime2_ss  = [timeInfo objectForKey:@"startTime2_ss"];
                self.endTime2_ss  = [timeInfo objectForKey:@"endTime2_ss"];
                self.startTime3_ss  = [timeInfo objectForKey:@"startTime3_ss"];
                self.endTime3_ss  = [timeInfo objectForKey:@"endTime3_ss"];
                isTime_ss = YES;
                [self showTheTime:@"ss" show:YES];
            }
            else{
                [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
        else{
            [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
            [RbtCommonTool showInfoAlert:@"控制无效"];
        }
    }
    else if([responseDic objectForKey:@"rc"]&&[webService.name isEqualToString:@"ss_stop"]){
        [self.hud1 hide:YES];
        if (![[responseDic objectForKey:@"rc"] isMemberOfClass:[NSNull class]]) {
            if ([[responseDic objectForKey:@"rc"] integerValue]) {
                self.ssSelectView.preTag = 12;
                
                isTime_ss = NO;
                [self showTheTime:@"ss" show:NO];
            }
            else{
                [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
        else{
            [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
            [RbtCommonTool showInfoAlert:@"控制无效"];
        }
    }
    else if ([webService.name isEqualToString:@"jr_auto"]) {
        [self.hud1 hide:YES];
        if (![[responseDic objectForKey:@"rc"] isMemberOfClass:[NSNull class]]) {
            if ([[responseDic objectForKey:@"rc"] integerValue]) {
                self.jrSelectView.preTag = 10;
                
                isTime_jr = NO;
                [self showTheTime:@"jr" show:NO];
            }
            else{
                [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
        else{
            [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
            [RbtCommonTool showInfoAlert:@"控制无效"];
        }
    }
    else if ([webService.name isEqualToString:@"jr_time"]) {
        [self.hud1 hide:YES];
        if (![[responseDic objectForKey:@"rc"] isMemberOfClass:[NSNull class]]) {
            if ([[responseDic objectForKey:@"rc"] integerValue]) {
                self.jrSelectView.preTag = 11;
                self.startTime1_jr  = [timeInfo objectForKey:@"startTime1_jr"];
                self.endTime1_jr  = [timeInfo objectForKey:@"endTime1_jr"];
                self.startTime2_jr  = [timeInfo objectForKey:@"startTime2_jr"];
                self.endTime2_jr  = [timeInfo objectForKey:@"endTime2_jr"];
                self.startTime3_jr  = [timeInfo objectForKey:@"startTime3_jr"];
                self.endTime3_jr  = [timeInfo objectForKey:@"endTime3_jr"];
                
                isTime_jr = YES;
                [self showTheTime:@"jr" show:YES];
            }
            else{
                [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
        else{
            [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
            [RbtCommonTool showInfoAlert:@"控制无效"];
        }
    }
    else if([webService.name isEqualToString:@"jr_stop"]){
        [self.hud1 hide:YES];
        if (![[responseDic objectForKey:@"rc"] isMemberOfClass:[NSNull class]]) {
            if ([[responseDic objectForKey:@"rc"] integerValue]) {
                self.jrSelectView.preTag = 12;
                
                isTime_jr = NO;
                [self showTheTime:@"jr" show:NO];
            }
            else{
                [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
        else{
            [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
            [RbtCommonTool showInfoAlert:@"控制无效"];
        }
    }
    else if([webService.name isEqualToString:@"sbweb"]){
        [self.hud1 hide:YES];
        if (![[responseDic objectForKey:@"rc"] isMemberOfClass:[NSNull class]]) {
            if ([[responseDic objectForKey:@"rc"] integerValue]) {
            }
            else{
                oneSheBei.iskzsb = YES;
                if (oneSheBei.isOn) {
                    [oneSheBei.swi_sb setOn:NO];
                }
                else{
                    [oneSheBei.swi_sb setOn:YES];
                }
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
        else{
            oneSheBei.iskzsb = YES;
            if (oneSheBei.isOn) {
                [oneSheBei.swi_sb setOn:NO];
            }
            else{
                [oneSheBei.swi_sb setOn:YES];
            }
            [RbtCommonTool showInfoAlert:@"控制无效"];
        }
    }
    else if([webService.name isEqualToString:@"sbweb_per"]){
        if ([[responseDic objectForKey:@"rc"] intValue]) {
            [self getPermissionSuccess:@"sbweb"];
        }
        else
        {
            oneSheBei.iskzsb = YES;
            if (oneSheBei.isOn) {
                [oneSheBei.swi_sb setOn:NO];
            }
            else{
                [oneSheBei.swi_sb setOn:YES];
            }
            [self.hud1 hide:YES];
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if ([webService.name isEqualToString:@"ss_auto_per"]) {
        if ([responseDic objectForKey:@"rc"]&&[[responseDic objectForKey:@"rc"] intValue]) {
            [self getPermissionSuccess:@"ss_auto"];
        }
        else
        {
            [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
            [self.hud1 hide:YES];
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if ([webService.name isEqualToString:@"ss_time_per"]) {
        if ([[responseDic objectForKey:@"rc"] intValue]) {
            [self getPermissionSuccess:@"ss_time"];
        }
        else
        {
            [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
            [self.hud1 hide:YES];
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if([webService.name isEqualToString:@"ss_stop_per"]){
        if ([[responseDic objectForKey:@"rc"] intValue]) {
            [self getPermissionSuccess:@"ss_stop"];
        }
        else
        {
            [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
            [self.hud1 hide:YES];
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if ([webService.name isEqualToString:@"jr_auto_per"]) {
        if ([[responseDic objectForKey:@"rc"] intValue]) {
            [self getPermissionSuccess:@"jr_auto"];
        }
        else
        {
            [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
            [self.hud1 hide:YES];
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if ([webService.name isEqualToString:@"jr_time_per"]) {
        if ([[responseDic objectForKey:@"rc"] intValue]) {
            [self getPermissionSuccess:@"jr_time"];
        }
        else
        {
            [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
            [self.hud1 hide:YES];
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if([webService.name isEqualToString:@"jr_stop_per"]){
        if ([[responseDic objectForKey:@"rc"] intValue]) {
            [self getPermissionSuccess:@"jr_stop"];
        }
        else
        {
            [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
            [self.hud1 hide:YES];
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
}

- (void)webServicefailed:(RbtWebManager *)webService{
    [super webServicefailed:webService];
    if([webService.name isEqualToString:@"sbweb"]){
        oneSheBei.iskzsb = YES;
        if (oneSheBei.isOn) {
            [oneSheBei.swi_sb setOn:NO];
        }
        else{
            [oneSheBei.swi_sb setOn:YES];
        }
    }
    else if ([webService.name isEqualToString:@"ss_auto"]) {
        [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
    }
    else if ([webService.name isEqualToString:@"ss_time"]) {
        [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
    }
    else if([webService.name isEqualToString:@"ss_stop"]){
        [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
    }
    else if ([webService.name isEqualToString:@"jr_auto"]) {
        [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
    }
    else if ([webService.name isEqualToString:@"jr_time"]) {
        [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
    }
    else if([webService.name isEqualToString:@"jr_stop"]){
        [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
    }
    
    if([webService.name isEqualToString:@"sbweb_per"]){
        oneSheBei.iskzsb = YES;
        if (oneSheBei.isOn) {
            [oneSheBei.swi_sb setOn:NO];
        }
        else{
            [oneSheBei.swi_sb setOn:YES];
        }
    }
    else if ([webService.name isEqualToString:@"ss_auto_per"]) {
        [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
    }
    else if ([webService.name isEqualToString:@"ss_time_per"]) {
        [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
    }
    else if([webService.name isEqualToString:@"ss_stop_per"]){
        [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
    }
    else if ([webService.name isEqualToString:@"jr_auto_per"]) {
        [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
    }
    else if ([webService.name isEqualToString:@"jr_time_per"]) {
        [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
    }
    else if([webService.name isEqualToString:@"jr_stop_per"]){
        [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
    }
}

#pragma  mark -DsViewdelegate
- (void)dsVc:(RbtYckzDsViewController *)dsVc
     andInfo:(NSDictionary *)info  isBack:(BOOL)isback{
    if (isSs) {
        if (isback) {
            [self.ssSelectView setSelectBtn:self.ssSelectView.preTag];
        }
        else{
            timeInfo  = info;
            RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
            webManager.delegate = self;
            webManager.name = @"ss_time_per";
            [self.hud1 show:YES];
            [webManager getgetpermissionWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
        }
    }
    else{
        if (isback) {
             [self.jrSelectView setSelectBtn:self.jrSelectView.preTag];
        }
        else{
            timeInfo = info;
            RbtWebManager *webManager = [RbtWebManager getRbtManager:YES];
            webManager.delegate = self;
            webManager.name = @"jr_time_per";
            [self.hud1 show:YES];
            [webManager getgetpermissionWithU:[RbtUserModel sharedInstance].userName andP:[RbtProjectModel sharedInstance].projectid];
        }
    }
}

- (NSArray *)getTimeArray{
    NSMutableArray *arr_time = [[NSMutableArray alloc] init];
    NSDictionary *dic_time1 = [NSDictionary dictionaryWithObjectsAndKeys:[timeInfo objectForKey:@"startTime1"],@"start",[timeInfo objectForKey:@"endTime1"],@"end",nil];
    NSDictionary *dic_time2 = [NSDictionary dictionaryWithObjectsAndKeys:[timeInfo objectForKey:@"startTime2"],@"start",[timeInfo objectForKey:@"endTime2"],@"end",nil];
    NSDictionary *dic_time3 = [NSDictionary dictionaryWithObjectsAndKeys:[timeInfo objectForKey:@"startTime3"],@"start",[timeInfo objectForKey:@"endTime3"],@"end",nil];
    [arr_time addObject:dic_time1];
    [arr_time addObject:dic_time2];
    [arr_time addObject:dic_time3];
    return arr_time;
}


- (void)showTheTime:(NSString *)name show:(BOOL)isShow{
    if ([name isEqualToString:@"ss"]) {
        if (isShow) {
            if (isTime_ss) {
                timeLab1.text = [NSString stringWithFormat:@"%@-%@", self.startTime1_ss, self.endTime1_ss];
                timeLab2.text = [NSString stringWithFormat:@"%@-%@", self.startTime2_ss, self.endTime2_ss];
                timeLab3.text = [NSString stringWithFormat:@"%@-%@", self.startTime3_ss, self.endTime3_ss];
                timeBgView.hidden = NO;
            }
            else{
                timeBgView.hidden = YES;
            }
        }
        else{
            timeBgView.hidden = YES;
        }
        timeBgView_jr.hidden = YES;
    }
    else if([name isEqualToString:@"jr"]) {
        if (isShow) {
            if (isTime_jr) {
                timeLab1_jr.text = [NSString stringWithFormat:@"%@-%@", self.startTime1_jr, self.endTime1_jr];
                timeLab2_jr.text = [NSString stringWithFormat:@"%@-%@", self.startTime2_jr, self.endTime2_jr];
                timeLab3_jr.text = [NSString stringWithFormat:@"%@-%@", self.startTime3_jr, self.endTime3_jr];
                timeBgView_jr.hidden = NO;
            }
            else{
                timeBgView_jr.hidden = YES;
            }
        }
        else{
            timeBgView_jr.hidden = YES;
        }
    }
    timeBgView.hidden = YES;
}

@end
