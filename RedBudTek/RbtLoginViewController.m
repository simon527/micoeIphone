//
//  RbtLoginViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-6.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtLoginViewController.h"
#import "DCRoundSwitch.h"
#import "RbtLoginWaitViewController.h"
#import "RbtGeDiGongChengViewController.h"
#import "RbtTianQiYuBaoViewController.h"
#import "RbtXiTongGongGaoViewController.h"
#import "RbtLiXianYanShiViewController.h"

@interface RbtLoginViewController ()

@end

@implementation RbtLoginViewController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initViews];
//    [self.view addSubview:self.hud1];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.textF_Username resignFirstResponder];
    [self.textF_Password resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [super viewWillDisappear:animated];
}

- (void)initViews{
    
    self.scrollView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.scrollView];
    [self.scrollView addTarget:self action:@selector(backgroundTap) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.scrollView addSubview:imgLogo];
    
    UIImageView *login_inputbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_inputbg"]];
    [self.scrollView addSubview:login_inputbg];
    
    UILabel *labUser = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    [labUser setFont:[UIFont fontWithName:kFontName size:15]];
    labUser.text = @"用户名";
    [self.scrollView addSubview:labUser];
    
    UILabel *labPassword = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    [labPassword setFont:[UIFont fontWithName:kFontName size:15]];
    labPassword.text = @"密    码";
    [self.scrollView addSubview:labPassword];
    
    self.textF_Username = [[UITextField alloc] init];
    self.textF_Username.delegate = self;
    [self.textF_Username setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.textF_Username setReturnKeyType:UIReturnKeyDone];
    self.textF_Username.placeholder = @"username";
    [self.scrollView addSubview:self.textF_Username];
    
    self.textF_Password = [[UITextField alloc] init];
    self.textF_Password.delegate = self;
    [self.textF_Password setReturnKeyType:UIReturnKeyDone];
    [self.textF_Password setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.textF_Password setSecureTextEntry:YES];
    self.textF_Password.placeholder = @"password";
    [self.scrollView addSubview:self.textF_Password];
    
    UILabel *labLoginAuto = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    labLoginAuto.text = @"自动登录";
    [labLoginAuto setFont:[UIFont fontWithName:kFontName size:15]];
    labLoginAuto.textColor = [UIColor colorWithRed:71/255.0 green:190/255.0 blue:184/255.0 alpha:1];
    [self.scrollView addSubview:labLoginAuto];
    
    UIButton *btn_ServerUrl = [UIButton buttonWithType:UIButtonTypeCustom];
    NSAttributedString *btn_ServerUrlTitle = [[NSAttributedString alloc] initWithString:@"设置" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kFontName size:15],UITextAttributeFont,[UIColor colorWithRed:71/255.0 green:190/255.0 blue:184/255.0 alpha:1],UITextAttributeTextColor, nil]];
    [btn_ServerUrl setAttributedTitle:btn_ServerUrlTitle forState:UIControlStateNormal];
    [btn_ServerUrl addTarget:self action:@selector(btn_ServerUrlPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn_ServerUrl];
    
//    UISwitch *btnSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 80, 34)];
//    btnSwitch.tintColor = [UIColor colorWithRed:71/255.0 green:190/255.0 blue:184/255.0 alpha:1];
//     btnSwitch.onTintColor = [UIColor colorWithRed:71/255.0 green:190/255.0 blue:184/255.0 alpha:1];
//     btnSwitch.transform = CGAffineTransformMakeScale(0.6, 0.6);
//    [self.view addSubview:btnSwitch];
    
    DCRoundSwitch *btnSwitch = [[DCRoundSwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 17)];
    btnSwitch.onTintColor = [UIColor colorWithRed:71/255.0 green:190/255.0 blue:184/255.0 alpha:1];
    [btnSwitch addTarget:self action:@selector(swithValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:btnSwitch];
    
    self.isAutoLogin = NO;
    
    NSArray *loginInfo = [RbtCommonTool getLogin];
    if (loginInfo != Nil & [loginInfo count] != 0) {
        if ([loginInfo count] == 3) {
            self.isAutoLogin = [(NSNumber *)[loginInfo objectAtIndex:0] boolValue];
            if (self.isAutoLogin) {
                [btnSwitch setOn:YES];
                self.textF_Username.text = [loginInfo objectAtIndex:1];
                self.textF_Password.text = [loginInfo objectAtIndex:2];
            }
        }
    }
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [self.scrollView addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *forgetPassword = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetPassword addTarget:self action:@selector(getPasswordBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:forgetPassword];
    
    UIButton *btn_gedigongcheng = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_gedigongcheng setImage:[UIImage imageNamed:@"gedigongcheng_640"] forState:UIControlStateNormal];
    [self.scrollView addSubview:btn_gedigongcheng];
    [btn_gedigongcheng addTarget:self action:@selector(btn_gedigongchengPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn_tianqiyubao = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_tianqiyubao setImage:[UIImage imageNamed:@"tianqiyubao_640"] forState:UIControlStateNormal];
    [btn_tianqiyubao addTarget:self action:@selector(btn_tianqiyubaoPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn_tianqiyubao];
    
    UIButton *btn_xitonggonggao = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_xitonggonggao setImage:[UIImage imageNamed:@"xitonggonggao_640"] forState:UIControlStateNormal];
    [btn_xitonggonggao addTarget:self action:@selector(btn_xitonggonggaoPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn_xitonggonggao];
    
    UIButton *btn_lixianyanshi = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_lixianyanshi setImage:[UIImage imageNamed:@"lixianyanshi_640"] forState:UIControlStateNormal];
    [btn_lixianyanshi addTarget:self action:@selector(btn_lixianyanshiPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn_lixianyanshi];
    
    if (IS_IPHONE_5) {
        imgLogo.frame = CGRectMake((ScreenWidth-imgLogo.width)/2, 50+30,imgLogo.width, imgLogo.height);
        login_inputbg.frame = CGRectMake(15, 210+50, 290, login_inputbg.height);
        labUser.frame = CGRectMake(32, 203+50, labUser.width, labUser.height);
        labPassword.frame = CGRectMake(32, 245+50, labPassword.width, labPassword.height);
        
        self.textF_Username.frame = CGRectMake(10+labUser.width, 203+50, 150, labUser.height);
        self.textF_Password.frame = CGRectMake(10+labPassword.width, 245+50, 150, labPassword.height);
        
        labLoginAuto.frame = CGRectMake(32, 290+50, labLoginAuto.width, labLoginAuto.height);
        btnSwitch.frame = CGRectMake(101, 302+50, btnSwitch.width, btnSwitch.height);
        btn_ServerUrl.frame = CGRectMake(250, 290+50, 60, 40);
        
        forgetPassword.frame = CGRectMake(ScreenWidth-85, 253+50, 60, 40);
        
        loginBtn.frame = CGRectMake(15, 335+60, 290, 44);
        
        btn_gedigongcheng.frame = CGRectMake(0, ScreenHeight-65, 80, 65);
        btn_tianqiyubao.frame = CGRectMake(80, ScreenHeight-65, 80, 65);
        btn_xitonggonggao.frame = CGRectMake(80*2, ScreenHeight-65, 80, 65);
        btn_lixianyanshi.frame = CGRectMake(80*3, ScreenHeight-65, 80, 65);
    }
    else{
        imgLogo.frame = CGRectMake((ScreenWidth-imgLogo.width)/2, 50,imgLogo.width, imgLogo.height);
        login_inputbg.frame = CGRectMake((ScreenWidth-login_inputbg.width)/2, 210, login_inputbg.width, login_inputbg.height);
        labUser.frame = CGRectMake(32, 203, labUser.width, labUser.height);
        labPassword.frame = CGRectMake(32, 245, labPassword.width, labPassword.height);
        self.textF_Username.frame = CGRectMake(10+labUser.width, 203, 150, labUser.height);
        self.textF_Password.frame = CGRectMake(10+labPassword.width, 245, 150, labPassword.height);
        
        labLoginAuto.frame = CGRectMake(32, 290, labLoginAuto.width, labLoginAuto.height);
        btnSwitch.frame = CGRectMake(101, 302, btnSwitch.width, btnSwitch.height);
        btn_ServerUrl.frame = CGRectMake(250, 290, 60, 40);
        
        forgetPassword.frame = CGRectMake(ScreenWidth-85, 253, 60, 40);
        
        loginBtn.frame = CGRectMake(15, 335, 290, 44);
        
        btn_gedigongcheng.frame = CGRectMake(0, ScreenHeight-65, 80, 65);
        btn_tianqiyubao.frame = CGRectMake(80, ScreenHeight-65, 80, 65);
        btn_xitonggonggao.frame = CGRectMake(80*2, ScreenHeight-65, 80, 65);
        btn_lixianyanshi.frame = CGRectMake(80*3, ScreenHeight-65, 80, 65);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- actions
- (void)loginBtnPressed{
    RbtWebManager *loginWebManager = [[RbtWebManager alloc] init];
    loginWebManager.name = @"loginWebManager";
    loginWebManager.delegate = self;
    if (self.textF_Username.text == Nil|[self.textF_Username.text length] == 0) {
        [RbtCommonTool showInfoAlert:@"用户名不能为空"];
    }
    else if (self.textF_Password.text == Nil|[self.textF_Password.text length] == 0){
        [RbtCommonTool showInfoAlert:@"密码不能为空"];
    }
    else{
            if (self.isAutoLogin) {
                NSArray *array = [[NSArray alloc] initWithObjects:[NSNumber numberWithBool:self.isAutoLogin],self.textF_Username.text,self.textF_Password.text,nil];
                [RbtCommonTool setLogin:array];
            }
            [self.hud1 show:YES];
            [loginWebManager loginName:self.textF_Username.text passWord:self.textF_Password.text];
    }
}

- (void)getPasswordBtnPressed{
    [self.hud1 show:YES];
    NSString *user = self.textF_Username.text;
    RbtWebManager *webManager =  [[RbtWebManager alloc] init];
    webManager.name =@"getpassowrd";
    webManager.delegate =self;
    [webManager getpassowrd:user];
}

- (void)btn_gedigongchengPressed{
    [self.hud1 show:YES];
    RbtWebManager *geDiGongCengWebManager = [RbtWebManager getRbtManager:YES];
    geDiGongCengWebManager.name =@"geDiGongCengWebManager";
    geDiGongCengWebManager.delegate = self;
    [geDiGongCengWebManager getpublicprojectWithUser:@"" andH:@"1"];
}

- (void)btn_tianqiyubaoPressed{
    RbtTianQiYuBaoViewController *tqybVc = [[RbtTianQiYuBaoViewController alloc] init];
    tqybVc.isShouYe = YES;
    [self.navigationController pushViewController:tqybVc animated:YES];
}

- (void)btn_xitonggonggaoPressed{
    [self.hud1 show:YES];
    RbtWebManager *webManager = [[RbtWebManager alloc] init];
    webManager.name = @"xtggweb";
    webManager.delegate = self;
    [webManager getannouncement:@""];
}

- (void)btn_lixianyanshiPressed{
    RbtWebManager *webManager = [RbtWebManager getRbtManager:NO];
    webManager.name = @"getLiXianProject";
    webManager.delegate = self;
    [webManager getLiXianProject];
    
}

- (void)btn_ServerUrlPressed{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改服务器URL地址" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.delegate = self;
    alert.alertViewStyle  = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alert textFieldAtIndex:0];
    //textField.keyboardType = UIKeyboardTypeNumberPad;
    NSArray *arr = [RbtCommonTool getServerSetting];
    textField.text = [NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
    [alert show];
}

- (void)swithValueChanged:(DCRoundSwitch *)sender{
    if (sender.isOn) {
        self.isAutoLogin = YES;
    }
    else{
        self.isAutoLogin = NO;
        NSArray *arr = [[NSArray alloc] init];
        [RbtCommonTool setLogin:arr];
    }
}

#pragma mark- textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 //速度0.7秒
                     animations:^{//修改rView坐标
                         self.view.frame = CGRectMake(0, -150, ScreenWidth, ScreenHeight);
                     }
                     completion:^(BOOL finished){
                     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.2 //速度0.7秒
                     animations:^{//修改rView坐标
                             self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
                     }
                     completion:^(BOOL finished){
                     }];

    return YES;
}

- (void)backgroundTap {
    [self.textF_Username resignFirstResponder];
    [self.textF_Password resignFirstResponder];
    [UIView animateWithDuration:0.2 //速度0.7秒
                     animations:^{//修改rView坐标
                         self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
                     }
                     completion:^(BOOL finished){
                     }];
}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"loginWebManager"]) {
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
            
            [RbtUserModel sharedInstance].userName = self.textF_Username.text;
            [RbtUserModel sharedInstance].ut = [responseDic objectForKey:@"ut"];
            [RbtUserModel sharedInstance].lt = [responseDic objectForKey:@"lt"];
            NSArray *arr_kongzhi =[responseDic objectForKey:@"rt"];
            for (NSDictionary *dic_kongzi in arr_kongzhi) {
                if ([[dic_kongzi objectForKey:@"m"] isEqualToString:@"运行原理"]) {
                    [RbtUserModel sharedInstance].yxyl = [dic_kongzi objectForKey:@"r"];
                }
                else if ([[dic_kongzi objectForKey:@"m"] isEqualToString:@"节能视图"]) {
                    [RbtUserModel sharedInstance].jnst = [dic_kongzi objectForKey:@"r"];
                }
                else if ([[dic_kongzi objectForKey:@"m"] isEqualToString:@"历史数据"]) {
                    [RbtUserModel sharedInstance].lssj = [dic_kongzi objectForKey:@"r"];
                }
                else if ([[dic_kongzi objectForKey:@"m"] isEqualToString:@"实时数据"]) {
                    [RbtUserModel sharedInstance].sssj = [dic_kongzi objectForKey:@"r"];
                }
                else if ([[dic_kongzi objectForKey:@"m"] isEqualToString:@"GIS定位"]) {
                    [RbtUserModel sharedInstance].gisdw = [dic_kongzi objectForKey:@"r"];
                }
                else if ([[dic_kongzi objectForKey:@"m"] isEqualToString:@"问题反馈"]) {
                    [RbtUserModel sharedInstance].wtfk = [dic_kongzi objectForKey:@"r"];
                }
            }
            
            [RbtCommonTool setJinRuMode:WoDeGongCheng];
            
            RbtLoginWaitViewController *loginWaitVc = [[RbtLoginWaitViewController alloc] init];
            [self.navigationController pushViewController:loginWaitVc animated:YES];
        }
        else{
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if ([webService.name isEqualToString:@"geDiGongCengWebManager"])
    {
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
             RbtGeDiGongChengViewController *gdgcVc = [[RbtGeDiGongChengViewController alloc] init];
            [RbtCommonModel sharedInstance].arr_publicProject = [[NSMutableArray alloc] init];
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
                   oneProject.latitude = [onePro objectForKey:@"w"];
                    oneProject.longitude = [onePro objectForKey:@"j"];
                    
                    if ([(NSString *)[onePro objectForKey:@"pb"] isEqualToString:@"1"]) {
                        gdgcVc.gonggProjectPid = oneProject.projectid;
                        [[RbtCommonModel sharedInstance].arr_publicProject insertObject:oneProject atIndex:0];
                    }
                    else{
                         [[RbtCommonModel sharedInstance].arr_publicProject addObject:oneProject];
                    }
                }
            }
            [RbtCommonTool setJinRuMode:GongGGC];
            
            //公共工程设置用户空，和权限
            [RbtUserModel sharedInstance].userName = @"";
            [RbtUserModel sharedInstance].yxyl = @"r";
            [RbtUserModel sharedInstance].jnst = @"r";
            [RbtUserModel sharedInstance].lssj = @"r";
            [RbtUserModel sharedInstance].sssj = @"r";
            [RbtUserModel sharedInstance].gisdw = @"r";
            [RbtUserModel sharedInstance].wtfk = @"r";
            
           
            [self.navigationController pushViewController:gdgcVc animated:YES];
        }
    }
    else if([webService.name isEqualToString:@"getLiXianProject"]){
        [RbtCommonTool setJinRuMode:LiXianGongCheng];
        NSArray *arr = [responseDic objectForKey:@"arr"];
        [RbtCommonModel sharedInstance].arr_liXianProject = [arr mutableCopy];
        RbtGeDiGongChengViewController *gdgcVc = [[RbtGeDiGongChengViewController alloc] init];
        [self.navigationController pushViewController:gdgcVc animated:YES];
        
        //离线设置用户空，和权限
        [RbtUserModel sharedInstance].userName = @"";
        [RbtUserModel sharedInstance].yxyl = @"r";
        [RbtUserModel sharedInstance].jnst = @"r";
        [RbtUserModel sharedInstance].lssj = @"r";
        [RbtUserModel sharedInstance].sssj = @"r";
        [RbtUserModel sharedInstance].gisdw = @"r";
        [RbtUserModel sharedInstance].wtfk = @"r";
    }
    else if([webService.name isEqualToString:@"getpassowrd"]){
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
            [RbtCommonTool showInfoAlert:@"请求密码成功，请注意查收短信"];
        }
        else if ([[responseDic objectForKey:@"rc"] isEqualToString:@"0"]){
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
    else if([webService.name isEqualToString:@"xtggweb"]){
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
            RbtXiTongGongGaoViewController *vc = [[RbtXiTongGongGaoViewController alloc] init];
            vc.htmlString = [responseDic objectForKey:@"rt"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([[responseDic objectForKey:@"rc"] isEqualToString:@"0"]){
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
        }
    }
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
