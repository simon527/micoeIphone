//
//  RbWodeGongChengViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-16.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtWodeGongChengViewController.h"
#import "RbtGisDingWeiViewController.h"
#import "RbtDataOfjienengshitu.h"
#import "RbtDataOfResponse.h"

#define GAP 3
#define TOP (34-6)/2 + 64-8
#define SIDE    (10-3)/2
#define BTNWIDTH    310/2



//#define BTNHEIGHT   292/2

@interface RbtWodeGongChengViewController ()

@end

@implementation RbtWodeGongChengViewController


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
    float BTNHEIGHT;
    NSString *imageName;
    if (IS_IPHONE_5) {
        BTNHEIGHT = 292/2;
        imageName = @"daohang";
    }
    else
    {
        BTNHEIGHT = 292/2 -30;
        imageName = @"daohangxiao";
    }
    
    
    self.title  = @"我的工程";
    [self.tabBarController setTitle:@"我的工程"];
    
//    sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-49)];
//    sc.contentSize = CGSizeMake(self.view.width, 568-64-35);
//    //[sc setBackgroundColor:[UIColor grayColor]];
//    sc.delegate= self;
//    [self.view addSubview:sc];
    
    float x = SIDE;
    float y = TOP;
    
    for (int i = 0; i <= 5; i++) {
        UIButton *btn_daohang = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_daohang setTag:i];
        [btn_daohang setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d", imageName, i+1]] forState:UIControlStateNormal];
        [btn_daohang addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn_daohang setFrame:CGRectMake(x, y, BTNWIDTH, BTNHEIGHT)];
        [self.view addSubview:btn_daohang];
        NSLog(@"%d", i%2);
        x += BTNWIDTH + GAP;
        if (i % 2)
        {
            x = SIDE;
            y += GAP + BTNHEIGHT;
        }
        [btn_daohang addTarget:self action:@selector(wodeGongchengBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
	// Do any additional setup after loading the view.
    
    yuanlituVC = [[RbtReShuiGongChengYuanLiTuViewController alloc] init];
    yuanchengVC = [[RbtYuanChengKongZhiViewController alloc] init];
    shishiVC = [[RbtShiShiViewController alloc] init];
    lishiVC = [[RbtLiShiShuJuViewController alloc] init];
    jienengVC = [[RbtJieNengViewController alloc] init];
    dingweiVC = [[RbtGisDingWeiViewController alloc] init];
    
//    [self.view addSubview:self.hud1];
    
    
    
    
}




-(void)btnClicked:(UIButton *)btn
{
//    int tag = btn.tag;
    switch (btn.tag) {
        case 0:
        {
            [self.navigationController pushViewController:yuanlituVC animated:YES];
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

- (void)wodeGongchengBtnPressed:(UIButton *)sender{
    tag = sender.tag;
    RbtWebManager *webManager;
    if([RbtCommonTool getJinRuMode] != LiXianGongCheng){
        webManager = [RbtWebManager getRbtManager:YES];
    }
    else{
        webManager = [RbtWebManager getRbtManager:NO];
    }
    switch (tag) {
        case 0:
            {
                if ([[RbtUserModel sharedInstance].yxyl isEqualToString:@"n"]) {
                    [RbtCommonTool showInfoAlert:@"用户无权限"];
                }
                else{
                    webManager.name = @"yuanlituWeb";
                    webManager.delegate = self;
                    [self.hud1 show:YES];
                    [webManager getrunprincipleWithP:[RbtProjectModel sharedInstance].projectid];
                }
                
            }
            break;
        case 1:
        {
            
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
            
        }
            break;
        case 2:
        {
            if ([[RbtUserModel sharedInstance].sssj isEqualToString:@"n"]) {
                [RbtCommonTool showInfoAlert:@"用户无权限"];
            }
            else{
                webManager.name = @"shishishuju";
                webManager.delegate = self;
                [self.hud1 show:YES];
                [webManager getrunprincipleWithP:[RbtProjectModel sharedInstance].projectid];
            }
        //            [webManager getrunprincipleWithP:@"13"];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
        }
            break;
        case 3:
        {
            if ([[RbtUserModel sharedInstance].lssj isEqualToString:@"n"]) {
                [RbtCommonTool showInfoAlert:@"用户无权限"];
            }
            else{
                [self.hud1 show:YES];
                webManager.name = @"lishishuju1";
                webManager.delegate = self;
                [webManager getrunprincipleWithP:[RbtProjectModel sharedInstance].projectid];
            }
            break;
        case 4:
        {
            if ([[RbtUserModel sharedInstance].jnst isEqualToString:@"n"]) {
                [RbtCommonTool showInfoAlert:@"用户无权限"];
            }
            else{
                webManager.name = @"jienengweb";
                webManager.delegate = self;
                [self.hud1 show:YES];
                [webManager getJieNengInfoWithU:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid andT:@"1"];
            }
        }
            break;
        case 5:
        {
            if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            [RbtCommonTool showInfoAlert:@"请登录后查看"];
            }
            else{
                if ([[RbtUserModel sharedInstance].gisdw isEqualToString:@"n"]) {
                    [RbtCommonTool showInfoAlert:@"用户无权限"];
                }
                else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
                }
            }
        }
            break;
        default:
            break;
        }
    }
}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"jienengweb"]) {
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            [RbtDataOfResponse sharedInstance].jienengDic = responseDic;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
        }
        else{
            if ([[responseDic objectForKey:@"rc"] intValue]) {
                NSDictionary *tempDIc = [responseDic objectForKey:@"rt"];
                [RbtDataOfResponse sharedInstance].jienengDic = tempDIc;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
            }
            else
            {
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
    }

    if ([webService.name isEqualToString:@"yuanlituWeb"]) {
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            [RbtDataOfResponse sharedInstance].yuanlituDic = responseDic;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
        }
        else{
            if ([[responseDic objectForKey:@"rc"] intValue]) {
                NSDictionary *tempDIc = [responseDic objectForKey:@"rt"];
                [RbtDataOfResponse sharedInstance].yuanlituDic = tempDIc;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
            }
            else
            {
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
    }
    
    if ([webService.name isEqualToString:@"shishishuju"]) {
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            [RbtDataOfResponse sharedInstance].yuanlituDic = responseDic;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
        }
        else{
            if ([[responseDic objectForKey:@"rc"] intValue]) {
                NSDictionary *tempDIc = [responseDic objectForKey:@"rt"];
                [RbtDataOfResponse sharedInstance].yuanlituDic = tempDIc;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
            }
            else
            {
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
    }
    
    if ([webService.name isEqualToString:@"getgetpermission"]) {
            if ([[responseDic objectForKey:@"rc"] intValue]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
            }
            else
            {
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
    
    if ([webService.name isEqualToString:@"lishishuju"]) {
        if ([[responseDic objectForKey:@"rc"] intValue]) {
            NSLog(@"---dic = %@--", responseDic);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
        }
        else
        {
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    if ([webService.name isEqualToString:@"lishishuju1"]) {
        
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            [RbtDataOfResponse sharedInstance].lishishujuGongChengLieBiaoDic = responseDic;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
        }
        else{
            if ([[responseDic objectForKey:@"rc"] intValue]) {
                NSDictionary *tempDIc = [responseDic objectForKey:@"rt"];
                [RbtDataOfResponse sharedInstance].lishishujuGongChengLieBiaoDic = tempDIc;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wodeGongCheng" object:[NSString stringWithFormat:@"%d", tag]];
            }
            else
            {
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
        
    }

    }
@end
