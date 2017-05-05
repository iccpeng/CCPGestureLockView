//
//  ViewController.m
//  CCPGestureLockView
//
//  Created by CCP on 2017/4/27.
//  Copyright © 2017年 CCP. All rights reserved.
//

#import "ViewController.h"
#import "CCPCodeViewController.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
//设置密码
- (IBAction)goSetCode:(UIButton *)sender {
    CCPCodeViewController *codeVC = [[CCPCodeViewController alloc] init];
    
    [self presentViewController:codeVC animated:YES completion:nil];
}

@end
