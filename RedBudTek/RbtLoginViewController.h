//
//  RbtLoginViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-6.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"

@interface RbtLoginViewController : RbtBaseViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong,nonatomic)UITextField *textF_Username;
@property (strong,nonatomic)UITextField *textF_Password;

@property (strong,nonatomic)UIControl *scrollView;
@property (assign,nonatomic)BOOL isAutoLogin;
@property(retain,nonatomic)NSString *intString;
@property (copy,nonatomic) NSString *jsonString;

@end
