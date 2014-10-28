//
//  micTianQiYuBaoViewController.m
//  micoe(ipad)
//
//  Created by Simon on 14-1-20.
//  Copyright (c) 2014年 Simon. All rights reserved.
//

#import "micTianQiYuBaoViewController.h"

@interface micTianQiYuBaoViewController ()
{
    NSString *cityId;
    NSString *cityShishiTem;
    
    UIImageView *titleImgv;
    UIImageView *xiaImageView;
    UILabel *lab_city;
    UILabel *lab_temp;
    UILabel *lab_date;
}

@end

@implementation micTianQiYuBaoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)postData
{
    [self.hud1 show:YES];
    RbtWebManager *tqybweb = [[RbtWebManager alloc] init];
    tqybweb.name = @"tqybweb";
    tqybweb.delegate =self;
    [tqybweb getWeatherInfo:[RbtProjectModel sharedInstance].citycode];
    NSLog(@"--%@", [RbtProjectModel sharedInstance].citycode);
    cityId = [RbtProjectModel sharedInstance].citycode;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    if (self.isShouYe) {
        [self getCityCode];
    }
    else
    {
        

    }
    [self setItemsFrame:self.interfaceOrientation];
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
    imgv.frame = CGRectMake(768, (ScreenHeight-320)/2+32, 768, 768);
    imgv.hidden = YES;
    [self.view addSubview:imgv];
}

- (void)initViews{
    self.isFirstJia = NO;
    imgv.hidden = YES;
    self.weatherInfo  = [self.weatherInfo objectForKey:@"weatherinfo"];
    NSLog(@"ww= %@", self.weatherInfo);
    
    NSString *weather1 = [self getWeatherInfo:[self.weatherInfo objectForKey:@"weather1"]];
    
//    NSString *temp1 = [self.weatherInfo objectForKey:@"temp1"];
    NSString *temp1 = [NSString stringWithFormat:@"%@℃",cityShishiTem];
//    NSString *temp1 = cityShishiTem;
    
    titleImgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tq_%@_big",weather1]]];
//    titleImgv.frame = CGRectMake(0, 64, 768, 415);
    [self.view addSubview:titleImgv];
    
    xiaImageView = [[UIImageView alloc] init];
    [xiaImageView setImage:[UIImage imageNamed:@"tq_xiabiao"]];
    [self.view addSubview:xiaImageView];
    
    lab_city = [[UILabel alloc] init];
    lab_city.font = [UIFont fontWithName:kFontName size:22];
    lab_city.textAlignment = NSTextAlignmentLeft;
    lab_city.textColor = [UIColor whiteColor];
    NSString *weather_h = [self.weatherInfo objectForKey:@"weather1"];
    lab_city.text = [NSString stringWithFormat:@"%@|%@", [self.weatherInfo objectForKey:@"city"], weather_h];
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_city];
    
    lab_temp = [[UILabel alloc] init];
    lab_temp.font = [UIFont fontWithName:@"Helvetica" size:45];
    lab_temp.textAlignment = NSTextAlignmentLeft;
    lab_temp.textColor = [UIColor whiteColor];
    lab_temp.text = temp1;
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_temp];
    
    lab_date = [[UILabel alloc] init];
    lab_date.font = [UIFont fontWithName:@"Helvetica" size:18];
    lab_date.textAlignment = NSTextAlignmentLeft;
    lab_date.textColor = [UIColor whiteColor];
    lab_date.text = [(NSString *)[self.weatherInfo objectForKey:@"date_y"] stringByAppendingString:[NSString stringWithFormat:@" ｜ %@",[self.weatherInfo objectForKey:@"week"]]];
    //    lab_city.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lab_date];
    

    
    NSArray *arr_week = [[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    int int_week = [arr_week indexOfObject:[self.weatherInfo objectForKey:@"week"]];
    
    for (int i = 0; i<6; i++) {
        int m = i/3;
        UIView *biaogeView = [[UIView alloc] initWithFrame:CGRectMake(0+(i%3)*(768/3),  m*xiaImageView.height/2, 768/3, xiaImageView.height/2)];
        [xiaImageView addSubview:biaogeView];
        
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:i*3600*24];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM月dd日 "];
        NSString *strDate = [dateFormatter stringFromDate:date];
        
        UILabel *lab_week = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, biaogeView.width-20, 40)];
        lab_week.font = [UIFont fontWithName:kFontName size:16];
        lab_week.textAlignment = NSTextAlignmentRight;
        lab_week.textColor = [UIColor blackColor];
        if (int_week>6) {
            int_week = 0;
        }
        lab_week.text = [NSString stringWithFormat:@"%@|%@", strDate, [arr_week objectAtIndex:int_week]];
        int_week = int_week +1;
        //    lab_city.backgroundColor = [UIColor blueColor];
        [biaogeView addSubview:lab_week];
        
        NSString *weather = [self getWeatherInfo:[self.weatherInfo objectForKey:[NSString stringWithFormat:@"weather%d",(i+1)]]];
        UIImageView *imv_ws = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tq_%@",weather]]];
