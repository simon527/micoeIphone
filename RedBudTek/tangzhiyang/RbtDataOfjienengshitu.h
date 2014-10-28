//
//  RbtDataOfjienengshitu.h
//  RedBudTek
//
//  Created by Simon on 13-11-29.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RbtDataOfjienengshitu : NSObject

@property (strong, nonatomic) NSString *sp;

@property (strong, nonatomic) NSString *sc;

@property (strong, nonatomic) NSString *sco;

+ (RbtDataOfjienengshitu *)sharedInstance;


@end
