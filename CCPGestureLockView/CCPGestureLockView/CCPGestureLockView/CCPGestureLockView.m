//
//  CCPGestureLockView.m
//  CCPGestureLockView
//
//  Created by CCP on 2017/4/27.
//  Copyright © 2017年 CCP. All rights reserved.
//

#import "CCPGestureLockView.h"
#import "CCPConst.h"
#import "CCPBezierPath.h"

@interface CCPGestureLockView ()
//记录手势锁控件的frame
@property (nonatomic,assign) CGRect viewFrame;
//记录手势位置
@property (nonatomic,assign) CGPoint locationPoint;
//选中的按钮数组
@property (nonatomic,strong) NSMutableArray *selectedBtnArray;
//路径
@property (nonatomic,strong) CCPBezierPath *linePath;
//密码
@property (nonatomic,copy) NSMutableString *codeString;
//记录是否密码错误
@property (nonatomic,assign) BOOL isError;
@end


@implementation CCPGestureLockView

- (NSMutableArray *)selectedBtnArray {
    
    if (!_selectedBtnArray) {
        _selectedBtnArray = [NSMutableArray array];
        
    }
    return _selectedBtnArray;
}
- (NSMutableString *)codeString {
    
    if (!_codeString) {
        _codeString = [NSMutableString string];
    }
    return _codeString;
}

- (void)setGoalString:(NSString *)goalString {
    
    _goalString = goalString;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatGestureLockButton];
        [self addPanGesture];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self creatGestureLockButton];
        [self addPanGesture];
    }
    return self;
}

//添加拖拽手势
-(void) addPanGesture {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}
- (void) pan:(UIPanGestureRecognizer *) pan {
    //获取触摸点
    CGPoint locationPoint = [pan locationInView:self];
    self.locationPoint = locationPoint;
    //判断Point 是否在button内
    for (UIButton *button in self.subviews)  {
        if (CGRectContainsPoint(button.frame, locationPoint) && button.selected == NO) {
            button.selected = YES;
            [self.selectedBtnArray addObject:button];
        }
    }
    //重绘
    [self setNeedsDisplay];
    if (pan.state == UIGestureRecognizerStateEnded ) {
        //判断绘制的密码是否符合规则
        if (self.codeString.length >= minNumCode) {
            if (self.goalString.length > 0) {//解锁密码
                if ([self.codeString isEqualToString:self.goalString]) {
                    //解锁成功
                    if (self.codeStringAndErrorCodeBlock) {
                        self.codeStringAndErrorCodeBlock(self.codeString,unlockSuccess);
                    }
                } else {
                    [self codeError];
                    //解锁失败
                    if (self.codeStringAndErrorCodeBlock) {
                        self.codeStringAndErrorCodeBlock(self.codeString,unlockFailed);
                    }
                }
            } else {
                //设置密码
                if (self.codeStringAndErrorCodeBlock) {
                    self.codeStringAndErrorCodeBlock(self.codeString,codeSetting);
                }
            };
            [self redraw];
        } else {
            [self codeError];
            [self redraw];
            //判断错误类型
            codeStyle code = self.goalString.length > 0 ? unlockFailed:illegalSetting;
            if (self.codeStringAndErrorCodeBlock) {
                self.codeStringAndErrorCodeBlock(self.codeString,code);
            }
        }
    }
}

- (void) codeError {
    [self.selectedBtnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        [btn setImage:[UIImage imageNamed:@"gestureError"] forState:UIControlStateSelected];
        self.isError = YES;
        [self setNeedsDisplay];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isError = NO;
            [btn setImage:[UIImage imageNamed:@"gestureHighlighted"] forState:UIControlStateSelected];
        });
    }];
}
//重新绘制
- (void) redraw {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIButton *button in self.selectedBtnArray) {
            button.selected = NO;
        }
        [self.selectedBtnArray removeAllObjects];
        //重绘
        [self setNeedsDisplay];
    });
}

//创建button
- (void) creatGestureLockButton {
    for ( int i = 0; i < buttonCount; i++) {
        UIButton *gestureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [gestureBtn setImage:[UIImage imageNamed:@"gestureNormal"] forState:UIControlStateNormal];
        [gestureBtn setImage:[UIImage imageNamed:@"gestureHighlighted"] forState:UIControlStateHighlighted];
        [gestureBtn setImage:[UIImage imageNamed:@"gestureHighlighted"] forState:UIControlStateSelected];
        [gestureBtn addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
        gestureBtn.tag = i;
        [self addSubview:gestureBtn];
    }
}
//按钮的点击事件
- (void) clickTheButton:(UIButton *)btn {
    if (btn.selected == NO) {
        btn.selected = YES;
        [btn setImage:[UIImage imageNamed:@"gestureError"] forState:UIControlStateSelected];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * 1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            btn.selected = NO;
            [btn setImage:[UIImage imageNamed:@"gestureHighlighted"] forState:UIControlStateSelected];
        });
    }
    //判断错误类型
    codeStyle code = self.goalString.length > 0 ? unlockFailed:illegalSetting;
    if (self.codeStringAndErrorCodeBlock) {
        self.codeStringAndErrorCodeBlock(self.codeString,code);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //获取手势锁控件的frame
    self.viewFrame = self.bounds;
    //计算 button frame
    for (int i = 0; i < self.subviews.count; i ++) {
        
        NSInteger row = i / rowAndColCount;//行数
        NSInteger col = i % rowAndColCount;//列数
        CGFloat centerMargin = (self.viewFrame.size.width - leftMargin -rightMargin - rowAndColCount *imageWidthAndHeight) / (rowAndColCount - 1);//间距
        CGFloat buttonX = leftMargin + (imageWidthAndHeight + centerMargin)*col;
        CGFloat buttonY = topMargin + (imageWidthAndHeight + centerMargin)*row;
        UIButton *button = (UIButton *)self.subviews[i];
        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        button.frame = CGRectMake(buttonX, buttonY, imageWidthAndHeight, imageWidthAndHeight);
        
    }
}

- (void)drawRect:(CGRect)rect {
    
    if (self.selectedBtnArray.count == 0) return;
    self.codeString = nil;
    //把所有的选中按钮之间连线
    self.linePath = [CCPBezierPath bezierPath];
    for (int i = 0; i < self.selectedBtnArray.count; i ++) {
        UIButton *button = (UIButton *)self.selectedBtnArray[i];
        [self.codeString appendString:[NSString stringWithFormat:@"%zd",button.tag]];
        if (i == 0) {
            [self.linePath moveToPoint:button.center];
        } else {
            [self.linePath addLineToPoint:button.center];
        }
    }
    [self.linePath addLineToPoint:self.locationPoint];
    self.linePath.lineWidth = self.lineWidth ? self.lineWidth : 5;
    if (self.isError) {
        self.linePath.lineColor = [UIColor redColor];
    } else {
        self.linePath.lineColor = self.lineColor ? self.lineColor : [UIColor redColor];
    }
    self.linePath.lineCapStyle = kCGLineJoinRound;
    self.linePath.lineJoinStyle = kCGLineJoinRound;
    [self.linePath stroke];
    
}

@end
