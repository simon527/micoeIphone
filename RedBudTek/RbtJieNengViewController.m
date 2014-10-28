//
//  RbtJieNengViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
// 

#import "RbtJieNengViewController.h"
#import "RbtDataOfjienengshitu.h"
#import "RbtDataOfResponse.h"

@interface RbtJieNengViewController ()

@end

@implementation RbtJieNengViewController

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
    
    chooseTime = @"1";
    chooseType = @"sco";
    
    self.title = @"节能视图";
    float gap1;
    float gap2;
    float gap3;
    float fontNum;
    
    if (IS_IPHONE_5) {
        gap1 = 25;
        gap2 = 25;
        gap3 = 25;
        fontNum = 80;
    }
    else
    {
        gap1 = 5;
        gap2 = 5;
        gap3 = 5;
        fontNum = 60;
    }
    
    float sideGap = 13/2;
    
    UIImageView *upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(sideGap, 64+gap1, 614/2, 428/2+(gap1-25)*3/2)];
    [upImageView setImage:[UIImage imageNamed:@"image_up"]];
    [self.view addSubview:upImageView];
    
    UIImageView *downImageView = [[UIImageView alloc] initWithFrame:CGRectMake(sideGap, 64+gap1+upImageView.height+gap2, 614/2, 332/2)];
    [downImageView setImage:[UIImage imageNamed:@"image_down"]];
    [self.view addSubview:downImageView];
    
    float top_btn = (332-270)/2;
    float gap_btn = (614-492)/2/6;

    btn_jireqi = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_jireqi setTag:0];
    [btn_jireqi setFrame:CGRectMake(sideGap+gap_btn, 64+gap1+upImageView.height+gap2+top_btn, 164/2, 270/2)];
    [btn_jireqi setImage:[UIImage imageNamed:@"btn_jireqi"] forState:UIControlStateNormal];
    [btn_jireqi addTarget:self action:@selector(jienengBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_jireqi];
    
    btn_leijijianpai = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_leijijianpai setTag:1];
    [btn_leijijianpai setFrame:CGRectMake(sideGap+gap_btn*3+164/2, 64+gap1+upImageView.height+gap2+top_btn, 164/2, 270/2)];
    [btn_leijijianpai setImage:[UIImage imageNamed:@"btn_leijijianpai_s"] forState:UIControlStateNormal];
    [btn_leijijianpai addTarget:self action:@selector(jienengBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_leijijianpai];
    
    UIButton *button_time = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_time setImage:[UIImage imageNamed:@"btn_time"] forState:UIControlStateNormal];
    [button_time addTarget:self action:@selector(timeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button_time setFrame:CGRectMake(22, gap1+75, 26, 26)];
    [self.view addSubview:button_time];
    
    btn_leijijieyue = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_leijijieyue setTag:2];
    [btn_leijijieyue setFrame:CGRectMake(sideGap+gap_btn*5+164, 64+gap1+upImageView.height+gap2+top_btn, 164/2, 270/2)];
    [btn_leijijieyue setImage:[UIImage imageNamed:@"btn_leijijieyue"] forState:UIControlStateNormal];
    [btn_leijijieyue addTarget:self action:@selector(jienengBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_leijijieyue];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(57, gap1+63, 250, 50)];
    timeLabel.text = @"最近一个月";
    [timeLabel setTextColor:[UIColor whiteColor]];
    [timeLabel setTextAlignment:NSTextAlignmentLeft];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [timeLabel setFont:[UIFont fontWithName:kFontName size:20]];
    [self.view addSubview:timeLabel];
    
    titleLbel = [[UILabel alloc] initWithFrame:CGRectMake(20, gap1+115, 250, 50)];
    titleLbel.text = @"累计减排二氧化碳";
    [titleLbel setTextAlignment:NSTextAlignmentLeft];
    [titleLbel setBackgroundColor:[UIColor clearColor]];
    [titleLbel setFont:[UIFont fontWithName:kFontName size:22]];
    [self.view addSubview:titleLbel];
    
    showLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, gap1+145, 220, 120)];
//    showLabel.text = [RbtDataOfjienengshitu sharedInstance].sco;
    showLabel.text = [[RbtDataOfResponse sharedInstance].jienengDic objectForKey:chooseType];
    [showLabel setTextAlignment:NSTextAlignmentRight];
    [showLabel setBackgroundColor:[UIColor clearColor]];

    [showLabel setFont:[UIFont fontWithName:kFontName size:fontNum]];
//    [showLabel sizeToFit];
    
    [self.view addSubview:showLabel];
    
    unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, gap1+210, 80, 40)];
    unitLabel.text = @"吨";
    //    NSLog(@"ssss %@", showLabel.text);
