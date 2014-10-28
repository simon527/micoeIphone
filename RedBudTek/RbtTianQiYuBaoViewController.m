//
//  RbtTianQiYuBaoViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-12.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtTianQiYuBaoViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
@interface RbtTianQiYuBaoViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    UIImageView *imgv;
}
@end

@implementation RbtTianQiYuBaoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    if (self.isShouYe) {
        [self getCityCode];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)getCityCode{
    if ([CLLocationManager locationServicesEnabled]) {
        [self.hud1 show:YES];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate=self;
        locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        locationManager.distanceFilter=1000.0f;
        [locationManager startUpdatingLocation];
    }
    else{
        [RbtCommonTool showInfoAlert:@"未开启定位服务，请到设置-> 隐私-> 定位服务中开启"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isFirstJia = YES;
    _isShouYe = YES;
    self.title = @"天气预报";
    imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tq_jzsb"]];
    imgv.frame = CGRectMake(0, (ScreenHeight-320)/2+32, 320, 320);
    imgv.hidden = YES;
    [self.view addSubview:imgv];

	// Do any additional setup after loading the view.
}

- (void)initViews{
    self.isFirstJia = NO;
    imgv.hidden = YES;
    self.weatherInfo  = [self.weatherInfo objectForKey:@"weatherinfo"];
    NSString *weather1 = [self getWeatherInfo:[self.weatherInfo objectForKey:@"weather1"]];
    
    NSString *temp1 = [self.weatherInfo objectForKey:@"temp1"];
    
    UIImageView *titleImgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tq_%@_big",weather1]]];
    titleImgv.frame = CGRectMake(0, 64, 320, 173);
    [self.view addSubview:titleImgv];
    
    UILabel *lab_city = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-105, 125, 80, 20)];
    lab_city.font = [UIFont fontWithName:kFontName size:11];
    lab_city.textAlignment = NSTextAlignmentRight;
    lab_city.textColor = [UIColor whiteColor];
    lab_city.text = [self.weatherInfo objectForKey:@"city"];
//    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_city];
    
    UILabel *lab_temp = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-145, 145, 120, 30)];
    lab_temp.font = [UIFont fontWithName:@"Helvetica_Bold" size:20];
    lab_temp.textAlignment = NSTextAlignmentRight;
    lab_temp.textColor = [UIColor whiteColor];
    lab_temp.text = temp1;
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_temp];
    
    UILabel *lab_date = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-165, 175, 140, 20)];
    lab_date.font = [UIFont fontWithName:@"Helvetica" size:10];
    lab_date.textAlignment = NSTextAlignmentRight;
    lab_date.textColor = [UIColor whiteColor];
    lab_date.text = [(NSString *)[self.weatherInfo objectForKey:@"date_y"] stringByAppendingString:[NSString stringWithFormat:@" ｜ %@",[self.weatherInfo objectForKey:@"weather1"]]];
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_date];
    
    UIImageView *imageV_w = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tq_wbg"]];
    imageV_w.frame = CGRectMake(0, 237, 320, 35);
    [self.view addSubview:imageV_w];
    
    UILabel *lab_w = [[UILabel alloc] initWithFrame:CGRectMake(25, 245, 120, 20)];
    lab_w.font = [UIFont fontWithName:kFontName size:12];
    lab_w.textAlignment = NSTextAlignmentLeft;
    lab_w.textColor = [UIColor blackColor];
    lab_w.text = @"未来5天天气预报";
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_w];
    
    UIScrollView *scrollVc;
    if (self.isShouYe) {
        scrollVc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 272, ScreenWidth, ScreenHeight-272)];
    }
    else{
        scrollVc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 272, ScreenWidth, ScreenHeight-272-49)];
    }
    scrollVc.contentSize = CGSizeMake(ScreenWidth, 294);
    [self.view addSubview:scrollVc];
    
    UIImageView *imgv_wltqbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tq_wltqbg"]];
    imgv_wltqbg.frame = CGRectMake(0, 0, 320, 294);
    [scrollVc addSubview:imgv_wltqbg];
    
    NSArray *arr_week = [[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    int int_week = [arr_week indexOfObject:[self.weatherInfo objectForKey:@"week"]];
    
    for (int i = 0; i<5; i++) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:i*3600*24];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM dd "];
        NSString *strDate = [dateFormatter stringFromDate:date];
        
        UILabel *lab_dates = [[UILabel alloc] initWithFrame:CGRectMake(25 , 10+59*i, 40, 20)];
        lab_dates.font = [UIFont fontWithName:kFontName size:12];
        lab_dates.textAlignment = NSTextAlignmentLeft;
        lab_dates.textColor = [UIColor blackColor];
        lab_dates.text =strDate;
        //    lab_city.backgroundColor = [UIColor blueColor];
        [scrollVc addSubview:lab_dates];
        
        UILabel *lab_week = [[UILabel alloc] initWithFrame:CGRectMake(25 , 30+59*i, 40, 20)];
        lab_week.font = [UIFont fontWithName:kFontName size:12];
        lab_week.textAlignment = NSTextAlignmentLeft;
        lab_week.textColor = [UIColor blackColor];
        if (int_week>6) {
            int_week = 0;
        }
        lab_week.text =[arr_week objectAtIndex:int_week];
        int_week = int_week +1;
        //    lab_city.backgroundColor = [UIColor blueColor];
        [scrollVc addSubview:lab_week];
        NSString *weather = [self getWeatherInfo:[self.weatherInfo objectForKey:[NSString stringWithFormat:@"weather%d",(i+1)]]];
        UIImageView *imv_ws = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tq_%@",weather]]];
        imv_ws.frame = CGRectMake(110, 17+59*i, 37, 26);
        [scrollVc addSubview:imv_ws];
        
        UILabel *lab_temp = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-78-20 , 15+59*i, 60, 20)];
        lab_temp.font = [UIFont fontWithName:@"Helvetica" size:12];
        lab_temp.textAlignment = NSTextAlignmentRight;
        lab_temp.textColor = [UIColor blackColor];
        lab_temp.text =[self.weatherInfo objectForKey:[NSString stringWithFormat:@"temp%d",(i+1)]];
        //    lab_city.backgroundColor = [UIColor blueColor];
        [scrollVc addSubview:lab_temp];
     
        UIImageView *imv_xiabiao = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tq_%@",self.xiaBiao]]];
        imv_xiabiao.frame = CGRectMake(ScreenWidth-103-20, 32+59*i, 103, 14);
        [scrollVc addSubview:imv_xiabiao];
    }
}

