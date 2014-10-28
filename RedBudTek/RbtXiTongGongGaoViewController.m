//
//  RbtXiTongGongGaoViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-12.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtXiTongGongGaoViewController.h"
#import "GTMBase64.h"

@interface RbtXiTongGongGaoViewController ()<UIScrollViewDelegate>{
    UIPageControl *pageControl;
    NSTimer *timer;
}

@property(strong,nonatomic) UIScrollView *scrollVc;
@end

@implementation RbtXiTongGongGaoViewController

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
    timer =  [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(qiehuantu) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"系统公告";
    self.scrollVc = [[UIScrollView alloc] init];
    self.scrollVc.frame = CGRectMake(0, 0, 320, 200);
    self.scrollVc.contentSize = CGSizeMake(320*6, 0);
    [self.scrollVc setShowsHorizontalScrollIndicator:NO];
    [self.scrollVc setShowsVerticalScrollIndicator:NO];
//    scrollVc.alwaysBounceVertical =NO;
    self.scrollVc.pagingEnabled = YES;
    self.scrollVc.delegate = self;
    [self.view addSubview:self.scrollVc];
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(ScreenWidth/2-50, 205, 100, 30);//指定位置大小
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.numberOfPages = 6;//指定页面个数
    pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
//    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 235, 320, ScreenHeight-235)];
//    [webView setBackgroundColor:[UIColor grayColor]];
    webView.scalesPageToFit =YES;
    [webView loadHTMLString:self.htmlString baseURL:nil];
    [self.view addSubview:webView];
    
    self.arr_imageNames = [RbtCommonTool getgetversionNameArray];
    [self getGengXing];
	// Do any additional setup after loading the view.
}

//- (void)changePage:(id)sender {
//    int page = pageControl.currentPage;//获取当前pagecontroll的值
//}

- (void)qiehuantu{
    if (pageControl.currentPage > 4) {
        pageControl.currentPage = 0;
    }
    else{
        pageControl.currentPage =pageControl.currentPage+1;
    }
    [self.scrollVc setContentOffset:CGPointMake(320*(pageControl.currentPage), 0)];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = self.scrollVc.contentOffset.x / 320;//通过滚动的偏移量来判断目前页面所对应的小白点
    pageControl.currentPage = page;//pagecontroll响应值的变化
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- loadData
- (void)getGengXing{
    RbtWebManager *webManager = [[RbtWebManager alloc] init];
    webManager.name = @"getversion";
    webManager.delegate = self;
    NSArray *array = [[NSArray alloc] initWithArray:self.arr_imageNames];
    [webManager getversion:array];
}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"getversion"]) {
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
            NSDictionary *rt_dic =  [responseDic objectForKey:@"rt"];
            if ([[rt_dic objectForKey:@"f"] isEqualToString:@"1"]) {
                NSMutableArray *arr_imageName = [[NSMutableArray alloc] initWithArray:[rt_dic objectForKey:@"o"]];
                
                NSString *dirPath = [RbtCommonTool getversionFilePath];
                NSArray *i_arr = [rt_dic objectForKey:@"i"];
                for (NSDictionary *img_dic in i_arr) {
                    NSString *img_name = [img_dic objectForKey:@"n"];
                    NSString *img_string = [img_dic objectForKey:@"v"];
                    NSData *imageData = [self changeImageStrToData:img_string];
                    NSString * imageFilePath = [dirPath stringByAppendingFormat:@"/%@.png",img_name];
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    BOOL succeed = [fileManager createFileAtPath:imageFilePath contents:imageData attributes:nil];
                    if (succeed) {
                        [arr_imageName addObject:img_name];
                    }
                }
                [RbtCommonTool setgetversionNameArray:arr_imageName];
            }
        }
    }
    else{
        [RbtCommonTool showInfoAlert:[responseDic objectForKey:@"rd"]];
    }
    
    
    self.arr_imageNames = [RbtCommonTool getgetversionNameArray];
    if ([self.arr_imageNames count]>0) {
        for (int i = 0; i<6; i++) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 200)];
            NSString *dirPath = [RbtCommonTool getversionFilePath];
            NSString *filePath = [dirPath stringByAppendingFormat:@"/%@.png",[self.arr_imageNames objectAtIndex:i]];
            UIImage *img = [[UIImage  alloc] initWithContentsOfFile:filePath];
            if (img == nil) {
                img = [UIImage  imageNamed:[NSString stringWithFormat:@"xtgg%d",i+1]];
            }
            img = [self imageWithImageSimple:img scaledToSize:CGSizeMake(320, 200)];
            imageV.image = img;
            [self.scrollVc addSubview:imageV];
            imageV.tag = 100+i;
        }
    }
    else{
        for (int i = 0; i<6; i++) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 200)];
            imageV.image = [UIImage  imageNamed:[NSString stringWithFormat:@"xtgg%d",i+1]];
            [self.scrollVc addSubview:imageV];
            imageV.tag = 100+i;
        }
    }
}

#pragma mark- base64
- (NSString *)changeImageToStirng:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    imageData = [GTMBase64 encodeData:imageData];
    NSString *imageString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    return imageString;
}

- (NSData *)changeImageStrToData:(NSString *)imageStr{
//    NSData *data =    [GTMBase64 decodeString:imageStr];
//    return data;
    NSData *stringData = [imageStr dataUsingEncoding:NSUTF8StringEncoding];
    const void *bytes = [stringData bytes];
    NSData *imagedata = [GTMBase64 decodeBytes:bytes length:[stringData length]];
    return imagedata;
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
