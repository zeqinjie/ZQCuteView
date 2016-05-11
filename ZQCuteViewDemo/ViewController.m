//
//  ViewController.m
//  ZQCuteViewDemo
//
//  Created by zhengzeqin on 16/1/22.
//  Copyright © 2016年 com.injoinow. All rights reserved.
//

#import "ViewController.h"
#import "ZQCuteView.h"
@interface ViewController ()
@property (nonatomic, strong) ZQCuteView *zqCuteView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView{
    self.zqCuteView = [[ZQCuteView alloc]initWithPoint: CGPointMake(self.view.frame.size.width - 70, self.view.frame.size.height - 70) superView:self.view bubbleWidth:55 pic:[UIImage imageNamed:@"icon_Close_off_110"]color:[UIColor yellowColor]];
    [self.zqCuteView setZqCuteViewAlpha:0.9];
    self.zqCuteView.isOpenStickAnm = YES;
    self.zqCuteView.isShowShakeAnmation = YES;
    self.zqCuteView.tapCallBack = ^(void){
        NSLog(@"hello zzq");
    };
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
