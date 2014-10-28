//
//  RbtCustomTabbarController.h
//  RedBudTek
//
//  Created by Simon on 13-11-18.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RbtCustomTabbarController : UIViewController
{
    int showViewTag;
}

@property (strong, nonatomic) NSMutableArray *controllersArray;

@property (strong, nonatomic) NSMutableArray *imagesArray;

@property (strong, nonatomic) NSMutableArray *tabBarButtonsArray;


@end
