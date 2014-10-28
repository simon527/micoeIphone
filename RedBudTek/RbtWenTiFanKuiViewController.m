//
//  RbtWenTiFanKuiViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtWenTiFanKuiViewController.h"
#import "RbtWenTiFanKuiListViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "GTMBase64.h"
#import "RbtWenTiModel.h"

@interface RbtWenTiFanKuiViewController ()<UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation RbtWenTiFanKuiViewController

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
    self.title = @"问题反馈";
    
    UIImage *bigbg = [UIImage imageNamed:@"wtfk_bigbg"];
    UIImageView *bigbgview = [[UIImageView alloc] initWithImage:bigbg];
    bigbgview.frame = CGRectMake(6, 153, 307, ScreenHeight-120);
    [self.view addSubview:bigbgview];
    
    if ([[RbtUserModel sharedInstance].wtfk isEqualToString:@"n"]) {
        
    }
    else{
        UIImage *cellImagebg = [UIImage imageNamed:@"wtfk_cellbg"];
        UIImageView *cellImagebgView = [[UIImageView alloc] initWithImage:cellImagebg];
        cellImagebgView.frame = CGRectMake(6, 69, 307, 40);
        [self.view addSubview:cellImagebgView];

        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 100, 60)];
        [lab1 setFont:[UIFont fontWithName:kFontName size:15]];
        lab1.text = @"问题反馈列表";
        [self.view addSubview:lab1];

        UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(180, 60, 100, 60)];
        [userName setFont:[UIFont fontWithName:kFontName size:15]];
        userName.textAlignment = NSTextAlignmentRight;
        userName.text = [RbtUserModel sharedInstance].userName;
        [self.view addSubview:userName];

        UIButton *cellaccBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cellaccBtn setBackgroundImage:[UIImage imageNamed:@"wtfk_cellaccbtn"] forState:UIControlStateNormal];
        cellaccBtn.frame = CGRectMake(280, 75, 30, 30);
        [cellaccBtn addTarget:self action:@selector(cellaccBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cellaccBtn];
    }
    
    UIImage *cellImagebg2 = [UIImage imageNamed:@"wtfk_cellbg"];
    UIImageView *cellImagebgView2 = [[UIImageView alloc] initWithImage:cellImagebg2];
    cellImagebgView2.frame = CGRectMake(6, 114, 307, 40);
    [self.view addSubview:cellImagebgView2];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 105, 100, 60)];
    [lab2 setFont:[UIFont fontWithName:kFontName size:15]];
    lab2.text = @"输入问题描述";
    [self.view addSubview:lab2];
    
    UIButton *uploadImagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadImagebtn setBackgroundImage:[UIImage imageNamed:@"wtfk_uploadImagebtn"] forState:UIControlStateNormal];
    uploadImagebtn.frame = CGRectMake(270, 115, 35, 35);
    [uploadImagebtn addTarget:self action:@selector(uploadimageBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadImagebtn];
    
    
    UIButton *uploadbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadbtn setBackgroundImage:[UIImage imageNamed:@"wtfk_upload"] forState:UIControlStateNormal];
    uploadbtn.frame = CGRectMake(27, ScreenHeight-110, 267, 40);
    [uploadbtn addTarget:self action:@selector(uploadbtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadbtn];
    
    self.textF_wenti = [[UITextView alloc] initWithFrame:CGRectMake(6, 150, 307, ScreenHeight-216-20-150) textContainer:nil];
    self.textF_wenti.delegate = self;
    self.textF_wenti.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0  blue:250.0/255.0  alpha:1];
    [self.view addSubview:self.textF_wenti];
    
    
    if ([[RbtUserModel sharedInstance].wtfk isEqualToString:@"n"]) {
        cellImagebgView2.frame = CGRectMake(6, 114-45, 307, 40);
        lab2.frame = CGRectMake(10, 105-45, 100, 60);
        uploadImagebtn.frame = CGRectMake(270, 115-45, 35, 35);
        self.textF_wenti.frame = CGRectMake(6, 150-45, 307, ScreenHeight-216-20-150+45);
    }
    
    
//    [self.view addSubview:self.hud1];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- actions
- (void)uploadbtnPressed{
    [self.hud1 show:YES];
    RbtWebManager *geDiGongCengWebManager = [RbtWebManager getRbtManager:YES];
    geDiGongCengWebManager.name =@"uploadwtfkweb";
    geDiGongCengWebManager.delegate = self;
    if (!self.i) {
        self.i = @"";
    }
    
    [geDiGongCengWebManager commitquestion:[RbtUserModel sharedInstance].userName withP:[RbtProjectModel sharedInstance].projectid WithQ:self.textF_wenti.text AndI:self.i];
}

