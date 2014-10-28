//
//  RbtYLT905-H.m
//  RedBudTek
//
//  Created by Simon on 13-12-3.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtYLT905-H.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
#import "RbtDataOfResponse.h"

@implementation RbtYLT905_H

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView *backGroungView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
        [backGroungView setImage:[UIImage imageNamed:@"905-HBG"]];
        [self addSubview:backGroungView];
        
        imageView_P5b = [[UIImageView alloc] initWithFrame:CGRectMake(133, 23, 27, 27)];
//        [imageView_P5b setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
//        [imageView_P5b setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P5b_P"]]]];
        [self addSubview:imageView_P5b];
        
        imageView_P5 = [[UIImageView alloc] initWithFrame:CGRectMake(133, 55, 27, 27)];
//        [imageView_P5 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P5_P"]]]];
        [self addSubview:imageView_P5];
        
        imageView_linyuqi = [[UIImageView alloc] initWithFrame:CGRectMake(273, 24, 57, 57)];
        [imageView_linyuqi setImage:[UIImage imageNamed:@"linyuqi"]];
        [self addSubview:imageView_linyuqi];
        
        imageView_yalichuanganqi = [[UIImageView alloc] initWithFrame:CGRectMake(346, 45, 15, 15)];
        [imageView_yalichuanganqi setImage:[UIImage imageNamed:@"chuanganqi_on"]];
        [self addSubview:imageView_yalichuanganqi];
        
        imageView_yaliguan = [[UIImageView alloc] initWithFrame:CGRectMake(364, 45, 15, 15)];
        [imageView_yaliguan setImage:[UIImage imageNamed:@"yaliguan"]];
        [self addSubview:imageView_yaliguan];
        
        imageView_danxiangfa = [[UIImageView alloc] initWithFrame:CGRectMake(383, 39, 27, 27)];
        [imageView_danxiangfa setImage:[UIImage imageNamed:@"danxiangfa_on"]];
        [self addSubview:imageView_danxiangfa];
        
        imageView_T1 = [[UIImageView alloc] initWithFrame:CGRectMake(181, 74, 27, 27)];
        [imageView_T1 setImage:[UIImage imageNamed:@"paiqifa_on"]];
        [self addSubview:imageView_T1];
        
        imageView_T5 = [[UIImageView alloc] initWithFrame:CGRectMake(247, 67, 27, 27)];
        [imageView_T5 setImage:[UIImage imageNamed:@"paiqifa_on"]];
        [self addSubview:imageView_T5];
        
        imageView_E3 = [[UIImageView alloc] initWithFrame:CGRectMake(247, 96, 27, 27)];
//        [imageView_E3 setImage:[UIImage imageNamed:@"diancifa_on"]];
        [self addSubview:imageView_E3];
        
        imageView_P2 = [[UIImageView alloc] initWithFrame:CGRectMake(389, 75, 27, 27)];
//        [imageView_P2 setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
        [self addSubview:imageView_P2];
        
        imageView_P2b = [[UIImageView alloc] initWithFrame:CGRectMake(420, 75, 27, 27)];
//        [imageView_P2b setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
        [self addSubview:imageView_P2b];
        
        imageView_jireqi = [[UIImageView alloc] initWithFrame:CGRectMake(54, 104, 57, 57)];
        [imageView_jireqi setImage:[UIImage imageNamed:@"jireqi"]];
        [self addSubview:imageView_jireqi];
        
        imageView_dianguolu = [[UIImageView alloc] initWithFrame:CGRectMake(144, 98, 27, 27)];
//        [imageView_dianguolu setImage:[UIImage imageNamed:@"dianguolu"]];
        [self addSubview:imageView_dianguolu];
        
        imageView_T2 = [[UIImageView alloc] initWithFrame:CGRectMake(181, 118, 80, 80)];
        [imageView_T2 setImage:[UIImage imageNamed:@"shuixiang1"]];
        [self addSubview:imageView_T2];
        
        imageView_P3 = [[UIImageView alloc] initWithFrame:CGRectMake(311, 110, 27, 27)];
//        [imageView_P3 setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
        [self addSubview:imageView_P3];
        
        imageView_P3b = [[UIImageView alloc] initWithFrame:CGRectMake(311, 178, 27, 27)];
//        [imageView_P3b setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
        [self addSubview:imageView_P3b];
        
        imageView_T4 = [[UIImageView alloc] initWithFrame:CGRectMake(379, 118, 80, 80)];
        [imageView_T4 setImage:[UIImage imageNamed:@"shuixiang2"]];
        [self addSubview:imageView_T4];
        
        imageView_paikongshuixiang = [[UIImageView alloc] initWithFrame:CGRectMake(13, 170, 57, 57)];
        [imageView_paikongshuixiang setImage:[UIImage imageNamed:@"paikongshuixiang"]];
        [self addSubview:imageView_paikongshuixiang];
        
        imageView_P4 = [[UIImageView alloc] initWithFrame:CGRectMake(105, 176, 27, 27)];
