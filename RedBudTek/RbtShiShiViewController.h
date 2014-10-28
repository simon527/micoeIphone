//
//  RbtShiShiViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"
#import "RbtTabViewController.h"

@interface RbtShiShiViewController : RbtTabViewController<UIScrollViewDelegate>
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
}

@end
