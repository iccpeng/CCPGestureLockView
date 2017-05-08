//
//  CCPCodeViewController.m
//  CCPGestureLockView
//
//  Created by CCP on 2017/4/28.
//  Copyright © 2017年 CCP. All rights reserved.
//

#import "CCPCodeViewController.h"
#import "CCPBGView.h"
#import "CCPGestureLockView.h"

@interface CCPCodeViewController ()

//存储设置密码的次数
@property (nonatomic,assign) NSInteger saveCount;
//记录密码
@property (nonatomic,copy) NSString *codeString;
//存储的密码
@property (nonatomic,copy) NSString *savedString;
@property (nonatomic,weak) CCPGestureLockView *gestureLockView;
@end

static NSString * const saveCodeString = @"saveCodeString";

@implementation CCPCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self addGestureView];
}

- (void) makeUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, (CCPScreenH - CCPScreenW)/2 - 40, CCPScreenW, 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"请绘制您的手势密码";
    [self.view addSubview:label];
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(CCPScreenW/4, CCPScreenH - 120, CCPScreenW / 2, 30)];
    [bottomBtn setBackgroundColor:[UIColor orangeColor]];
    [bottomBtn addTarget:self action:@selector(clickTheBtn) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtn setTitle:@"重置手势密码" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
}

- (void) addGestureView{
    
    CCPGestureLockView *gestureView = [[CCPGestureLockView alloc] init];
    gestureView.frame = CGRectMake(0, (CCPScreenH - CCPScreenW)/2 , CCPScreenW, CCPScreenW);
    gestureView.backgroundColor = [UIColor colorWithRed:252.0/255 green:106.0/225 blue:8.0/255 alpha:0.5];
    gestureView.lineColor = [UIColor colorWithRed:77.0/255 green:153.0/225 blue:248.0/255 alpha:1.0];
    gestureView.lineWidth = 5.0;
    self.gestureLockView = gestureView;
    [self.view addSubview:gestureView];
    
    //如果firstCodeString.length 不为零 说明密码已经设置成功
    self.savedString = (NSString *)USERDEFAULTS(saveCodeString);
    if (self.savedString.length > 0) {
        gestureView.goalString = self.savedString;
    }
    __weak typeof(self) weakSelf = self;
    gestureView.codeStringAndErrorCodeBlock = ^(NSString *codeString, codeStyle ErrorCode) {
        
        if (ErrorCode == unlockSuccess) {//解锁成功
              NSLog(@"解锁成功");
              [weakSelf dismissViewControllerAnimated:YES completion:nil];
            return ;
        }
        
        if (ErrorCode == unlockFailed) {//解锁失败
            
            NSLog(@"解锁失败");
            return;
        }
        
        if (ErrorCode == illegalSetting) { //密码设置不合法
             NSLog(@"密码设置不符合规则");
            return;
        }
        
        if (ErrorCode == codeSetting) {
            NSLog(@"设置密码");
            //根据项目需求就行 密码的设置
            if ([weakSelf.codeString isEqualToString:codeString] || weakSelf.saveCount == 0 ) {
                weakSelf.codeString = codeString;
                weakSelf.saveCount ++;
                NSLog(@"密码设置成功---%zd",self.saveCount);
                if (weakSelf.saveCount == 2) {
                    USERDEFAULTSET(saveCodeString, codeString);
                    USERDEFAULTSYNCHRONIZE;
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    weakSelf.saveCount = 0;
                    weakSelf.codeString = nil;
                }
            } else {
                NSLog(@"与首次设置的密码不一致，请重新设置");
            }
        }
    };
}

- (void) clickTheBtn {
    NSLog(@"---%@",USERDEFAULTS(saveCodeString));
    USERDEFAULTREMOVE(saveCodeString);
    self.saveCount = 0;
    self.codeString = nil;
    self.savedString = nil;
    self.gestureLockView.goalString = nil;
    NSLog(@"+++%@",USERDEFAULTS(saveCodeString));

}

////解锁成功的代理方法
//- (void)gestureLockView:(CCPGestureLockView *)gestureLockView successCodeString:(NSString *)successString {
//
//    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"解锁成功");
//    }];
//}

@end
