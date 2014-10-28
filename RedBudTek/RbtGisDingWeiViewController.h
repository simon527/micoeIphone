//
//  RbtGisDingWeiViewController.h
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBaseViewController.h"
#import <MapKit/MapKit.h>

@interface RbtGisDingWeiViewController : RbtBaseViewController<MKMapViewDelegate>

@property (nonatomic,strong)MKMapView *myMapView;

@end
