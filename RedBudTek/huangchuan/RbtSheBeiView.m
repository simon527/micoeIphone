//
//  RbtSheBeiView.m
//  RedBudTek
//
//  Created by 黄川 on 13-12-10.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtSheBeiView.h"

@implementation RbtSheBeiView{

    UILabel *shebei;
    UILabel *shebeizhong;
    NSString *imageName;
    BOOL isFirst;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.iskzsb = NO;
        isFirst = YES;
        self.imagev_Bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
        self.imagev_sb =  [[UIImageView alloc] init];
        shebei = [[UILabel alloc] initWithFrame:CGRectMake(15, 44, 30, 10)];
        shebei.font = [UIFont fontWithName:kFontName size:9];
        shebei.textAlignment = NSTextAlignmentCenter;
        shebeizhong =[[UILabel alloc] initWithFrame:CGRectMake(0, 55, self.width, 20)];
        shebeizhong.font = [UIFont fontWithName:kFontName size:9];
        shebeizhong.textAlignment = NSTextAlignmentCenter;
        self.swi_sb = [[DCRoundSwitch alloc] initWithFrame:CGRectMake(8, 75, 45, 20)];
        [self.swi_sb addTarget:self action:@selector(switchit) forControlEvents:UIControlEventValueChanged];
        self.swi_sb.onTintColor = [UIColor colorWithRed:71/255.0 green:190/255.0 blue:184/255.0 alpha:1];
        [self addSubview:self.imagev_Bg];
        [self addSubview:self.imagev_sb];
        [self addSubview:shebei];
        [self addSubview:shebeizhong];
        [self addSubview:self.swi_sb];
    }
    return self;
}

- (void)initViews{
    NSArray *arr = [self.name componentsSeparatedByString:@"_"];
    NSString *sbbh = [arr objectAtIndex:0];
    NSString *sblx = [arr objectAtIndex:1];
    shebei.text = sbbh;
    shebeizhong.text = [self getSheBeiZhong:sblx];
    self.imagev_Bg.highlightedImage = [UIImage  imageNamed:@"yckz_sbbgoff"];
    self.imagev_sb.highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"yckz_sb_%@_off",sblx]];
    self.imagev_Bg.image = [UIImage  imageNamed:@"yckz_sbbgon"];
    self.imagev_sb.image = [UIImage imageNamed:[NSString stringWithFormat:@"yckz_sb_%@_on",sblx]];
    NSLog(@"changeon");
    if (self.isOn) {
        [self.swi_sb setOn:YES];
    }
    else{
         isFirst = NO;
    }
    
    [self changeState];
}

- (void)changeState{
    if (self.isOn) {
        self.imagev_Bg.highlighted  = NO;
        self.imagev_sb.highlighted  = NO;
    }
    else{
        self.imagev_Bg.highlighted  = YES;
        self.imagev_sb.highlighted  = YES;
    }
}

- (void)switchit{
    if (isFirst) {
        isFirst = NO;
    }
    else{
        if (!self.iskzsb) {
            if ([RbtCommonTool getJinRuMode] != LiXianGongCheng) {
                [self.delegate sheBeiViewStateChange:self];
            }
        }
        self.iskzsb = NO;
        if (self.isOn) {
            self.isOn = NO;
        }
        else{
            self.isOn = YES;
        }
        [self changeState];
    }
}

- (NSString *)getSheBeiZhong:(NSString *)en{
    NSString *result;
    if ([en isEqualToString:@"J"]) {
        result = @"集热器";
    }
    else if ([en isEqualToString:@"G"]) {
        result = @"水箱间管道";
    }
    else if ([en isEqualToString:@"A"]) {
        result = @"上水管道";
    }
    else if ([en isEqualToString:@"H"]) {
        result = @"室内温度";
    }
    else if ([en isEqualToString:@"U"]) {
        result = @"用水管道";
    }
    else if ([en isEqualToString:@"EH"]) {
        result = @"电加热/电伴热带";
        self.imagev_sb.frame = CGRectMake((58-32)/2, (58-15)/2, 32, 15);
    }
    else if ([en isEqualToString:@"E"]) {
        result = @"电磁阀";
        self.imagev_sb.frame = CGRectMake((58-20)/2, (58-25)/2, 20, 25);
    }
    else if ([en isEqualToString:@"F"]) {
        result = @"电动阀";
        self.imagev_sb.frame = CGRectMake((58-20)/2, (58-25)/2, 20, 25);
    }
    else if ([en isEqualToString:@"P"]) {
        self.imagev_sb.frame = CGRectMake((58-24)/2, (58-28)/2, 24, 28);
        result = @"循环泵";
    }
    return result;
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
