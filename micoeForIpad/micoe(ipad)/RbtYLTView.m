//
//  RbtYLTView.m
//  RedBudTek
//
//  Created by Simon on 13-12-14.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtYLTView.h"
#import "RbtDataOfResponse.h"

@implementation RbtYLTView

-(NSString *)statusBysName:(NSString *)sName
{
    NSDictionary *yltDic = [[RbtDataOfResponse sharedInstance].yuanlituDic objectForKey:@"d"];
    NSString *s;
    for (NSDictionary *temDic in yltDic) {
        if ([[temDic objectForKey:@"n"] isEqualToString:sName]) {
            s = [temDic objectForKey:@"s"];
            if ([s isEqualToString:@"w"]) {
                return @"on";
            }
            if ([s isEqualToString:@"p"]) {
                return @"off";
            }
            if ([s isEqualToString:@"f"]) {
                return @"alarm";
            }
            return @"off";
        }
    }
    return @"on";
}


@end
