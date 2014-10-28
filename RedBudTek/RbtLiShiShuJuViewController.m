//
//  RbtLiShiShuJuViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtLiShiShuJuViewController.h"
#import "RbtDataOfResponse.h"
#import "FYChartView.h"

@interface RbtLiShiShuJuViewController ()

@end

@implementation RbtLiShiShuJuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{

    if (shebeiArray&&[shebeiArray count]>0) {
        chooseName = [shebeiArray objectAtIndex:1];
    }
    else{
        chooseName =@"T2_S";
    }
    
        chooseTime = @"week";
        timeArray = [[NSMutableArray alloc] init];
        dataArray = [[NSMutableArray alloc] init];
        xxtimeArray = [[NSMutableArray alloc] init];
        values = [[NSMutableArray alloc] init];
        [self postData];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"历史数据";
	// Do any additional setup after loading the view.

     danw =@"℃";
    
//    NSDictionary *dic = [RbtDataOfResponse sharedInstance].lishishujuGongChengLieBiaoDic;
//    NSDictionary *shebeiListDic = [dic objectForKey:@"d"];
//    NSString *yltName = [dic objectForKey:@"t"];

    shebeiArray = [[NSMutableArray alloc] initWithArray:[self sheibeiArrayFromresponse]];;
    shebeiCount = [shebeiArray count];
    
    float gap1 = (640-614)/4;
    
    float gap2 = 10;
    
    float gap3;
    if (IS_IPHONE_5) {
        gap3 = 568-10-296/2 - 49 - 16;
    }
    else
    {
        gap3 = 480-10-296/2 -16;
        [self.customTabbar setHidden:YES];
    }
    
    float tableViewHeight = gap3-gap2-64-86/2;
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(gap1, gap2+64, 614/2, 86/2)];
    [topImageView setImage:[UIImage imageNamed:@"image_top_lssj"]];
    [self.view addSubview:topImageView];
    
    
    UIButton *button_time = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_time setImage:[UIImage imageNamed:@"btn_time"] forState:UIControlStateNormal];
    [button_time addTarget:self action:@selector(timeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button_time setFrame:CGRectMake(22, gap2+75, 26, 26)];
    [self.view addSubview:button_time];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(57, gap2+63, 250, 50)];
    timeLabel.text = @"最近一周";
    [timeLabel setTextColor:[UIColor whiteColor]];
    [timeLabel setTextAlignment:NSTextAlignmentLeft];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [timeLabel setFont:[UIFont fontWithName:kFontName size:20]];
    [self.view addSubview:timeLabel];
    
    lbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lbBtn setFrame:CGRectMake(200, gap2+68, 50, 35)];