//        [imageView_P4 setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
        [self addSubview:imageView_P4];
        
        imageView_P4b = [[UIImageView alloc] initWithFrame:CGRectMake(136, 176, 27, 27)];
//        [imageView_P4b setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
        [self addSubview:imageView_P4b];
        
        imageView_P1 = [[UIImageView alloc] initWithFrame:CGRectMake(193, 210, 27, 27)];
//        [imageView_P1 setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
        [self addSubview:imageView_P1];
        
        imageView_P1b = [[UIImageView alloc] initWithFrame:CGRectMake(224, 210, 27, 27)];
//        [imageView_P1b setImage:[UIImage imageNamed:@"xunhuanbeng_on"]];
        [self addSubview:imageView_P1b];
        
        imageView_E2 = [[UIImageView alloc] initWithFrame:CGRectMake(405, 218, 27, 27)];
        [imageView_E2 setImage:[UIImage imageNamed:@"diancifa_on"]];
        [self addSubview:imageView_E2];
        
        imageView_E5 = [[UIImageView alloc] initWithFrame:CGRectMake(146, 266, 27, 27)];
//        [imageView_E5 setImage:[UIImage imageNamed:@"diancifa_on"]];
        [self addSubview:imageView_E5];
        
        imageView_E4 = [[UIImageView alloc] initWithFrame:CGRectMake(247, 273, 27, 27)];
//        [imageView_E4 setImage:[UIImage imageNamed:@"diancifa_on"]];
        [self addSubview:imageView_E4];
        
        imageView_E1 = [[UIImageView alloc] initWithFrame:CGRectMake(321, 253, 27, 27)];
//        [imageView_E1 setImage:[UIImage imageNamed:@"diancifa_on"]];
        [self addSubview:imageView_E1];
        
        imageView_EH2 = [[UIImageView alloc] initWithFrame:CGRectMake(428, 253, 27, 27)];
