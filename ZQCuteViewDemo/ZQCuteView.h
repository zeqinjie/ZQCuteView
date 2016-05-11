//
//  ZQCuteView.h
//  ZQCuteViewDemo
//
//  Created by zhengzeqin on 15/11/27.
//  Copyright © 2015年 com.injoinow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQCuteView : UIView
//点击事件
@property (nonatomic, copy) void (^tapCallBack)();
/**
 *  初始化界面
 */
- (instancetype)initWithPoint:(CGPoint)point superView:(UIView * )superView bubbleWidth:(CGFloat)bubbleWidth pic:(UIImage *)image color:(UIColor *)color;
/**
 *  隐藏界面
 */
- (void)hideCuteView:(BOOL)isHide;
/**
 *  更新位置
 */
- (void)upDateViewsFrame:(CGRect)frame;
/**
 *  透明度
 */
@property (nonatomic, assign) CGFloat zqCuteViewAlpha;
/**
 *  是否开启黏脚边
 */
@property (nonatomic, assign) BOOL isOpenStickAnm;

/**
 *  是否开启显示抖动动画
 */
@property (nonatomic, assign) BOOL isShowShakeAnmation;
@end