//    [lbBtn setBackgroundColor:[UIColor redColor]];
    [lbBtn setTitle:@"列表" forState:UIControlStateNormal];
    [lbBtn addTarget:self action:@selector(lnButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lbBtn];
    
    xxtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [xxtBtn setBackgroundColor:[UIColor blackColor]];
    [xxtBtn setFrame:CGRectMake(254, gap2+68, 60, 35)];
    [xxtBtn setTitle:@"线性图" forState:UIControlStateNormal];
    [xxtBtn addTarget:self action:@selector(xxtButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xxtBtn];
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择时间" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"最近24小时", @"最近一周",  @"最近一个月", nil];
    
    dataTabelView = [[UITableView alloc] initWithFrame:CGRectMake(gap1, gap2+64+topImageView.height, topImageView.width, tableViewHeight)];
    [dataTabelView setSectionIndexColor:[UIColor clearColor]];
    [dataTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [dataTabelView setSeparatorColor:[UIColor clearColor]];
    [dataTabelView setBackgroundView:nil];
    [dataTabelView setShowsVerticalScrollIndicator:NO];
    dataTabelView.delegate = self;
    dataTabelView.dataSource = self;
    
//    dataTabelView.hidden = YES;
    
    [self.view addSubview:dataTabelView];
    
    
    values = dataArray;
    NSLog(@"values = %@", values);
    chartView = [[FYChartView alloc] initWithFrame:dataTabelView.frame];
    chartView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    chartView.rectangleLineColor = [UIColor grayColor];
    chartView.lineColor = [UIColor blueColor];
    chartView.dataSource = self;
    
    chartView.hidden = YES;
    [self.view addSubview:chartView];
    
    UIImageView *imageView_downBG = [[UIImageView alloc] initWithFrame:CGRectMake(gap1, gap3, 614/2, 296/2)];
    [imageView_downBG setImage:[UIImage imageNamed:@"image_down_lssj"]];
    [self.view addSubview:imageView_downBG];
    
    sc = [[UIScrollView alloc] initWithFrame:imageView_downBG.frame];
    scCount = (shebeiCount%3)?(shebeiCount/3+1):(shebeiCount/3);
    sc.contentSize = CGSizeMake(614/2 * scCount, 296/2);
    sc.pagingEnabled = YES;
    sc.delegate = self;
    sc.showsHorizontalScrollIndicator = NO;
    
    float gap4 = (307 - 83*3)/6 + 0.5;
    
    float btnX = gap4;
    float btnY = 20;
    
    float gap6 = (307 - 34*3)/6;
    
    for (int i=0; i < shebeiCount; i++) {
        UIButton *cButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cButton setTag:2000+i];
        [cButton setFrame:CGRectMake(btnX, btnY, 83, 83)];
        UILabel *cLabel = [[UILabel alloc] init];
        [cLabel setSize:CGSizeMake(83, 60)];
        CGPoint center;
        center.x = cButton.center.x;
        center.y = cButton.center.y +83/2 +15;
        cLabel.center = center;
        [cLabel setTextAlignment:NSTextAlignmentCenter];
        [cLabel setFont:[UIFont fontWithName:kFontName size:12]];
        [cLabel setBackgroundColor:[UIColor clearColor]];
        cLabel.lineBreakMode = UILineBreakModeWordWrap;
        cLabel.numberOfLines = 0;
        NSString *tubiaoName;
        NSString *shebeiName = [shebeiArray objectAtIndex:i];
        NSArray *temArray = [shebeiName componentsSeparatedByString:@"_"];
        NSString *sb = [temArray objectAtIndex:0];
        NSString *labelStr;
        if ([shebeiName hasPrefix:@"W"] && [shebeiName hasSuffix:@"S"]) {
            tubiaoName = @"W_S";
            labelStr = [NSString stringWithFormat:@"水箱%@水位", sb];
        }
        if ([shebeiName hasPrefix:@"T"] && [shebeiName hasSuffix:@"S"]) {
            tubiaoName = @"T_S";
            labelStr = [NSString stringWithFormat:@"水箱%@温度", sb];
        }
        if ([shebeiName hasPrefix:@"T"] && [shebeiName hasSuffix:@"A"]) {
            tubiaoName = @"T_A";
            labelStr = [NSString stringWithFormat:@"上水管道%@温度", sb];
        }
        if ([shebeiName hasPrefix:@"T"] && [shebeiName hasSuffix:@"G"]) {
            tubiaoName = @"T_G";
            labelStr = [NSString stringWithFormat:@"水箱间管道%@温度", sb];
        }
        if ([shebeiName hasPrefix:@"T"] && [shebeiName hasSuffix:@"U"]) {
            tubiaoName = @"T_U";
            labelStr = [NSString stringWithFormat:@"用水管道%@温度", sb];
        }
        if ([shebeiName hasPrefix:@"T"] && [shebeiName hasSuffix:@"J"]) {
            tubiaoName = @"T_J";
            labelStr = [NSString stringWithFormat:@"集热器%@温度", sb];
        }
        if ([shebeiName hasPrefix:@"T"] && [shebeiName hasSuffix:@"H"]) {
            tubiaoName = @"T_H";
            labelStr = [NSString stringWithFormat:@"室内温度%@", sb];
        }
        cLabel.text = labelStr;
        [cButton setTag:(800+i)];
        int i_6 = i%6;
        [cButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"colorBg%d", i_6]] forState:UIControlStateNormal];
        [cButton addTarget:self action:@selector(typeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cButton setImage:[UIImage imageNamed:tubiaoName] forState:UIControlStateNormal];
        [sc addSubview:cButton];
        [sc addSubview:cLabel];
        btnX += 2*gap4 + 83;
        UIImageView *shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(gap6+(34 + gap6*2)*i, 296/2-27/2, 68/2, 27/2)];
        shadowImageView.hidden = YES;
        [shadowImageView setTag:(1000+i)];
        [shadowImageView setImage:[UIImage imageNamed:@"shadow"]];
        [sc addSubview:shadowImageView];
    }
    [self.view addSubview:sc];
    
    
    [sc viewWithTag:1001].hidden = NO;
    float gap5 = 10;
    
    float scCountF = (float) scCount;
    float pointX = 160 - (scCountF/2*7/2 + (scCountF-1)/2*gap5);
    
    for (int j = 0; j<scCount; j++) {
        UIImageView *pointImgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(pointX+j*(7/2+gap5), gap3+296/2+8, 7, 7)];
        [pointImgaeView setTag:(900+j)];
        if (j == 0) {
            [pointImgaeView setImage:[UIImage imageNamed:@"point_s"]];
        }
        else
        {
            [pointImgaeView setImage:[UIImage imageNamed:@"point"]];
        }
        [self.view addSubview:pointImgaeView];
    }
    