- (void)initViewswithBaidu{
    self.isFirstJia = NO;
    imgv.hidden = YES;
    NSArray *resultss = [self.weatherInfo objectForKey:@"results"];
    NSDictionary *results =[resultss objectAtIndex:0];
    NSArray *weather_data = [results objectForKey:@"weather_data"];
    NSDictionary *day1 = [weather_data objectAtIndex:0];
    
    NSString *weather1 = [self getWeatherInfo:[day1 objectForKey:@"weather"]];
    
    NSString *temp1 = [day1 objectForKey:@"temperature"];
    
    UIImageView *titleImgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tq_%@_big",weather1]]];
    titleImgv.frame = CGRectMake(0, 64, 320, 173);
    [self.view addSubview:titleImgv];
    
    UILabel *lab_city = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-105, 125, 80, 20)];
    lab_city.font = [UIFont fontWithName:kFontName size:11];
    lab_city.textAlignment = NSTextAlignmentRight;
    lab_city.textColor = [UIColor whiteColor];
    lab_city.text = [results objectForKey:@"currentCity"];
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_city];
    
    UILabel *lab_temp = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-145, 145, 120, 30)];
    lab_temp.font = [UIFont fontWithName:@"Helvetica_Bold" size:20];
    lab_temp.textAlignment = NSTextAlignmentRight;
    lab_temp.textColor = [UIColor whiteColor];
    lab_temp.text = temp1;
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_temp];
    
    UILabel *lab_date = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-165, 175, 140, 20)];
    lab_date.font = [UIFont fontWithName:@"Helvetica" size:10];
    lab_date.textAlignment = NSTextAlignmentRight;
    lab_date.textColor = [UIColor whiteColor];
    lab_date.text = [(NSString *)[self.weatherInfo objectForKey:@"date"] stringByAppendingString:[NSString stringWithFormat:@" ｜ %@",[day1 objectForKey:@"weather"]]];
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_date];
    
    UIImageView *imageV_w = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tq_wbg"]];
    imageV_w.frame = CGRectMake(0, 237, 320, 35);
    [self.view addSubview:imageV_w];
    
    UILabel *lab_w = [[UILabel alloc] initWithFrame:CGRectMake(25, 245, 120, 20)];
    lab_w.font = [UIFont fontWithName:kFontName size:12];
    lab_w.textAlignment = NSTextAlignmentLeft;
    lab_w.textColor = [UIColor blackColor];
    lab_w.text = @"未来4天天气预报";
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_w];
    
    UIScrollView *scrollVc;
    if (self.isShouYe) {
        scrollVc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 272, ScreenWidth, ScreenHeight-272)];
    }
    else{
        scrollVc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 272, ScreenWidth, ScreenHeight-272-49)];
    }
    scrollVc.contentSize = CGSizeMake(ScreenWidth, 294-59);
    [self.view addSubview:scrollVc];
    
    UIImageView *imgv_wltqbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tq_wltqbg"]];
    imgv_wltqbg.frame = CGRectMake(0, 0, 320, 294);
    [scrollVc addSubview:imgv_wltqbg];
    
    NSArray *arr_week = [[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    NSArray *arr_week2 =[[NSArray alloc] initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    NSString *weekString = [day1 objectForKey:@"date"];
    weekString = [weekString substringToIndex:2];
    int int_week = [arr_week2 indexOfObject:weekString];
   
    for (int i = 0; i<4; i++) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:i*3600*24];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM dd "];
        NSString *strDate = [dateFormatter stringFromDate:date];
        
        UILabel *lab_dates = [[UILabel alloc] initWithFrame:CGRectMake(25 , 10+59*i, 40, 20)];
        lab_dates.font = [UIFont fontWithName:kFontName size:12];
        lab_dates.textAlignment = NSTextAlignmentLeft;
        lab_dates.textColor = [UIColor blackColor];
        lab_dates.text =strDate;
        //    lab_city.backgroundColor = [UIColor blueColor];
        [scrollVc addSubview:lab_dates];
        
        UILabel *lab_week = [[UILabel alloc] initWithFrame:CGRectMake(25 , 30+59*i, 40, 20)];
        lab_week.font = [UIFont fontWithName:kFontName size:12];
        lab_week.textAlignment = NSTextAlignmentLeft;
        lab_week.textColor = [UIColor blackColor];
        if (int_week>6) {
            int_week = 0;
        }
        lab_week.text =[arr_week objectAtIndex:int_week];
        int_week = int_week +1;
        //    lab_city.backgroundColor = [UIColor blueColor];
        [scrollVc addSubview:lab_week];
        NSString *weather = [self getWeatherInfo:[self.weatherInfo objectForKey:[NSString stringWithFormat:@"weather%d",(i+1)]]];
        NSDictionary *day =[weather_data objectAtIndex:i];
        weather = [self getWeatherInfo:[day objectForKey:@"weather"]];
        UIImageView *imv_ws = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tq_%@",weather]]];
        imv_ws.frame = CGRectMake(110, 17+59*i, 37, 26);
        [scrollVc addSubview:imv_ws];
        
        UILabel *lab_temp = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-78-20 , 15+59*i, 60, 20)];
        lab_temp.font = [UIFont fontWithName:@"Helvetica" size:12];
        lab_temp.textAlignment = NSTextAlignmentRight;
        lab_temp.textColor = [UIColor blackColor];
        lab_temp.text =[day objectForKey:@"temperature"];
        //    lab_city.backgroundColor = [UIColor blueColor];
        [scrollVc addSubview:lab_temp];
        
        UIImageView *imv_xiabiao = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tq_%@",self.xiaBiao]]];
        imv_xiabiao.frame = CGRectMake(ScreenWidth-103-20, 32+59*i, 103, 14);
        [scrollVc addSubview:imv_xiabiao];
    }
}

