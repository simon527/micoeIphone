//
//  RbtBaseViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-14.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"

@interface RbtBaseViewController ()

@end

@implementation RbtBaseViewController

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
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"backbar"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0, 0, 24, 44);
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = backBar;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    self.hud1 = [[MBProgressHUD alloc] initWithView:self.view];
//    self.hud1.delegate = self;
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.hud1 = [[MBProgressHUD alloc] initWithWindow:window];
    self.hud1.delegate =self;
    [window addSubview:self.hud1];
	// Do any additional setup after loading the view.
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic{
        [self.hud1 hide:YES];
}

- (void)webServicefailed:(RbtWebManager *) webService{
    [self.hud1 hide:YES];
}

#pragma mark- InterfaceOrientations

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIViewController*)viewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