//    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake((614/2-68/2)/2, 296/2-27/2, 68/2, 27/2)];
//    [shadowImageView setImage:[UIImage imageNamed:@"shadow"]];
//    [sc addSubview:shadowImageView];
    
}
-(NSMutableArray *)sheibeiArrayFromresponse
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSArray *dArray = [[NSArray alloc] init];
    dArray = [[RbtDataOfResponse sharedInstance].lishishujuGongChengLieBiaoDic objectForKey:@"d"];
    NSLog(@"");
    for (NSDictionary *tempDic in dArray) {
        if ([[tempDic objectForKey:@"t"] isEqualToString:@"analog"]) {
            NSString *sbName = [tempDic objectForKey:@"n"];
            if ([sbName hasPrefix:@"W"]||[sbName hasPrefix:@"T"]) {
                [tempArray addObject:sbName];
            }
        }
    }
    
    return tempArray;
}


-(void)timeButtonClicked:(UIButton *)sender
{
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"index %d", buttonIndex);
    switch (buttonIndex) {
        case 0:
            timeLabel.text = @"最近24小时";
            chooseTime = @"day";
            break;
            
        case 1:
            timeLabel.text = @"最近一周";
            chooseTime = @"week";
            break;
            
        case 2:
            timeLabel.text = @"最近一个月";
            chooseTime = @"month";
            break;
            
        default:
            break;
    }
    [self postData];
}

-(void)lnButtonClicked
{
    dataTabelView.hidden = NO;
    chartView.hidden = YES;
}

-(void)xxtButtonClicked
{
    dataTabelView.hidden = YES;
    chartView.hidden = NO;
}

