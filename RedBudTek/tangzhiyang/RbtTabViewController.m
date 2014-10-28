//
//  RbtTabViewController.m
//  RedBudTek
//
//  Created by Simon on 13-11-28.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtTabViewController.h"

#define NUMOFTABBARBUTTON   4
#define TABBARHEIGHT    49

@interface RbtTabViewController ()

@end

@implementation RbtTabViewController

@synthesize btn_shezhi, btn_sijimuge, btn_wentifankui, btn_wodegongcheng;

@synthesize customTabbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    wodeGongChengVc = [[RbtWodeGongChengViewController alloc] init];
//    wenTiVc = [[RbtWenTiFanKuiListViewController alloc] init];
//    anliVc = [[RbtAnLiJiGongSiJianJieViewController alloc] init];
//    settingVc =[[RbtSettingViewController alloc] init];
//    
//    
//    controllersArray = [[NSMutableArray alloc] initWithObjects:wodeGongChengVc, wenTiVc, anliVc, settingVc, nil];
//    
//    int i = 0;
//    for (UIViewController *controller in controllersArray ) {
//        [controller.view setTag:i];
//        if (i == 0) {
//            [self.view addSubview:controller.view];
//            showViewTag = i;
//        }
//        i++;
//    }
    
    float screenHeight = IS_IPHONE_5?568:480;
    
//    customTabbar = [[UIImageView alloc] initWithFrame:CGRectMake(0, screenHeight-TABBARHEIGHT, self.view.width, TABBARHEIGHT)];
//    [customTabbar setImage:[UIImage imageNamed:@"customTabbar"]];
//    [self.view addSubview:customTabbar];
//    
//    float BTN_WIDTH = self.view.bounds.size.width/NUMOFTABBARBUTTON;
//    
//    btn_wodegongcheng = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_wodegongcheng setTag:10];
//    [btn_wodegongcheng setImage:[UIImage imageNamed:@"wodegongcheng_on"] forState:UIControlStateNormal];
//    [btn_wodegongcheng setFrame:CGRectMake(0 + BTN_WIDTH*0, screenHeight-49, BTN_WIDTH, 49)];
//    [btn_wodegongcheng addTarget:self action:@selector(tabBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_wodegongcheng];
//    
//    btn_wentifankui = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_wentifankui setTag:11];
//    [btn_wentifankui setImage:[UIImage imageNamed:@"wentifankui"] forState:UIControlStateNormal];
//    [btn_wentifankui setFrame:CGRectMake(0 + BTN_WIDTH*1, screenHeight-49, BTN_WIDTH, 49)];
//    [btn_wentifankui addTarget:self action:@selector(tabBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_wentifankui];
//    
//    btn_sijimuge = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_sijimuge setTag:12];
//    [btn_sijimuge setImage:[UIImage imageNamed:@"sijimuge"] forState:UIControlStateNormal];
//    [btn_sijimuge setFrame:CGRectMake(0 + BTN_WIDTH*2, screenHeight-49, BTN_WIDTH, 49)];
//    [btn_sijimuge addTarget:self action:@selector(tabBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_sijimuge];
//    
//    btn_shezhi = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_shezhi setTag:13];
//    [btn_shezhi setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
//    [btn_shezhi setFrame:CGRectMake(0 + BTN_WIDTH*3, screenHeight-49, BTN_WIDTH, 49)];
//    [btn_shezhi addTarget:self action:@selector(tabBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_shezhi];
    
    customTabbar = [[RbtTabbarView alloc] initWithFrame:CGRectMake(0, screenHeight-49, self.view.width, 49)];
    [self.view addSubview:customTabbar];
}

-(void)setTabbarHidden:(BOOL)isHidden
{
    if (isHidden) {
        customTabbar.hidden = YES;
    }
    else
    {
        customTabbar.hidden = NO;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