- (void)uploadimageBtnPressed{
    if ([self isPhotoLibraryAvailable]){
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        if ([self canUserPickPhotosFromPhotoLibrary]){
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage]; }
        if ([self canUserPickVideosFromPhotoLibrary]){
            [mediaTypes addObject:(__bridge NSString *)kUTTypeMovie];
        }
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        UIViewController *vc = [self viewController];
        [vc.navigationController presentViewController:controller animated:YES completion:nil];
        }
}


- (void)cellaccBtnPressed{
    [self.hud1 show:YES];
    RbtWebManager *geDiGongCengWebManager = [RbtWebManager getRbtManager:YES];
    geDiGongCengWebManager.name =@"wtfklistweb";
    geDiGongCengWebManager.delegate = self;
    [geDiGongCengWebManager getquestionWith:[RbtUserModel sharedInstance].userName];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark- request delegate
- (void)onDataLoadWithService:(RbtWebManager *)webService
                  andResponse:(NSDictionary *)responseDic
{
    [super onDataLoadWithService:webService andResponse:responseDic];
    if ([webService.name isEqualToString:@"uploadwtfkweb"]) {
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
             [RbtCommonTool showInfoAlert:@"上传问题成功"];
        }
        else{
            [RbtCommonTool showInfoAlert:[NSString stringWithFormat:@"%@",[responseDic objectForKey:@"rd"]]];
        }
    }
    else if([webService.name isEqualToString:@"wtfklistweb"]) {
        if ([[responseDic objectForKey:@"rc"] isEqualToString:@"1"]) {
            NSArray *arr = [responseDic objectForKey:@"rt"];
            NSMutableArray *arrList = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in arr) {
                RbtWenTiModel *oneModel = [[RbtWenTiModel alloc] init];
                oneModel.n =  [dic objectForKey:@"n"];
                oneModel.q =  [dic objectForKey:@"q"];
                oneModel.i =  [dic objectForKey:@"i"];
                oneModel.t =  [dic objectForKey:@"t"];
                oneModel.r =  [dic objectForKey:@"r"];
                oneModel.p =  [dic objectForKey:@"p"];
                oneModel.m =  [dic objectForKey:@"m"];
                [arrList addObject:oneModel];
            }
            RbtWenTiFanKuiListViewController *wtfk_listView = [[RbtWenTiFanKuiListViewController alloc] init];
            wtfk_listView.arr_wenTiList = arrList;
            [[self viewController].navigationController pushViewController:wtfk_listView animated:YES];
        }
        else{
            [RbtCommonTool showInfoAlert:[NSString stringWithFormat:@"%@",[responseDic objectForKey:@"rd"]]];
        }
    }
}

#pragma mark- PhotoLibrary

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType
                  sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    
    __block BOOL result = NO;
    
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    
    NSArray *availableMediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    
    [availableMediaTypes enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop) {
         
         NSString *mediaType = (NSString *)obj;
         if ([mediaType isEqualToString:paramMediaType]){
             result = YES;
             *stop= YES;
         }
         
     }];
    return result;
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (image.size.width>320) {
        float beiShu = image.size.width/320;
        CGSize newSize = CGSizeMake(320, image.size.height/beiShu);
        image = [RbtWenTiFanKuiViewController imageWithImageSimple:image scaledToSize:newSize];
    }
    
    NSString *imageString = [self changeImageToStirng:image];
    self.i = imageString;
    UIViewController *vc = [self viewController];
    [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
//    NSData *data =  [self changeImageStrToData:imageString];
//    UIImage *imagef = [UIImage imageWithData:data];
//    UIImageView *imagv = [[UIImageView alloc] initWithImage:imagef];
//    imagv.frame = CGRectMake(50, 100, 100, 100);
//    [self.view addSubview:imagv];
}

- (NSString *)changeImageToStirng:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    imageData = [GTMBase64 encodeData:imageData];
    NSString *imageString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    return imageString;
}

- (NSData *)changeImageStrToData:(NSString *)imageStr{
    NSData *stringData = [imageStr dataUsingEncoding:NSUTF8StringEncoding];
    const void *bytes = [stringData bytes];
    NSData *imagedata = [GTMBase64 decodeBytes:bytes length:[stringData length]];
    return imagedata;
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