//        [imageView_EH2 setImage:[UIImage imageNamed:@"EH2_on"]];
        [self addSubview:imageView_EH2];
        
        W1_SLabelView = [[UIView alloc] initWithFrame:imageView_T2.frame];
        [W1_SLabelView setBackgroundColor:[UIColor whiteColor]];
        W1_Slabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 16, 28, 20)];
        W1_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_W1_S];
        [W1_Slabel setFont:[UIFont fontWithName:kFontName size:24]];
        [W1_Slabel setTextAlignment:NSTextAlignmentCenter];
        [W1_SLabelView addSubview:W1_Slabel];
        UILabel *danwei1 = [[UILabel alloc] initWithFrame:CGRectMake(54.4, 24, 24, 12)];
        danwei1.text = @"%";
        [danwei1 setFont:[UIFont fontWithName:kFontName size:10]];
        [W1_SLabelView addSubview:danwei1];
        
        T1_Slabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 44, 28, 20)];
        T1_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_T1_S];
        [T1_Slabel setFont:[UIFont fontWithName:kFontName size:24]];
        [T1_Slabel setTextAlignment:NSTextAlignmentCenter];
        [W1_SLabelView addSubview:T1_Slabel];
        UILabel *danwei2 = [[UILabel alloc] initWithFrame:CGRectMake(54.4, 52, 24, 12)];
        danwei2.text = @"℃";
        [danwei2 setFont:[UIFont fontWithName:kFontName size:10]];
        [W1_SLabelView addSubview:danwei2];
        W1_SLabelView.backgroundColor = [UIColor clearColor];
        [self insertSubview:W1_SLabelView belowSubview:imageView_T2];
        
        W2_SLabelView = [[UIView alloc] initWithFrame:imageView_T4.frame];
        [W2_SLabelView setBackgroundColor:[UIColor whiteColor]];
        W2_Slabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 16, 28, 20)];
        W2_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_W2_S];
        [W2_Slabel setFont:[UIFont fontWithName:kFontName size:24]];
        [W2_Slabel setTextAlignment:NSTextAlignmentCenter];
        [W2_SLabelView addSubview:W2_Slabel];
        UILabel *danwei3 = [[UILabel alloc] initWithFrame:CGRectMake(54.4, 24, 24, 12)];
        danwei3.text = @"%";
        [danwei3 setFont:[UIFont fontWithName:kFontName size:10]];
        [W2_SLabelView addSubview:danwei3];
        
        T2_Slabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 44, 28, 20)];
        T2_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_T2_S];
        [T2_Slabel setFont:[UIFont fontWithName:kFontName size:24]];
        [T2_Slabel setTextAlignment:NSTextAlignmentCenter];
        [W2_SLabelView addSubview:T2_Slabel];
        UILabel *danwei4 = [[UILabel alloc] initWithFrame:CGRectMake(54.4, 52, 24, 12)];
        danwei4.text = @"℃";
        [danwei4 setFont:[UIFont fontWithName:kFontName size:10]];
        [W2_SLabelView addSubview:danwei4];
        W2_SLabelView.backgroundColor = [UIColor clearColor];
        [self insertSubview:W2_SLabelView belowSubview:imageView_T4];
        
        W_S1View = [[MDRadialProgressView alloc] init];
        [W_S1View setSize:CGSizeMake(90, 90)];
        W_S1View.center = imageView_T2.center;
        W_S1View.progressTotal = 100;
        W_S1View.progressCounter = [[RbtDataOfResponse sharedInstance].num_W1_S intValue];
        W_S1View.theme.completedColor = [UIColor colorWithRed:77/255.0 green:190/255.0 blue:183/255.0 alpha:1];
        W_S1View.theme.incompletedColor = [UIColor colorWithRed:200/255.0 green:235/255.0 blue:233/255.0 alpha:1];
        W_S1View.theme.sliceDividerHidden = YES;
        W_S1View.label.hidden = YES;
        UITapGestureRecognizer *tapInW_S1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInW_S1)];
        [W_S1View addGestureRecognizer:tapInW_S1];
        
        [self addSubview:W_S1View];
        
        W_S2View = [[MDRadialProgressView alloc] init];
        [W_S2View setSize:CGSizeMake(90, 90)];
        W_S2View.center = imageView_T4.center;
        W_S2View.progressTotal = 100;
        W_S2View.progressCounter = [[RbtDataOfResponse sharedInstance].num_W2_S intValue];
        //        W_S2View.theme.completedColor = [UIColor redColor];
        //        W_S2View.theme.incompletedColor = [UIColor grayColor];
        W_S2View.theme.completedColor = [UIColor colorWithRed:77/255.0 green:190/255.0 blue:183/255.0 alpha:1];
        W_S2View.theme.incompletedColor = [UIColor colorWithRed:200/255.0 green:235/255.0 blue:233/255.0 alpha:1];
        W_S2View.theme.sliceDividerHidden = YES;
        W_S2View.label.hidden = YES;
        UITapGestureRecognizer *tapInW_S2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInW_S2)];
        [W_S2View addGestureRecognizer:tapInW_S2];
        
        [self addSubview:W_S2View];
        
        [self setStatus];
    }
    return self;
}

-(void)tapInW_S1
{
    imageView_T2.hidden = !imageView_T2.hidden;
}

-(void)tapInW_S2
{
    imageView_T4.hidden = !imageView_T4.hidden;
}

-(void)setStatus
{
    [imageView_P5b setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P5b_P"]]]];
    [imageView_P5 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P5_P"]]]];
    [imageView_P4b setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P4b_P"]]]];
    [imageView_P4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P4_P"]]]];
    
    [imageView_P3b setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P3b_P"]]]];
    [imageView_P3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P3_P"]]]];
    [imageView_P2b setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P2b_P"]]]];
    [imageView_P2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P2_P"]]]];
    [imageView_P1b setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P1b_P"]]]];
    [imageView_P1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"xunhuanbeng_%@", [self statusBysName:@"P1_P"]]]];
    
    [imageView_E1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diancifa_%@", [self statusBysName:@"E1_E"]]]];
    [imageView_E2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diancifa_%@", [self statusBysName:@"E2_E"]]]];
    [imageView_E3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diancifa_%@", [self statusBysName:@"E3_E"]]]];
    [imageView_E4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diancifa_%@", [self statusBysName:@"E4_E"]]]];
    [imageView_E5 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"diancifa_%@", [self statusBysName:@"E5_E"]]]];
    
    [imageView_dianguolu setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH1_EH"]]]];
    [imageView_EH2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"EH2_%@", [self statusBysName:@"EH2_EH"]]]];
    
    W1_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_W1_S];
    T1_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_T1_S];
    W2_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_W2_S];
    T2_Slabel.text = [NSString stringWithFormat:@"%@", [RbtDataOfResponse sharedInstance].num_T2_S];
    W_S1View.progressCounter = [[RbtDataOfResponse sharedInstance].num_W1_S intValue];
    W_S2View.progressCounter = [[RbtDataOfResponse sharedInstance].num_W2_S intValue];
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
