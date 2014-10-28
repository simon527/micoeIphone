//
//  RbtXiuGaiMiMaViewController.m
//  RedBudTek
//
//  Created by Simon on 13-11-18.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtXiuGaiMiMaViewController.h"
#import "RbtTabbarView.h"

@interface RbtXiuGaiMiMaViewController ()

@end

@implementation RbtXiuGaiMiMaViewController

@synthesize originalPW,lastPW, confirmPW, confirmButton, cancleButton;

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
    self.title = @"修改密码";
	// Do any additional setup after loading the view.
//    
//    RbtTabbarView *tabbar = [[RbtTabbarView alloc] initWithFrame:CGRectMake(0, self.view.height-49, self.view.width, 49)];
//    [self.view addSubview:tabbar];
    [self.customTabbar setSelectBtn:13];
//    [self.view addSubview:self.hud1];
    
    self.originalPW.delegate = self;
    self.lastPW.delegate = self;
    self.confirmPW.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)xiugaimimaBtnPressed:(UIButton *)sender {
    if ([self.lastPW.text isEqualToString:self.confirmPW.text]) {
        [self.hud1 show:YES];
        RbtWebManager *geDiGongCengWebManager = [[RbtWebManager alloc] init];
        geDiGongCengWebManager.name =@"updatePassword";
        geDiGongCengWebManager.delegate = self;
        [geDiGongCengWebManager updatepassword:[RbtUserModel sharedInstance].userName withOldPassword:self.originalPW.text andNewPasswork:self.lastPW.text];
    }
    else{
        [RbtCommonTool showInfoAlert:@"新密码两次输入不一致"];
    }

    
}
- (IBAction)cancelBtnPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"updatePassword"]) {
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
           [RbtCommonTool showInfoAlert:@"修改成功"];
        }
        else{
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
}

@end
