//
//  CCPBGView.m
//  CCPGestureLockView
//
//  Created by CCP on 2017/4/27.
//  Copyright © 2017年 CCP. All rights reserved.
//

#import "CCPBGView.h"
#import "CCPConst.h"

@implementation CCPBGView

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"temp_result"];
    [image drawInRect:rect];
}

@end
