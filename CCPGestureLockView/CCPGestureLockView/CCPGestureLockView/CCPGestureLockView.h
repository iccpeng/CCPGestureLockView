//
//  CCPGestureLockView.h
//  CCPGestureLockView
//
//  Created by CCP on 2017/4/27.
//  Copyright © 2017年 CCP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCPGestureLockView;

@protocol CCPGestureLockViewDelegate <NSObject>

@required
//比对成功后的回调
- (void)gestureLockView:(CCPGestureLockView *)gestureLockView successCodeString:(NSString *)successString;
@end

@interface CCPGestureLockView : UIView
//划线的宽度
@property (nonatomic,assign) CGFloat lineWidth;
//划线的颜色
@property (nonatomic,strong) UIColor *lineColor;
//需要匹配的密码字符串
@property (nonatomic,copy) NSString *goalString;
//获取手势密码
@property (nonatomic, copy)void (^getCodeStringBlock)(NSString *codeString);
//代理
@property (nonatomic, weak) id <CCPGestureLockViewDelegate> delegate;
@end