#pragma tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numOfRow;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return dataTabelView.height/7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProjectCell"];
    
    cell.height = dataTabelView.height/7;
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 614/2, cell.height)];
    [bgImageView setImage:[UIImage imageNamed:@"cellBGImage"]];
    [cell addSubview:bgImageView];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.height-2, 614/2, 4)];
    [lineImageView setImage:[UIImage imageNamed:@"cellLine"]];
    [cell addSubview:lineImageView];
    
    UIImageView *imageView_clock = [[UIImageView alloc] initWithFrame:CGRectMake(30-12, (cell.height-12)/2, 12, 12)];
    [imageView_clock setImage:[UIImage imageNamed:@"cellClock"]];
    [cell addSubview:imageView_clock];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 250, cell.frame.size.height)];
    [leftLabel setFont:[UIFont fontWithName:kFontName size:15]];
    [leftLabel setBackgroundColor:[UIColor clearColor]];
    if ([timeArray count] > 0) {
        leftLabel.text = [timeArray objectAtIndex:indexPath.row];
    }
    [cell addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(596/2-150-20, 0, 150, cell.frame.size.height)];
    [rightLabel setFont:[UIFont fontWithName:kFontName size:15]];
    if ([dataArray count] > 0) {
        NSString *rightText =(NSString *)[dataArray objectAtIndex:indexPath.row];
        [rightLabel setText:[NSString stringWithFormat:@"%@%@",rightText,danw]];
    }
    [rightLabel setTextAlignment:NSTextAlignmentRight];
    [cell addSubview:rightLabel];
    
    return cell;
}

-(void)typeButtonPressed:(UIButton *)button
{
    int index = button.tag - 800;
    chooseName = [shebeiArray objectAtIndex:index];
    for (int n = 0; n < shebeiCount; n++) {
        [sc viewWithTag:(1000+ n)].hidden = YES;
    }
    [sc viewWithTag:(1000+ index)].hidden = NO;
    [self postData];
}

-(void)postData
{
    RbtWebManager *webManager;
    if([RbtCommonTool getJinRuMode] != LiXianGongCheng){
        webManager = [RbtWebManager getRbtManager:YES];
    }
    else{
        webManager = [RbtWebManager getRbtManager:NO];
    }
    webManager.name = @"lishishuju2";
    webManager.delegate = self;
    [self.hud1 show:YES];
    [timeArray removeAllObjects];
    [dataArray removeAllObjects];
    [webManager gethisdataitemvalue:[RbtProjectModel sharedInstance].projectid withD:chooseName andT:chooseTime];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == sc) {
        int page = scrollView.contentOffset.x/sc.width;
        for (int k = 0; k < scCount; k++) {
            UIImageView *tempImageView = (UIImageView *)[self.view viewWithTag:(900+k)];
            if (k == page) {
                [tempImageView setImage:[UIImage imageNamed:@"point_s"]];
            }
            else
            {
                [tempImageView setImage:[UIImage imageNamed:@"point"]];
            }
        }
    }
    else if (scrollView == dataTabelView)
    {
        NSLog(@"EndDecelerating");
    }
}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
//    NSLog(@"resdic= %@", responseDic);
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"lishishuju2"]) {
        if ([RbtCommonTool getJinRuMode] == LiXianGongCheng) {
            [RbtDataOfResponse sharedInstance].lishishujuSheBeiShuJuDic = responseDic;
        }
        else if([RbtCommonTool getJinRuMode] == GongGGC){
            
            NSLog(@"rc=%d", [[responseDic objectForKey:@"rc"] intValue]);
            
            if ([[responseDic objectForKey:@"rc"] intValue]) {
                
                //                NSLog(@"resdic= %@", responseDic);
                NSDictionary *tempDIc = [responseDic objectForKey:@"rt"];
                //                NSLog(@"tempdic= %@", tempDIc)
                
                
                [RbtDataOfResponse sharedInstance].lishishujuSheBeiShuJuDic = tempDIc;
            }
            else
            {
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }

        else{
            
//            NSLog(@"rc=%d", [[responseDic objectForKey:@"rc"] intValue]);
            if ([[responseDic objectForKey:@"rc"] intValue]) {
                
//                NSLog(@"resdic= %@", responseDic);
                NSDictionary *tempDIc = [responseDic objectForKey:@"rt"];
//                NSLog(@"tempdic= %@", tempDIc)
                
                
                [RbtDataOfResponse sharedInstance].lishishujuSheBeiShuJuDic = tempDIc;
            }
            else
            {
                [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
            }
        }
    }
    
    NSString *shebei =[[RbtDataOfResponse sharedInstance].lishishujuSheBeiShuJuDic objectForKey:@"d"];
    NSArray *arr = [shebei componentsSeparatedByString:@"_"];
    if ([arr count] == 2) {
        NSString *sheb = (NSString *)[arr objectAtIndex:0];
        if ([sheb hasPrefix:@"W"]) {
            danw = @"%";
        }
        else{
            danw =@"℃";
        }
    }
    
    NSArray *tableDataArr = [[RbtDataOfResponse sharedInstance].lishishujuSheBeiShuJuDic objectForKey:@"v"];
    numOfRow = tableDataArr.count;
//    NSLog(@"dic=%@", [RbtDataOfResponse sharedInstance].lishishujuSheBeiShuJuDic);
//    NSLog(@"tabledataarr= %@", tableDataArr);
    
    for (NSArray *oD in tableDataArr) {
        NSTimeInterval timespace = [[oD objectAtIndex:0] doubleValue]/1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timespace];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:date];
//        NSLog(@"date = %@", strDate);
        double fld=[[oD objectAtIndex:1] doubleValue];
        NSString *fl = [NSString stringWithFormat:@"%.2f",fld];
        int v2 = [[oD objectAtIndex:2] intValue];
        if (v2 != 0) {
            numOfRow--;
        }
        else
        {
            [dataArray addObject:fl];
            [timeArray addObject:strDate];
        }
        [xxtimeArray addObject:strDate];
        [values addObject:fl];

    }
