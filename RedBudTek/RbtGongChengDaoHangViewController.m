//
//  RbtGongChengDaoHangViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//1

#import "RbtGongChengDaoHangViewController.h"
#import "CoverFlowView.h"
#import "RbtTabbarView.h"
#import "RbtReShuiGongChengYuanLiTuViewController.h"
#import "RbtYuanChengKongZhiViewController.h"
#import "RbtShiShiViewController.h"
#import "RbtLiShiShuJuViewController.h"
#import "RbtJieNengViewController.h"
#import "RbtGisDingWeiViewController.h"

#define GAP 6
#define TOPGAP  20+44
#define BOTTOMGAP   49
#define TABBARHEIGHT    49
#define NUMOFTABBARBUTTON   4


@interface RbtGongChengDaoHangViewController ()

@end

static BOOL isLoad;
@implementation RbtGongChengDaoHangViewController

@synthesize controllersArray, imagesArray, selectImagesArray, tabBarButtonsArray;
@synthesize btn_shezhi, btn_sijimuge, btn_wentifankui, btn_wodegongcheng;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)back{
    
    if ([self.tabView getSelectBtn] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeView" object:[NSString stringWithFormat:@"%d",0]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [RbtProjectModel sharedInstance].name;
    isLoad = NO;
    wodeGongChengVc = [[RbtWodeGongChengViewController alloc] init];
    wenTiVc = [[RbtWenTiFanKuiViewController alloc] init];
    anliVc = [[RbtTianQiYuBaoViewController alloc] init];
    anliVc.isShouYe = NO;
    settingVc =[[RbtSettingViewController alloc] init];

    self.controllersArray = [[NSMutableArray alloc] initWithObjects:wodeGongChengVc, wenTiVc, anliVc, settingVc, nil];
    
    int i = 0;
    for (UIViewController *controller in controllersArray ) {
        [controller.view setTag:i];
        if (i == 0) {
            [self.view addSubview:controller.view];
            showViewTag = i;
        }
        i++;
    }
    
    self.tabView = [[RbtTabbarView alloc] initWithFrame:CGRectMake(0, self.view.height - 49, 320, 49)];
    [self.view addSubview:self.tabView];
    
//    [self.view addSubview:self.hud1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeView:) name:@"changeView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wodeGongChengButtonPressed:) name:@"wodeGongCheng" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wentiButtonPressed:) name:@"wenti" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(anliButtonPressed:) name:@"anli" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingButtonPressed:) name:@"setting" object:nil];
}

- (void)changeView:(NSNotification *)notification{
    
    NSString *tagString = [notification object];
    int switchViewTag = [tagString intValue];

    switch (showViewTag) {
        case 0:
        {
            [wodeGongChengVc.view removeFromSuperview];
            [btn_wodegongcheng setImage:[UIImage imageNamed:@"wodegongcheng"] forState:UIControlStateNormal];
        }
            break;
            
        case 1:
            [wenTiVc.view removeFromSuperview];
            [btn_wentifankui setImage:[UIImage imageNamed:@"wentifankui"] forState:UIControlStateNormal];
            break;
            
        case 2:
            [anliVc.view removeFromSuperview];
            [btn_sijimuge setImage:[UIImage imageNamed:@"sijimuge"] forState:UIControlStateNormal];
            break;
            
        case 3:
            [settingVc.view removeFromSuperview];
            [btn_shezhi setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    showViewTag = switchViewTag;
    
    switch (showViewTag) {
        case 0:
        {
            [self.view insertSubview:wodeGongChengVc.view atIndex:0];
            [btn_wodegongcheng setImage:[UIImage imageNamed:@"wodegongcheng_on"] forState:UIControlStateNormal];
            self.title = [RbtProjectModel sharedInstance].name;
            [self.tabView setSelectBtn:10];
        }
            break;
            
        case 1:
            [self.view insertSubview:wenTiVc.view atIndex:0];
            [btn_wentifankui setImage:[UIImage imageNamed:@"wentifankui_on"] forState:UIControlStateNormal];
            self.title = @"问题反馈";
            [self.tabView setSelectBtn:11];
            break;
            
        case 2:
        {
            self.title = @"工程天气";
            if (isLoad) {
                [self.view insertSubview:anliVc.view atIndex:0];
                [btn_sijimuge setImage:[UIImage imageNamed:@"sijimuge_on"] forState:UIControlStateNormal];
                [self.tabView setSelectBtn:12];
            }
            else{
                [self.hud1 show:YES];
                RbtWebManager *tqybweb = [[RbtWebManager alloc] init];
                tqybweb.name = @"tqybwebwithBaidu";
                tqybweb.delegate =self;
//                [tqybweb getWeatherInfo:[RbtProjectModel sharedInstance].citycode];
                [tqybweb getWeatherInfowithBaidu:[NSString stringWithFormat:@"%f,%f",[[RbtProjectModel sharedInstance].longitude doubleValue],[[RbtProjectModel sharedInstance].latitude doubleValue]]];

            }
        }
            break;
            
        case 3:
            [self.view insertSubview:settingVc.view atIndex:0];
            [btn_shezhi setImage:[UIImage imageNamed:@"shezhi_on"] forState:UIControlStateNormal];
            self.title = @"设置";
            [self.tabView setSelectBtn:13];
            break;
            
        default:
            break;
    }

}

-(void)wodeGongChengButtonPressed:(NSNotification *)notification
{
    NSString *tagString = [notification object];
    int tag = [tagString intValue];
    
    switch (tag) {
        case 0:
        {
            RbtReShuiGongChengYuanLiTuViewController *vc = [[RbtReShuiGongChengYuanLiTuViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1:
        {
            RbtYuanChengKongZhiViewController *vc = [[RbtYuanChengKongZhiViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2:
        {
            RbtShiShiViewController *vc = [[RbtShiShiViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3:
        {
            RbtLiShiShuJuViewController *vc = [[RbtLiShiShuJuViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            RbtJieNengViewController *vc = [[RbtJieNengViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            RbtGisDingWeiViewController *vc = [[RbtGisDingWeiViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void) wentiButtonPressed:(NSNotification *)notification{

}

- (void) anliButtonPressed:(NSNotification *)notification{
    
}

-(void)settingButtonPressed:(NSNotification *)notification
{
    NSString *tagString = [notification object];
    int tag = [tagString intValue];
    
    switch (tag) {
        case 1:
        {
            RbtWebManager *logoutManager = [RbtWebManager getRbtManager:YES];
            logoutManager.name = @"logout";
            logoutManager.delegate = self;
            [logoutManager loginOut:[RbtUserModel sharedInstance].userName];
            
        }
            break;
            
        case 2:
        {
            
        }
            break;
            
        case 3:
        {
            RbtXiuGaiMiMaViewController *xiuGaimimavc = [[RbtXiuGaiMiMaViewController alloc] initWithNibName:@"RbtXiuGaiMiMaViewController" bundle:nil];
            [self.navigationController pushViewController:xiuGaimimavc animated:YES];
        }
            break;
            
        case 4:
        {
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"tqybweb"]){
        isLoad = YES;
        anliVc.isShouYe = NO;
        anliVc.weatherInfo = responseDic;
        [anliVc initViews];
        [self.view insertSubview:anliVc.view atIndex:0];
        [btn_sijimuge setImage:[UIImage imageNamed:@"sijimuge_on"] forState:UIControlStateNormal];
        [self.tabView setSelectBtn:12];
    }
    else if ([webService.name isEqualToString:@"logout"])
    {
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if([webService.name isEqualToString:@"stringday"]){
        anliVc.weatherInfo = responseDic;
        isLoad = YES;
        anliVc.isShouYe = NO;
        anliVc.weatherInfo = responseDic;
        [anliVc initViews];
        [self.view insertSubview:anliVc.view atIndex:0];
        [btn_sijimuge setImage:[UIImage imageNamed:@"sijimuge_on"] forState:UIControlStateNormal];
        [self.tabView setSelectBtn:12];
    }
    else if ([webService.name isEqualToString:@"tqybwebwithBaidu"]){
        if ([[responseDic objectForKey:@"error"] integerValue] == 0) {
            isLoad = YES;
            anliVc.isShouYe = NO;
            anliVc.weatherInfo = responseDic;
            [anliVc initViewswithBaidu];
            [self.view insertSubview:anliVc.view atIndex:0];
            [btn_sijimuge setImage:[UIImage imageNamed:@"sijimuge_on"] forState:UIControlStateNormal];
            [self.tabView setSelectBtn:12];
        } else {
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"status"]];
        }
    }
}

-(void)webServicefailed:(RbtWebManager *)webService{
        [super webServicefailed:webService];
        if ([webService.name isEqualToString:@"tqybweb"]) {
        RbtWebManager *manager = [[RbtWebManager alloc] init];
        manager.name = @"stringday";
        manager.delegate = self;
        [manager getTheDayWeather];
        }
}

@end