- (NSString *)getWeatherInfo:(NSString *)weatherString{
    NSString *result = @"yintian";
    if ([weatherString isEqualToString:@"晴"]) {
        result = @"sunny";
        self.xiaBiao = @"hong";
        return result;
    }
    else if([weatherString rangeOfString:@"阴"].length>0){
        result = @"yintian";
        self.xiaBiao = @"lv";
        return result;
    }
    else if([weatherString rangeOfString:@"多云"].length>0){
        result = @"duoyun";
        self.xiaBiao = @"cheng";
        return result;
    }
    else if([weatherString rangeOfString:@"雾"].length>0){
        result = @"wu";
        self.xiaBiao = @"lv";
        return result;
    }
    else if([weatherString rangeOfString:@"雷阵雨"].length>0){
        result = @"leizhenyu";
        self.xiaBiao = @"lv";
        return result;
    }
    else if([weatherString rangeOfString:@"雷"].length>0){
        result = @"lei";
        self.xiaBiao = @"lv";
        return result;
    }
    else if([weatherString rangeOfString:@"大暴雨"].length>0){
        result = @"dabaoyu";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"暴雨"].length>0){
        result = @"baoyu";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"大雨"].length>0){
        result = @"dayu";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"中雨"].length>0){
        result = @"zhongyu";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"小雨"].length>0){
        result = @"xiaoyu";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"暴雪"].length>0){
        result = @"baoxue";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"大雪"].length>0){
        result = @"daxue";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"中雪"].length>0){
        result = @"zhongxue";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"小雪"].length>0){
        result = @"xiaoxue";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"阵雪"].length>0){
        result = @"zhenxue";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"雨夹雪"].length>0){
        result = @"yujiaxue";
        self.xiaBiao = @"lan";
        return result;
    }
    else if([weatherString rangeOfString:@"沙尘暴"].length>0){
        result = @"shachenbao";
        self.xiaBiao = @"lan";
        return result;
    }
    return result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"newLocation  = %@",newLocation);
    RbtWebManager *tqybweb = [[RbtWebManager alloc] init];
    tqybweb.name = @"tqybwebwithBaidu";
    tqybweb.delegate =self;
    NSString *stringCityLocation = [NSString stringWithFormat:@"%f,%f",newLocation.coordinate.longitude,newLocation.coordinate.latitude];
    [tqybweb getWeatherInfowithBaidu:stringCityLocation];
    
    /*
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: newLocation completionHandler:^(NSArray *array, NSError *error) {
        if (error) {
                NSLog(@"reverseGeocodeLocation fail error = %@",error);
            [self showTheInfo];
        }
        else{
            if (array.count > 0) {
                CLPlacemark *placemark = [array objectAtIndex:0];
                RbtWebManager *getCitycodeweb =[RbtWebManager getRbtManager:NO];
                NSString *sqlString;
                if (placemark.administrativeArea) {
                    NSLog(@"administrativeArea = %@",placemark.administrativeArea);
                    if (placemark.locality) {
                        sqlString = [NSString stringWithFormat:@"SELECT * FROM city_table where TOWN LIKE '%@%%' and PROVINCE LIKE '%@%%'",[placemark.locality substringToIndex:[placemark.locality length]-1],[placemark.administrativeArea substringToIndex:[placemark.administrativeArea length]-1]];
                    
                    }
                    else{
                        sqlString = [NSString stringWithFormat:@"SELECT * FROM city_table where TOWN LIKE '%@%%'",[placemark.administrativeArea substringToIndex:[placemark.administrativeArea length]-1]];
                    }
                }
                else if (placemark.locality){
                    sqlString = [NSString stringWithFormat:@"SELECT * FROM city_table where TOWN LIKE '%@%%'",[placemark.locality substringToIndex:[placemark.locality length]-1]];
                }
                else{
                     [self showTheInfo];
                }
                if (sqlString) {
                    NSString *cityWeatherid =  [getCitycodeweb getCityWeatherid:sqlString];
                    if (cityWeatherid) {
                        RbtWebManager *tqybweb = [[RbtWebManager alloc] init];
                        tqybweb.name = @"tqybweb";
                        tqybweb.delegate =self;
                        [tqybweb getWeatherInfo:cityWeatherid];

                    }
                    else{
                        [self showTheInfo];
                    }
                }
                else{
                    [self showTheInfo];
                }
            }
            else{
                [self showTheInfo];
            }
        }
    }];
     */
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSString *errorString;
    [manager stopUpdatingLocation];
    NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
            //Access denied by user
            {
                errorString = @"Access to Location Services denied by user";
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.hud1 hide:YES];
                    [RbtCommonTool showInfoAlert:@"未开启本应用的定位服务，请到设置-> 隐私-> 定位服务中开启本应用的定位服务"];
                });
            }
            //Do something...
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"Location data unavailable";
            [self showTheInfo];
            //Do something else...
            break;
        default:
            errorString = @"An unknown error has occurred";
            [self showTheInfo];
            break;
    }
}

- (void)showTheInfo{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud1 hide:YES];
        [RbtCommonTool showInfoAlert:@"无法解析你的地址，请稍后再试"];
    });
}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"tqybwebwithBaidu"]){
        if ([[responseDic objectForKey:@"error"] integerValue] == 0) {
            self.isShouYe = YES;
            self.weatherInfo = responseDic;
            if (self.isFirstJia) {
                [self initViewswithBaidu];
            }
        } else {
            [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"status"]];
        }
    }
    else if ([webService.name isEqualToString:@"tqybweb"]){
        self.isShouYe = YES;
        self.weatherInfo = responseDic;
        if (self.isFirstJia) {
            [self initViews];
        }
    }
    else if([webService.name isEqualToString:@"stringday"]){
        self.weatherInfo = responseDic;
        if (self.isFirstJia) {
            [self initViews];
        }
    }
}

- (void)webServicefailed:(RbtWebManager *) webService{
    [super webServicefailed:webService];
    if ([webService.name isEqualToString:@"tqybweb"]) {
        RbtWebManager *manager = [[RbtWebManager alloc] init];
        manager.name = @"stringday";
        manager.delegate = self;
        [manager getTheDayWeather];
    }
}

@end