//    NSLog(@"data= %@", dataArray);
    if (!dataTabelView) {
        [self postData];
    }
    [dataTabelView reloadData];
    [chartView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FYChartViewDataSource

//number of value count
- (NSInteger)numberOfValueItemCountInChartView:(FYChartView *)chartView;
{
    return values ? values.count : 0;
}

//value at index
- (float)chartView:(FYChartView *)chartView valueAtIndex:(NSInteger)index
{
    return [((NSNumber *)values[index]) floatValue];
}

//horizontal title at index
- (NSString *)chartView:(FYChartView *)chartView horizontalTitleAtIndex:(NSInteger)index
{


    if (index == 0 || index == values.count - 1)
    {
        NSString *data = [xxtimeArray objectAtIndex:index];
        NSArray *arr = [data componentsSeparatedByString:@" "];
        NSString *str = [arr objectAtIndex:0];
        return str;

    }
    
    return nil;
}

//horizontal title alignment at index
- (HorizontalTitleAlignment)chartView:(FYChartView *)chartView horizontalTitleAlignmentAtIndex:(NSInteger)index
{
    HorizontalTitleAlignment alignment = HorizontalTitleAlignmentCenter;
    if (index == 0)
    {
        alignment = HorizontalTitleAlignmentCenter;
    }
    else if (index == values.count - 1)
    {
        alignment = HorizontalTitleAlignmentRight;
    }
    
    return alignment;
}

//description view at index
- (UIView *)chartView:(FYChartView *)chartView descriptionViewAtIndex:(NSInteger)index
{
    NSString *description = [NSString stringWithFormat:@"date=%@                                                                              \nvalue=%.2f", [xxtimeArray objectAtIndex:index],
                             [((NSNumber *)values[index]) floatValue]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chart_ description_bg"]];
    CGRect frame = imageView.frame;
    frame.size = CGSizeMake(90.0f, 40.0f);
    imageView.frame = frame;
    UILabel *label = [[UILabel alloc]
                       initWithFrame:CGRectMake(.0f, .0f, imageView.frame.size.width, imageView.frame.size.height)];
    label.text = description;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:10.0f];
    [imageView addSubview:label];
    
    return imageView;
}

@end