//        [imv_ws setSize:CGSizeMake(74, 65)];
        CGPoint ce;
        ce.x = biaogeView.width/2;
        ce.y = biaogeView.height/2-40;
        imv_ws.center = ce;
        [biaogeView addSubview:imv_ws];
        
        UILabel *lab_tem = [[UILabel alloc] init];
        lab_tem.font = [UIFont fontWithName:@"Helvetica" size:24];
        lab_tem.textAlignment = NSTextAlignmentCenter;
        lab_tem.textColor = [UIColor blackColor];
        lab_tem.text =[self.weatherInfo objectForKey:[NSString stringWithFormat:@"temp%d",(i+1)]];
        [lab_tem setSize:CGSizeMake(biaogeView.width, 40)];
        CGPoint ce1;
        ce1.x = ce.x;
        ce1.y = ce.y + 90;
        NSLog(@"xx = %f", ce.x);
        lab_temp.center = ce1;
        [biaogeView addSubview:lab_tem];
        
        UIImageView *imv_xiabiao = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"tq_%@",self.xiaBiao]]];
        imv_xiabiao.size = CGSizeMake(103, 14);
        CGPoint ce2;
        ce2.x = ce.x;
        ce2.y = ce.y + 50;
        imv_xiabiao.center = ce2;
        [biaogeView addSubview:imv_xiabiao];
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
                    NSLog(@"administrativeArea");
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
                    cityId = cityWeatherid;
                    if (cityWeatherid) {
                        RbtWebManager *tqybweb = [[RbtWebManager alloc] init];
                        tqybweb.name = @"tqybweb";
                        tqybweb.delegate =self;
                        [tqybweb getWeatherInfo:cityWeatherid];
                        NSLog(@"id=%@", cityWeatherid);
                        
                        
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
    

    if ([webService.name isEqualToString:@"tqybweb"]){
        self.isShouYe = YES;
        self.weatherInfo = responseDic;
        RbtWebManager *tqybweb = [[RbtWebManager alloc] init];
        tqybweb.name = @"shishi";
        tqybweb.delegate =self;
        [tqybweb getWeatherInfoshishi:cityId];

    }
    else if([webService.name isEqualToString:@"stringday"]){
        self.weatherInfo = responseDic;
        if (self.isFirstJia) {
            [self initViews];
        }
    }
    else if([webService.name isEqualToString:@"shishi"]){
        
        NSLog(@"res=%@", responseDic);
        cityShishiTem = [[responseDic objectForKey:@"weatherinfo"] objectForKey:@"temp"];
        if (self.isFirstJia) {
            [self initViews];
        }
        NSLog(@"tt=%@", cityShishiTem);
        
        
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

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self setItemsFrame:toInterfaceOrientation];
}


-(void)setItemsFrame:(UIInterfaceOrientation)orientation
{
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {

    }
    else
    {
        titleImgv.frame = CGRectMake(0, 64, 768, 415);
        xiaImageView.frame = CGRectMake(0, 64+415, 768, 498);
        lab_city.frame = CGRectMake(320, 352, 260, 50);
        lab_temp.frame = CGRectMake(20, 90, 200, 80);
        lab_date.frame = CGRectMake(20, 64, 300, 40);
    }
    
}

@end
