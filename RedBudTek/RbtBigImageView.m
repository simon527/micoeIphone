//
//  RbtBigImageView.m
//  RedBudTek
//
//  Created by Simon on 13-11-12.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//

#import "RbtBigImageView.h"

@implementation RbtBigImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 114, 114)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
