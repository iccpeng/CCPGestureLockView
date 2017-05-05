//
//  CCPBezierPath.m
//  CCPGestureLockView
//
//  Created by CCP on 2017/4/28.
//  Copyright © 2017年 CCP. All rights reserved.
//

#import "CCPBezierPath.h"

@implementation CCPBezierPath

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [lineColor set];
}
- (void)setLineW:(CGFloat)lineW {
    _lineW = lineW;
    self.lineWidth = lineW;
}
@end
