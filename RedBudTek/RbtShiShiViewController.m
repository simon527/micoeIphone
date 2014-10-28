//
//  RbtShiShiViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//hello 黄川

#import "RbtShiShiViewController.h"
#import "RbtDataOfResponse.h"

@interface RbtShiShiViewController ()
{
    UIPageControl *pageControl;
}

@end

@implementation RbtShiShiViewController

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
	// Do any additional setup after loading the view.
    
    self.title = @"实时数据";
    
    NSDictionary *dic = [RbtDataOfResponse sharedInstance].yuanlituDic;
    
    W_SArray = [[NSMutableArray alloc] init];
    
    T_JArray = [[NSMutableArray alloc] init];
    
    T_SArray = [[NSMutableArray alloc] init];
    
    T_UArray = [[NSMutableArray alloc] init];
    
    T_AArray = [[NSMutableArray alloc] init];
    
    T_GArray = [[NSMutableArray alloc] init];
    
    E_EArray = [[NSMutableArray alloc] init];
    
    P_PArray = [[NSMutableArray alloc] init];
    
    EH_EHArray = [[NSMutableArray alloc] init];
    
    DDF_EArray = [[NSMutableArray alloc] init];
    
    T_HArray = [[NSMutableArray alloc] init];
    
    yltName = [dic objectForKey:@"t"];
    
    dataDic = [dic objectForKey:@"d"];
    
    imageX = 4;
    
    imageY = 5;
    
    gap1 = 3;
    gap2 = 5;
    
    imageWidth = 309/2;
    
    if (IS_IPHONE_5) {
        imageHeight = 291/2;
    }
    else
    {
        imageHeight = 291/2 - (568-480)/3;
    }
    
//    suofangbi = (291/2 - (568-480)/3)/(291/2);
//    suofangbi = (float)(1 - 176/873);
    
    int dataCount = 0;

    
    for(NSDictionary *tempDic in dataDic)
    {
        NSString *shebeiName = [tempDic objectForKey:@"n"];
        NSRange range = [shebeiName rangeOfString:@"_"];
        
        NSLog(@"-range-%@--", NSStringFromRange(range));
        
        if (range.location != NSNotFound) {
            
            NSArray *nameArray = [shebeiName componentsSeparatedByString:@"_"];
            NSString *danweiType = [nameArray objectAtIndex:0];
            NSString *shebeiType = [nameArray objectAtIndex:1];
            if ([danweiType hasPrefix:@"W"] && [shebeiType isEqualToString:@"S"]) {
                [W_SArray addObject:tempDic];
                dataCount++;
            }
            if ([danweiType hasPrefix:@"T"] && [shebeiType isEqualToString:@"J"]) {
                [T_JArray addObject:tempDic];
                dataCount++;
            }
            if ([danweiType hasPrefix:@"T"] && [shebeiType isEqualToString:@"S"]) {
                [T_SArray addObject:tempDic];
                dataCount++;
            }
            if ([danweiType hasPrefix:@"T"] && [shebeiType isEqualToString:@"U"]) {
                [T_UArray addObject:tempDic];
                dataCount++;
            }
            if ([danweiType hasPrefix:@"T"] && [shebeiType isEqualToString:@"A"]) {
                [T_AArray addObject:tempDic];
                dataCount++;
            }
            if ([danweiType hasPrefix:@"T"] && [shebeiType isEqualToString:@"G"]) {
                [T_GArray addObject:tempDic];
                dataCount++;
            }
            if ([danweiType hasPrefix:@"E"] && [shebeiType isEqualToString:@"E"]) {
                [E_EArray addObject:tempDic];
                dataCount++;
            }
            if ([danweiType hasPrefix:@"P"] && [shebeiType isEqualToString:@"P"]) {
                [P_PArray addObject:tempDic];
                dataCount++;
            }
            
            if ([danweiType hasPrefix:@"EH"] && [shebeiType isEqualToString:@"EH"]) {
                [EH_EHArray addObject:tempDic];
                dataCount++;
            }
            if ([danweiType hasPrefix:@"DDF"] && [shebeiType isEqualToString:@"F"]) {
                [DDF_EArray addObject:tempDic];
                dataCount++;
            }
            if ([danweiType hasPrefix:@"T"] && [shebeiType isEqualToString:@"H"]) {
                [T_HArray addObject:tempDic];
                dataCount++;
            }
        }
    }
    int screenCount = dataCount/6?(dataCount/6+1):(dataCount%6 == 0);
    float scHeight;
    if (IS_IPHONE_5) {
        scHeight = 455;
    }
    else
    {
        scHeight = 455-(568-480);
    }
    sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, scHeight)];
    
    [sc setContentSize:CGSizeMake(320*screenCount, scHeight)];
    
    sc.delegate = self;
    
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    
//    sc.alwaysBounceVertical = NO;
    
    sc.pagingEnabled = YES;
    
    [self.view addSubview:sc];
    
    [self arrangeImageByArray:W_SArray withtag:1];
    [self arrangeImageByArray:T_JArray withtag:2];
    [self arrangeImageByArray:T_SArray withtag:3];
    [self arrangeImageByArray:T_UArray withtag:4];
    [self arrangeImageByArray:T_AArray withtag:5];
    [self arrangeImageByArray:T_GArray withtag:6];
    [self arrangeImageByArray:E_EArray withtag:7];
    [self arrangeImageByArray:P_PArray withtag:8];
    [self arrangeImageByArray:EH_EHArray withtag:9];
    [self arrangeImageByArray:DDF_EArray withtag:10 ];
    [self arrangeImageByArray:T_HArray withtag:11];
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(ScreenWidth/2-50, ScreenHeight-80, 100, 30);//指定位置大小
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.numberOfPages = screenCount;//指定页面个数
    pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    //    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];

}

