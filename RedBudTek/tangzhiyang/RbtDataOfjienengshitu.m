//
//  RbtDataOfjienengshitu.m
//  RedBudTek
//
//  Created by Simon on 13-11-29.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtDataOfjienengshitu.h"

@implementation RbtDataOfjienengshitu

@synthesize sc, sco, sp;

+ (RbtDataOfjienengshitu *)sharedInstance{
    static RbtDataOfjienengshitu* sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(
                  &onceToken, ^{
                      sharedInstance = [[RbtDataOfjienengshitu alloc] init];
                  });
    return sharedInstance;
}

@end
