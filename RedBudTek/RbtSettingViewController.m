//
//  RbtSettingViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtSettingViewController.h"


@interface RbtSettingViewController ()<UIAlertViewDelegate>

@end

@implementation RbtSettingViewController

@synthesize xiugaimimaController, lg;

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
    self.title = @"设置";
	// Do any additional setup after loading the view.
    
    zhanghaozhuxiao = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhanghaozhuxiao setFrame:CGRectMake(0, 80, 320, 50)];
    [zhanghaozhuxiao setImage:[UIImage imageNamed:@"text_background"] forState:UIControlStateNormal];
    [zhanghaozhuxiao addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [zhanghaozhuxiao setTag:1];
    [self.view addSubview:zhanghaozhuxiao];
    UILabel *zhzxLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 50)];
    zhzxLabel.text = @"账号注销";
    [zhanghaozhuxiao addSubview:zhzxLabel];
    
    banbenhao = [UIButton buttonWithType:UIButtonTypeCustom];
    [banbenhao setFrame:CGRectMake(0, 80+60, 320, 50)];
    [banbenhao setImage:[UIImage imageNamed:@"text_background"] forState:UIControlStateNormal];
    [banbenhao addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [banbenhao setTag:2];
    [self.view addSubview:banbenhao];
    UILabel *bbhLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 50)];
    bbhLabel.text = @"版本号";
    [banbenhao addSubview:bbhLabel];
    
    xiugaimima = [UIButton buttonWithType:UIButtonTypeCustom];
    [xiugaimima setFrame:CGRectMake(0, 80+60*2, 320, 50)];
    [xiugaimima setImage:[UIImage imageNamed:@"text_background"] forState:UIControlStateNormal];
    [xiugaimima addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [xiugaimima setTag:3];
    [self.view addSubview:xiugaimima];
    UILabel *xgmmLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 50)];
    xgmmLabel.text = @"修改密码";
    [xiugaimima addSubview:xgmmLabel];
    
    
    serviceURL = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceURL setFrame:CGRectMake(0, 80+60*3, 320, 50)];
    [serviceURL setImage:[UIImage imageNamed:@"text_background"] forState:UIControlStateNormal];
    [serviceURL addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [serviceURL setTag:4];
    [self.view addSubview:serviceURL];
    UILabel *urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 50)];
    urlLabel.text = @"服务器URL";
    [serviceURL addSubview:urlLabel];
    
    lg = [[RbtLoginViewController alloc] init];
}

-(IBAction)buttonPressed:(UIButton *)sender
{
    if (sender.tag == 4){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改服务器URL地址" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.delegate = self;
        alert.alertViewStyle  = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alert textFieldAtIndex:0];
        //textField.keyboardType = UIKeyboardTypeNumberPad;
        NSArray *arr = [RbtCommonTool getServerSetting];
        textField.text = [NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
        [alert show];
    }
    else{
           [[NSNotificationCenter defaultCenter] postNotificationName:@"setting" object:[NSString stringWithFormat:@"%d", sender.tag]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }
    else if(buttonIndex == 1) {
        NSString *str = [alertView textFieldAtIndex:0].text;
        NSArray *arr = [str componentsSeparatedByString:@":"];
        if ([arr count]==2) {
            [RbtCommonTool setServerSetting:arr];
        }
    }
}

@end