-(void)arrangeImageByArray:(NSMutableArray *)array withtag:(NSInteger)imageTag
{

    NSString *tubiaoImageName;
    
    NSString *titleName;
    
    switch (imageTag) {
        case 1:
            tubiaoImageName = @"W_S";
            titleName = @"水箱";
            break;
            
        case 2:
            tubiaoImageName = @"T_J";
            titleName = @"集热器";
            break;
            
        case 3:
            tubiaoImageName = @"T_S";
            titleName = @"水箱";
            break;
            
        case 4:
            tubiaoImageName = @"T_U";
            titleName = @"用水管道";
            break;
            
        case 5:
            tubiaoImageName = @"T_A";
            titleName = @"上水管道";
            break;
            
        case 6:
            tubiaoImageName = @"T_G";
            titleName = @"水箱间管道";
            break;
            
        case 7:
            tubiaoImageName = @"E_E";
            titleName = @"电磁阀";
            break;
            
        case 8:
            tubiaoImageName = @"P_P";
            titleName = @"循环泵";
            break;
            
        case 9:
            tubiaoImageName = @"EH_EH";
            titleName = @"电加热";
            break;
            
        case 10:
            tubiaoImageName = @"DDF_E";
            titleName = @"电动阀";
            break;
            
        case 11:
            tubiaoImageName = @"T_H";
            titleName = @"室内盘管";
            break;
            
        default:
            break;
    }
    
    if (array.count) {
        for (NSDictionary *dic in array) {
            NSString *shebei = [dic objectForKey:@"n"];
            
            NSArray *nameArray = [shebei componentsSeparatedByString:@"_"];
            
            NSString *shebeiName = [nameArray objectAtIndex:0];
            
            NSString *lastStr;
            NSString *danwei;
            if ([shebeiName hasPrefix:@"W"]) {
                lastStr = @"水位";
                danwei = @"%";
            }
            else if([shebeiName hasPrefix:@"T"])
            {
                lastStr = @"温度";
                danwei = @"℃";
            }
            else
            {
                lastStr = @"开关";
                danwei = @"";
            }
            
            UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageHeight)];
            int image_houzhui = imageIndex%12;
            [bgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"shishiBG%d", image_houzhui]]];
            UIImageView *tubiaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tubiaoImageName]];
            [tubiaoImageView setCenter:bgImageView.center];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            UILabel *dataLabel = [[UILabel alloc] init];
            
            float labelHeight;
            float kSize;
            if (IS_IPHONE_5) {
                labelHeight = 32;
                kSize = 20;
            }
            else
            {
                labelHeight = 26;
                kSize = 15;
            }
            
            [titleLabel setSize:CGSizeMake(imageWidth, labelHeight)];
            CGPoint tempCenter;
            tempCenter.x = bgImageView.center.x;
            tempCenter.y = bgImageView.center.y - imageHeight/2 + labelHeight/2;
            titleLabel.center = tempCenter;
            titleLabel.text = [NSString stringWithFormat:@"%@%@%@", titleName, shebeiName, lastStr];
            [titleLabel setTextAlignment:NSTextAlignmentCenter];
//            [titleLabel setFont:[UIFont fontWithName:kFontName size:kSize]];
            [titleLabel setTextColor:[UIColor whiteColor]];
            
            [dataLabel setSize:CGSizeMake(imageWidth, labelHeight)];
            CGPoint tempCenter1;
            tempCenter1.x = bgImageView.center.x;
            tempCenter1.y = bgImageView.center.y + imageHeight/2 - labelHeight/2 - 5;
            dataLabel.center = tempCenter1;
            NSString *v = [dic objectForKey:@"v"];
            NSString *zhuangtai;
            
            if ([lastStr isEqualToString:@"开关"]) {
                zhuangtai = [v intValue]?@"开":@"关";
            }
            else
            {
                zhuangtai = v;
            }
            dataLabel.text = [NSString stringWithFormat:@"%@ %@", zhuangtai, danwei];
            [dataLabel setTextAlignment:NSTextAlignmentCenter];
            //            [titleLabel setFont:[UIFont fontWithName:kFontName size:kSize]];
            [dataLabel setTextColor:[UIColor whiteColor]];

            [sc addSubview:bgImageView];
            [sc addSubview:tubiaoImageView];
            [sc addSubview:titleLabel];
            [sc addSubview:dataLabel];
            imageIndex++;
            imageX += imageWidth + gap1;
            int j = imageIndex/6;
            if ((imageIndex%2 == 0) && (imageIndex%6 != 0) ) {
                imageX = 4 + 320*j;
                imageY += imageHeight + gap2;
            }
            else if (imageIndex%6 == 0) {
                imageY = gap2;
                imageX = 4 + 320*j;
            }
        }
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = sc.contentOffset.x / 320;//通过滚动的偏移量来判断目前页面所对应的小白点
    pageControl.currentPage = page;//pagecontroll响应值的变化
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
