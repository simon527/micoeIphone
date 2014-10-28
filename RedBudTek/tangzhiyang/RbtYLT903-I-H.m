//
//  RbtYLT903-I-H.m
//  RedBudTek
//
//  Created by Simon on 13-12-3.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtYLT903-I-H.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
#import "RbtDataOfResponse.h"

@implementation RbtYLT903_I_H

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView *backGroungView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
        [backGroungView setImage:[UIImage imageNamed:@"903-I-HBG"]];
        [self addSubview:backGroungView];
        
        imageView_P2 = [[UIImageView alloc] initWithFrame:CGRectMake(348, 42, 27, 27)];
        [imageView_P2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P2_P"]]]];
        [self addSubview:imageView_P2];
        
        imageView_EH4 = [[UIImageView alloc] initWithFrame:CGRectMake(72, 83, 27, 27)];
        [imageView_EH4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH4_EH"]]]];
        [self addSubview:imageView_EH4];
        
        imageView_paiqifa = [[UIImageView alloc] initWithFrame:CGRectMake(195, 61, 27, 27)];
        [imageView_paiqifa setImage:[UIImage imageNamed:@"paiqifa_on"]];
        [self addSubview:imageView_paiqifa];
        
        imageView_EH3 = [[UIImageView alloc] initWithFrame:CGRectMake(72, 146, 27, 27)];
        [imageView_EH3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH3_EH"]]]];
        [self addSubview:imageView_EH3];
        
        imageView_T3 = [[UIImageView alloc] initWithFrame:CGRectMake(137, 131, 57, 57)];
        [imageView_T3 setImage:[UIImage imageNamed:@"jireqi"]];
        [self addSubview:imageView_T3];
        
        imageView_T2 = [[UIImageView alloc] initWithFrame:CGRectMake(221, 110, 100, 100)];
        [imageView_T2 setImage:[UIImage imageNamed:@"shuixiang1"]];
        [self addSubview:imageView_T2];
        
        imageView_T5 = [[UIImageView alloc] initWithFrame:CGRectMake(403, 131, 57, 57)];
        [imageView_T5 setImage:[UIImage imageNamed:@"linyuqi"]];
        [self addSubview:imageView_T5];
        
        imageView_E1 = [[UIImageView alloc] initWithFrame:CGRectMake(72, 210, 27, 27)];
        [imageView_E1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diancifa_%@", [self statusBysName:@"E1_E"]]]];
        [self addSubview:imageView_E1];
        
        imageView_X = [[UIImageView alloc] initWithFrame:CGRectMake(245, 223, 27, 27)];
        [imageView_X setImage:[UIImage imageNamed:@"EH2_on"]];
        [self addSubview:imageView_X];
        
        imageView_zengyabeng = [[UIImageView alloc] initWithFrame:CGRectMake(418, 213, 27, 27)];
        [imageView_zengyabeng setImage:[UIImage imageNamed:@"zengyabeng_on"]];
        [self addSubview:imageView_zengyabeng];
        
        imageView_EH2 = [[UIImageView alloc] initWithFrame:CGRectMake(32, 252, 27, 27)];
        [imageView_EH2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH2_EH"]]]];
        [self addSubview:imageView_EH2];
        
        imageView_E2 = [[UIImageView alloc] initWithFrame:CGRectMake(101, 252, 27, 27)];
        [imageView_E2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diancifa_%@", [self statusBysName:@"E2_E"]]]];
        [self addSubview:imageView_E2];
        
        imageView_T4 = [[UIImageView alloc] initWithFrame:CGRectMake(195, 252, 27, 27)];
        [imageView_T4 setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
        [self addSubview:imageView_T4];
        
        imageView_EH1 = [[UIImageView alloc] initWithFrame:CGRectMake(348, 252, 27, 27)];
        [imageView_EH1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH1_EH"]]]];
        [self addSubview:imageView_EH1];
        
        W_S1View = [[MDRadialProgressView alloc] init];
        [W_S1View setSize:CGSizeMake(115, 115)];
        W_S1View.center = imageView_T2.center;
        W_S1View.progressTotal = 100;
        W_S1View.progressCounter = [[RbtDataOfResponse sharedInstance].num_W1_S intValue];
        W_S1View.theme.completedColor = [UIColor colorWithRed:77/255.0 green:190/255.0 blue:183/255.0 alpha:1];
        W_S1View.theme.incompletedColor = [UIColor colorWithRed:200/255.0 green:235/255.0 blue:233/255.0 alpha:1];
//        W_S1View.theme.completedColor = [UIColor blueColor];
//        W_S1View.theme.incompletedColor = [UIColor greenColor];
        W_S1View.theme.sliceDividerHidden = YES;
        W_S1View.label.hidden = YES;
        UITapGestureRecognizer *tapInW_S1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInW_S1)];
        [W_S1View addGestureRecognizer:tapInW_S1];
        
        W1_SLabelView = [[UIView alloc] initWithFrame:imageView_T2.frame];
        [W1_SLabelView setBackgroundColor:[UIColor clearColor]];
        W1_Slabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 35, 25)];
        W1_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_W1_S];
        [W1_Slabel setFont:[UIFont fontWithName:kFontName size:30]];
        [W1_Slabel setTextAlignment:NSTextAlignmentCenter];
        [W1_SLabelView addSubview:W1_Slabel];
        UILabel *danwei1 = [[UILabel alloc] initWithFrame:CGRectMake(68, 30, 30, 15)];
        danwei1.text = @"%";
        [danwei1 setFont:[UIFont fontWithName:kFontName size:12]];
        [W1_SLabelView addSubview:danwei1];
        
        T1_Slabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 55, 35, 25)];
        T1_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_T1_S];
        [T1_Slabel setFont:[UIFont fontWithName:kFontName size:30]];
        [T1_Slabel setTextAlignment:NSTextAlignmentCenter];
        [W1_SLabelView addSubview:T1_Slabel];
        UILabel *danwei2 = [[UILabel alloc] initWithFrame:CGRectMake(68, 65, 30, 15)];
        danwei2.text = @"℃";
        [danwei2 setFont:[UIFont fontWithName:kFontName size:12]];
        [W1_SLabelView addSubview:danwei2];
        
        //        [self addSubview:W1_SLabelView];
        [self insertSubview:W1_SLabelView belowSubview:imageView_T2];
        
        [self addSubview:W_S1View];

    }
    return self;
}

-(void)tapInW_S1
{
    imageView_T2.hidden = !imageView_T2.hidden;
}

-(void)setStatus
{
    [imageView_P2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P2_P"]]]];
    [imageView_EH4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH4_EH"]]]];
    [imageView_EH3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH3_EH"]]]];
    [imageView_E1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diancifa_%@", [self statusBysName:@"E1_E"]]]];
    [imageView_EH2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH2_EH"]]]];
    [imageView_E2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diancifa_%@", [self statusBysName:@"E2_E"]]]];
    [imageView_EH1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH1_EH"]]]];
    
    
    W_S1View.progressCounter = [[RbtDataOfResponse sharedInstance].num_W1_S intValue];
    W1_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_W1_S];
    T1_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_T1_S];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
