//
//  RbtCustomTabbarController.m
//  RedBudTek
//
//  Created by Simon on 13-11-18.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtCustomTabbarController.h"

@interface RbtCustomTabbarController ()

@end

@implementation RbtCustomTabbarController

@synthesize controllersArray, imagesArray, tabBarButtonsArray;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        int i = 0;
//        for (UIViewController *controller in controllersArray ) {
//            [controller.view setTag:i];
//            if (i == 0) {
//                [self.view addSubview:controller.view];
//                showViewTag = i;
//            }
//            i++;
//        }
//        
//        int j = 10;
//        int num = [imagesArray count];
//        for (UIImage * tabBarButtonImage in imagesArray) {
//            UIButton *tabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            [tabBarButton setTag:j];
//            [tabBarButton setImage:tabBarButtonImage forState:UIControlStateNormal];
//            
//            [tabBarButton setFrame:CGRectMake(0 + self.view.bounds.size.width/num*(j-10), self.view.bounds.size.height- 48, self.view.bounds.size.width/num, 48)];
//            [tabBarButton addTarget:self action:@selector(tabBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:tabBarButton];
//            j++;
//        }
//        
//        
//        
//    }
//    return self;
//}
//
//-(IBAction)tabBarButtonPressed:(UIButton *)sender
//{
//    for (UIView *tempView in self.view) {
//        if (tempView.tag == showViewTag) {
//            [tempView removeFromSuperview];
//        }
//    }
//    showViewTag = sender.tag;
//    UIViewController *controller = [controllersArray objectAtIndex:showViewTag];
//    UIView *addView = controller.view;
//    [self.view addSubview:addView];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 100, 50)];
    label.text = @"tabbar";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
