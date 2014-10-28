//
//  RbtXiuGaiMiMaViewController.h
//  RedBudTek
//
//  Created by Simon on 13-11-18.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RbtBaseViewController.h"
#import "RbtTabViewController.h"

@interface RbtXiuGaiMiMaViewController : RbtTabViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *originalPW;

@property (strong, nonatomic) IBOutlet UITextField *lastPW;

@property (strong, nonatomic) IBOutlet UITextField *confirmPW;

@property (strong, nonatomic) IBOutlet UIButton *confirmButton;

@property (strong, nonatomic) IBOutlet UIButton *cancleButton;


@end
