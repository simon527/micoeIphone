//
//  micShiShiShuJuView.h
//  micoe(ipad)
//
//  Created by Simon on 14-1-17.
//  Copyright (c) 2014年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface micShiShiShuJuView : UIView<UIScrollViewDelegate>
{
    UIScrollView *sc;
    
    NSString *yltName;
    
    NSDictionary *dataDic;
    
    NSMutableArray *W_SArray;
    
    NSMutableArray *T_JArray;
    
    NSMutableArray *T_SArray;
    
    NSMutableArray *T_UArray;
    
    NSMutableArray *T_AArray;
    
    NSMutableArray *T_GArray;
    
    NSMutableArray *E_EArray;
    
    NSMutableArray *P_PArray;
    
    NSMutableArray *EH_EHArray;
    
    NSMutableArray *DDF_EArray;
    
    NSMutableArray *T_HArray;
    
    float imageX;
    float imageY;
    
    int imageIndex;
    
    int gap1;
    
    int gap2;
    
    float imageWidth;
    
    float imageHeight;
    float suofangbi;
    
//    NSTimer *timer;
}

@property (strong, nonatomic) NSTimer *timer;

@end
