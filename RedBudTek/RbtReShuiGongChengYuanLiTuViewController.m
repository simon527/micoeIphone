//
//  RbtReShuiGongChengYuanLiTuViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtReShuiGongChengYuanLiTuViewController.h"
#import "RbtDataOfResponse.h"

#define FRESHTIME   10.0

@interface RbtReShuiGongChengYuanLiTuViewController ()

@end

@implementation RbtReShuiGongChengYuanLiTuViewController

@synthesize yltName, yltDic;

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
    self.view.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
	// Do any additional setup after loading the view.
    self.title = @"运行原理";
    
    self.yltName = [[RbtDataOfResponse sharedInstance].yuanlituDic objectForKey:@"t"];
    self.yltDic =[[RbtDataOfResponse sharedInstance].yuanlituDic objectForKey:@"d"];
    
    
//    NSLog(@"---%@---\n_______%@----", yltName, yltDic);

    if (IS_IPHONE_5) {
        IphoneGap = (568-480)/2-49/2;
        [self setTabbarHidden:NO];
    }
    else{
        IphoneGap = 0;
        [self setTabbarHidden:YES];
    }
    
    for (NSDictionary *tempDic in yltDic) {
        if ([[tempDic objectForKey:@"n"] isEqualToString:@"W_S"]) {
            [RbtDataOfResponse sharedInstance].num_W1_S = [tempDic objectForKey:@"v"];
        }
        if ([[tempDic objectForKey:@"n"] isEqualToString:@"W1_S"]) {
            [RbtDataOfResponse sharedInstance].num_W1_S = [tempDic objectForKey:@"v"];
        }
        if ([[tempDic objectForKey:@"n"] isEqualToString:@"W2_S"]) {
            [RbtDataOfResponse sharedInstance].num_W2_S = [tempDic objectForKey:@"v"];
        }
        if ([[tempDic objectForKey:@"n"] isEqualToString:@"T2_S"]) {
            [RbtDataOfResponse sharedInstance].num_T1_S = [tempDic objectForKey:@"v"];
        }
        if ([[tempDic objectForKey:@"n"] isEqualToString:@"T4_S"]) {
            [RbtDataOfResponse sharedInstance].num_T2_S = [tempDic objectForKey:@"v"];
        }
    }
    
    if ([yltName isEqualToString:@"M903-II"]) {        
        YLT903_II_V = [[RbtYLT903_II_V alloc] initWithFrame:CGRectMake(0, IphoneGap, 320, 480)];
        YLT903_II_V.tag = 90320;
        YLT903_II_H = [[RbtYLT903_II_H alloc] initWithFrame:CGRectMake(IphoneGap, 0, 480, 320)];
        YLT903_II_H.tag = 90321;
        [self.view addSubview:YLT903_II_V];
        [self.view addSubview:YLT903_II_H];
        YLT903_II_H.hidden = YES;
        viewTag = 90320;
    }
    
    if ([yltName isEqualToString:@"M903-I"]) {
        YLT903_I_V = [[RbtYLT903_I_V alloc] initWithFrame:CGRectMake(0, IphoneGap, 320, 480)];
        YLT903_I_V.tag = 90310;
        YLT903_I_H = [[RbtYLT903_I_H alloc] initWithFrame:CGRectMake(IphoneGap, 0, 480, 320)];
        YLT903_I_H.tag = 90311;
        [self.view addSubview:YLT903_I_V];
        [self.view addSubview:YLT903_I_H];
        YLT903_I_H.hidden = YES;
        viewTag = 90310;
    }
    
    if ([yltName isEqualToString:@"M905-III"]) {
        YLT905_V = [[RbtYLT905_V alloc] initWithFrame:CGRectMake(0, IphoneGap, 320, 480)];
        YLT905_V.tag = 90500;
        YLT905_H = [[RbtYLT905_H alloc] initWithFrame:CGRectMake(IphoneGap, 0, 480, 320)];
        YLT905_H.tag = 90501;
        [self.view addSubview:YLT905_V];
        [self.view addSubview:YLT905_H];
    YLT905_H.hidden = YES;
        viewTag = 90500;
    }
    
    if ([yltName isEqualToString:@"M906-I-03"]) {
        YLT906_V = [[RbtYLT906_V alloc] initWithFrame:CGRectMake(0, IphoneGap, 320, 480)];
        YLT906_V.tag = 90630;
        YLT906_H = [[RbtYLT906_H alloc] initWithFrame:CGRectMake(IphoneGap, 0, 480, 320)];
        YLT906_H.tag = 90631;
        [self.view addSubview:YLT906_V];
        [self.view addSubview:YLT906_H];
        YLT906_H.hidden = YES;
        viewTag = 90630;
    }
    
    if ([yltName isEqualToString:@"M906-I-02"]) {
        YLT906_V_2 = [[RbtYLT906_V_2 alloc] initWithFrame:CGRectMake(0, IphoneGap, 320, 480)];
        YLT906_V_2.tag = 90620;
        YLT906_H_2 = [[RbtYLT906_H_2 alloc] initWithFrame:CGRectMake(IphoneGap, 0, 480, 320)];
        YLT906_H_2.tag = 90621;
        [self.view addSubview:YLT906_V_2];
        [self.view addSubview:YLT906_H_2];
        YLT906_H_2.hidden=YES;
        viewTag = 90620;
    }
    
    timer=  [NSTimer scheduledTimerWithTimeInterval:FRESHTIME target:self selector:@selector(fresh) userInfo:nil repeats:YES];
    
}


