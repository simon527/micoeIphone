//
//  micYunXingYuanLiView_h.m
//  micoe(ipad)
//
//  Created by Simon_Tang on 14-4-18.
//  Copyright (c) 2014年 Simon. All rights reserved.
//

#import "micYunXingYuanLiView_h.h"
#import "RbtDataOfResponse.h"

#define FRESHTIME   10.
#define VW   1008
#define VH   768

@implementation micYunXingYuanLiView_h

@synthesize yltName, yltDic;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

-(void)initView
{
    IphoneGap = 0;
    yltName = [[RbtDataOfResponse sharedInstance].yuanlituDic objectForKey:@"t"];
    yltDic =[[RbtDataOfResponse sharedInstance].yuanlituDic objectForKey:@"d"];
    
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
        YLT903_II = [[micYLT903_II alloc] initWithFrame:CGRectMake(8, IphoneGap, VW, VH-49-64-130)];
        YLT903_II.tag = 90320;
        [self addSubview:YLT903_II];
        viewTag = 90320;
    }
    
    if ([yltName isEqualToString:@"M903-I"]) {
        YLT903_I = [[micYLT903_I alloc] initWithFrame:CGRectMake(8, IphoneGap, VW, VH-49-64-130)];
        YLT903_I.tag = 90310;
        [self addSubview:YLT903_I];
        viewTag = 90310;
    }
    
    if ([yltName isEqualToString:@"M905-III"]) {
        YLT905 = [[micYLT905 alloc] initWithFrame:CGRectMake(8, IphoneGap, VW, VH-49-64-130)];
        YLT905.tag = 90500;
        [self addSubview:YLT905];
        viewTag = 90500;
    }
    
    if ([yltName isEqualToString:@"M906-I-03"]) {
        YLT906 = [[micYLT906 alloc] initWithFrame:CGRectMake(8, IphoneGap, VW, VH-49-64-130)];
        YLT906.tag = 90630;
        [self addSubview:YLT906];
        viewTag = 90630;
    }
    
    if ([yltName isEqualToString:@"M906-I-02"]) {
        YLT906_2 = [[micYLT906_2 alloc] initWithFrame:CGRectMake(8, IphoneGap, VW, VH-49-64-130)];
        YLT906_2.tag = 90620;
        [self addSubview:YLT906_2];
        viewTag = 90620;
    }
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 100, 30)];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:now];
    timeLabel.text = dateStr;
    
    [self addSubview:timeLabel];
    
    self.timer=  [NSTimer scheduledTimerWithTimeInterval:FRESHTIME target:self selector:@selector(fresh) userInfo:nil repeats:YES];
    
}


-(void)fresh
{
//    NSDate *now = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"HH:mm:ss"];
//    NSString *dateStr = [dateFormatter stringFromDate:now];
//    timeLabel.text = dateStr;

    if (([RbtCommonTool getJinRuMode] != LiXianGongCheng) && ([[[NSUserDefaults standardUserDefaults] objectForKey:@"wodegongcheng"] intValue])) {
        [self postData];
    }
    
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
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:now];
        timeLabel.text = dateStr;
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
        
        if (YLT903_I) {
            [YLT903_I setStatus];
        }
        if (YLT903_II) {
            [YLT903_II setStatus];
        }
        if (YLT905) {
            [YLT905 setStatus];
        }
        if (YLT906) {
            [YLT906 setStatus];
        }
        if (YLT906_2) {
            [YLT906_2 setStatus];
        }
        
        
         [[NSNotificationCenter defaultCenter] postNotificationName:@"yuanlituDicGet" object:nil userInfo:nil];
    }
    
}


@end