//    [unitLabel setTextAlignment:NSTextAlignmentCenter];
    [unitLabel setBackgroundColor:[UIColor clearColor]];
    
    [unitLabel setFont:[UIFont fontWithName:kFontName size:25]];
    [unitLabel sizeToFit];
    
    [self.view addSubview:unitLabel];
    
    
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择时间" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"最近一个月", @"最近三个月",  @"最近一年", nil];
    

}

-(void)jienengBtnClicked:(UIButton *)btn
{
    [btn_jireqi setImage:[UIImage imageNamed:@"btn_jireqi"] forState:UIControlStateNormal];
    [btn_leijijianpai setImage:[UIImage imageNamed:@"btn_leijijianpai"] forState:UIControlStateNormal];
    [btn_leijijieyue setImage:[UIImage imageNamed:@"btn_leijijieyue"] forState:UIControlStateNormal];
    int tag = btn.tag;
    switch (tag) {
        case 0:
            [btn_jireqi setImage:[UIImage imageNamed:@"btn_jireqi_s"] forState:UIControlStateNormal];
            titleLbel.text = @"集热器方阵累计热量";
            unitLabel.text = @"焦";
//            showLabel.text = [RbtDataOfjienengshitu sharedInstance].sc;
            chooseType = @"sc";
            break;
        case 1:
            [btn_leijijianpai setImage:[UIImage imageNamed:@"btn_leijijianpai_s"] forState:UIControlStateNormal];
            titleLbel.text = @"累计减排二氧化碳";
            unitLabel.text = @"吨";
//            showLabel.text = [RbtDataOfjienengshitu sharedInstance].sco;
            chooseType = @"sco";
            break;
        case 2:
            [btn_leijijieyue setImage:[UIImage imageNamed:@"btn_leijijieyue_s"] forState:UIControlStateNormal];
            titleLbel.text = @"累计节约电量";
            unitLabel.text = @"度";
//            showLabel.text = [RbtDataOfjienengshitu sharedInstance].sp;
            chooseType = @"sp";
            break;
            
        default:
            break;
    }
    [self postData];
}

-(void)timeButtonClicked:(UIButton *)sender
{
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"index %d", buttonIndex);
    switch (buttonIndex) {
        case 0:
            timeLabel.text = @"最近一个月";
            chooseTime = @"1";
            break;
            
        case 1:
            timeLabel.text = @"最近三个月";
            chooseTime = @"3";
            break;
            
        case 2:
            timeLabel.text = @"最近一年";
            chooseTime = @"12";
            break;
            
        default:
            break;
    }
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
    webManager.name = @"jienengweb";
    webManager.delegate = self;
    [self.hud1 show:YES];
    [webManager getJieNengInfoWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid andT:chooseTime];

}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"jienengweb"]) {
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            [RbtDataOfResponse sharedInstance].jienengDic = responseDic;
//            [RbtDataOfjienengshitu sharedInstance].sc = [responseDic objectForKey:@"sc"];
//            [RbtDataOfjienengshitu sharedInstance].sp = [responseDic objectForKey:@"sp"];
//            [RbtDataOfjienengshitu sharedInstance].sco = [responseDic objectForKey:@"sco"];
        }
        else{
            if ([(NSString *)[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
                NSDictionary *tempDIc = [responseDic objectForKey:@"rt"];
                [RbtDataOfResponse sharedInstance].jienengDic = tempDIc;
//                [RbtDataOfResponse sharedInstance].jienengDic = [[NSDictionary alloc] initWithDictionary:tempDIc];
//                [RbtDataOfjienengshitu sharedInstance].sc = [tempDIc objectForKey:@"sc"];
//                [RbtDataOfjienengshitu sharedInstance].sp = [tempDIc objectForKey:@"sp"];
//                [RbtDataOfjienengshitu sharedInstance].sco = [tempDIc objectForKey:@"sco"];
            }
            else
            {
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
    }
    
//    if ([chooseType isEqualToString:@"sc"]) {
////        showLabel.text = [RbtDataOfjienengshitu sharedInstance].sc;
//    }
//    if ([chooseType isEqualToString:@"sp"]) {
//        showLabel.text = [RbtDataOfjienengshitu sharedInstance].sp;
//    }
//    if ([chooseType isEqualToString:@"sco"]) {
//        showLabel.text = [RbtDataOfjienengshitu sharedInstance].sco;
//    }
////    [showLabel sizeToFit];
////    [showLabel setTextAlignment:NSTextAlignmentCenter];
    
    showLabel.text = [[RbtDataOfResponse sharedInstance].jienengDic objectForKey:chooseType];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