-(void)fresh
{
    [self postData];
}

-(void)postData
{
    RbtWebManager *webManager;
    if([RbtCommonTool getJinRuMode] != LiXianGongCheng){
        webManager = [RbtWebManager getRbtManager:YES];
    }
    else{
        webManager = [RbtWebManager getRbtManager:NO];
    }

    if ([[RbtUserModel sharedInstance].yxyl isEqualToString:@"n"]) {
        [RbtCommonTool showInfoAlert:@"用户无权限"];
    }
    else{
        webManager.name = @"yuanlituWeb";
        webManager.delegate = self;
//        [self.hud1 show:YES];
        [webManager getrunprincipleWithP:[RbtProjectModel sharedInstance].projectid];
    }
}

-(void)onDataLoadWithService:(RbtWebManager *)webService andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"yuanlituWeb"]) {
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            [RbtDataOfResponse sharedInstance].yuanlituDic = responseDic;
        }
        else{
            if ([[responseDic objectForKey:@"rc"] intValue]) {
                NSDictionary *tempDIc = [responseDic objectForKey:@"rt"];
                [RbtDataOfResponse sharedInstance].yuanlituDic = tempDIc;
            }
            else
            {
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
        
        if (!YLT903_I_H.hidden) {
            [YLT903_I_H setStatus];
            [YLT903_I_V setStatus];
        }
        if (!YLT903_II_H.hidden) {
            [YLT903_II_H setStatus];
            [YLT903_II_V setStatus];
        }
        if (!YLT905_H.hidden) {
            [YLT905_H setStatus];
            [YLT905_V setStatus];
        }
        if (!YLT906_H.hidden) {
            [YLT906_H setStatus];
            [YLT906_V setStatus];
        }
        if (!YLT906_H_2.hidden) {
            [YLT906_H_2 setStatus];
            [YLT906_V_2 setStatus];
        }
//        if (!YLT903_I_H) {
//            [YLT903_I_H setStatus];
//            [YLT903_I_V setStatus];
//        }

    }

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        [[self.view viewWithTag:(viewTag+1)] setHidden:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self.navigationController setNavigationBarHidden:NO];
        [[self.view viewWithTag:viewTag] setHidden:NO];
    }
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [[self.view viewWithTag:viewTag] setHidden:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.navigationController setNavigationBarHidden:YES];
        [[self.view viewWithTag:(viewTag+1)] setHidden:NO];
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//     [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
