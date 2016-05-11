//
//  ZQCuteView.m
//  ZQCuteViewDemo
//
//  Created by zhengzeqin on 15/11/27.
//  Copyright © 2015年 com.injoinow. All rights reserved.
//

#import "ZQCuteView.h"
@interface ZQCuteView ()
// 父视图
@property (strong, nonatomic) UIView *containerView;
// 气泡上显示数字的label
@property (strong, nonatomic) UIImageView *bubbleImage;
//气泡的直径
@property (assign, nonatomic) CGFloat bubbleWidth;
 //气泡粘性系数，越大可以拉得越长
@property (assign, nonatomic) CGFloat viscosity;
//气泡颜色 0x00B9FF
@property (nonatomic, strong) UIColor * bubbleColor;
@property (nonatomic, strong) UIColor * fillColorForCute;

//用户拖走的View
@property (nonatomic, strong) UIView *  frontView;
//原地保留显示的View
@property (nonatomic, strong) UIView *  backView;
@property (nonatomic, assign) CGPoint initialPoint;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIBezierPath *cutePath;
@property (nonatomic, strong) UIImage *pic;
@end
@implementation ZQCuteView
{
    //backView的半径,frontView的半径,backView圆心x,y frontView圆心x,y
    CGFloat r1,r2,x1,y1,x2,y2,centerDistance,cosDigree,sinDigree;
    
    //A,B,B,C,O,P
    CGPoint pointA,pointB,pointD,pointC,pointO,pointP,oldBackViewCenter;
    //
    CGRect oldBackViewFrame;
    
    
}

- (instancetype)initWithPoint:(CGPoint)point superView:(UIView * )superView bubbleWidth:(CGFloat)bubbleWidth pic:(UIImage *)image color:(UIColor *)color{
    if (self = [super initWithFrame:CGRectMake(point.x, point.y, bubbleWidth,bubbleWidth)]) {
        self.viscosity = 12.0;
        self.bubbleWidth = self.frame.size.width;
        self.initialPoint = point;
        self.containerView = superView;
        //RGB(253.0, 53.0, 11.0)
        self.bubbleColor = color;
        [self.containerView addSubview:self];
        self.pic = image;
        [self setup];
        self.zqCuteViewAlpha = 1.0;
    }
    return self;
}

- (void)setZqCuteViewAlpha:(CGFloat)zqCuteViewAlpha{
    _zqCuteViewAlpha = zqCuteViewAlpha;
    self.alpha = zqCuteViewAlpha;
    self.frontView.alpha = zqCuteViewAlpha;
    self.backView.alpha = zqCuteViewAlpha;
    self.bubbleImage.alpha = zqCuteViewAlpha;
}

- (void)setup{
    self.shapeLayer = [CAShapeLayer layer];
    self.backgroundColor = [UIColor clearColor];
    
    self.frontView = [[UIView alloc]initWithFrame:CGRectMake(self.initialPoint.x,self.initialPoint.y, self.bubbleWidth, self.bubbleWidth)];
    r2 = self.frontView.bounds.size.width / 2.0;
    self.frontView.layer.cornerRadius = r2;
    self.frontView.backgroundColor = self.bubbleColor;
    self.backView = [[UIView alloc]initWithFrame:self.frontView.frame];
    r1 = self.backView.frame.size.width / 2.0;
    self.backView.layer.cornerRadius = r1;
    self.backView.backgroundColor = self.bubbleColor;
    
    self.bubbleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frontView.bounds.size.width, self.frontView.bounds.size.height)];
    //add_4_off
    self.bubbleImage.image = self.pic;
    [self.frontView insertSubview:self.bubbleImage atIndex:0];
    
    [self.containerView addSubview:self.backView];
    [self.containerView addSubview:self.frontView];
    //初始化数据
    [self initializeData];
    //为了看到frontView的气泡晃动效果，需要展示隐藏backView
    self.backView.hidden = YES ;
    
    [self addAniamtionLikeGameCenterBubble];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragMe:)];
    [self.frontView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMe:)];
    [self.frontView addGestureRecognizer:tap];
    
    
}

- (void)initializeData{
    
    x1 = self.backView.center.x;
    y1 = self.backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    pointA = CGPointMake(x1-r1,y1);   // A
    pointB = CGPointMake(x1+r1,y1);  // B
    pointD = CGPointMake(x2-r2,y2);  // D
    pointC = CGPointMake(x2+r2,y2);  // C
    pointO = CGPointMake(x1-r1,y1);   // O
    pointP = CGPointMake(x2+r2, y2);  // P
    
    oldBackViewFrame = self.backView.frame;
    oldBackViewCenter = self.backView.center;

}

- (void)dragMe:(UIPanGestureRecognizer *)ges{
    CGPoint dragPoint = [ges locationInView:self.containerView];
    if (ges.state == UIGestureRecognizerStateBegan) {
        self.backView.hidden = NO;
        self.fillColorForCute = self.bubbleColor;
        [self removeAniamtionLikeGameCenterBubble];
    }else if(ges.state == UIGestureRecognizerStateChanged){
        self.frontView.center = dragPoint;
        if (r1 <= 6) {
            self.fillColorForCute = [UIColor clearColor];
            self.backView.hidden = YES;
            [self.shapeLayer removeFromSuperlayer];
        }
    }else if(ges.state == UIGestureRecognizerStateEnded || ges.state == UIGestureRecognizerStateCancelled || ges.state == UIGestureRecognizerStateFailed){
        self.backView.hidden = YES;
        self.fillColorForCute = [UIColor clearColor];
        [self.shapeLayer removeFromSuperlayer];
        
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
            if (self.isOpenStickAnm) {
                oldBackViewCenter = CGPointMake(([UIScreen mainScreen].bounds.size.width) - oldBackViewCenter.x, oldBackViewCenter.y);
                self.frontView.center = oldBackViewCenter;
                [self upDateViewsFrame:self.frontView.frame];
            }else{
                self.frontView.center = oldBackViewCenter;
            }
        } completion:^(BOOL finished) {
            if (finished) {
                [self addAniamtionLikeGameCenterBubble];
            }
        }];
    }
    [self displayLinkAction];
    
}

- (void)tapMe:(UITapGestureRecognizer *)tap{
    if(self.tapCallBack){
        self.tapCallBack();
    }
}

- (void)displayLinkAction{
    x1 = self.backView.center.x;
    y1 = self.backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    centerDistance = sqrtf(((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1)) );
   
    
    if (centerDistance == 0) {
        cosDigree = 1.0;
        sinDigree = 0.0;
        
    }else {
        cosDigree = (y2-y1)/centerDistance;
        sinDigree = (x2-x1)/centerDistance;
    }
    r1 = oldBackViewFrame.size.width / 2.0 - centerDistance/self.viscosity;
    pointA = CGPointMake(x1-r1*cosDigree, y1+r1*sinDigree);  // A
    pointB = CGPointMake(x1+r1*cosDigree, y1-r1*sinDigree); // B
    pointD = CGPointMake(x2-r2*cosDigree, y2+r2*sinDigree); // D
    pointC = CGPointMake(x2+r2*cosDigree, y2-r2*sinDigree);// C
    pointO = CGPointMake(pointA.x + (centerDistance / 2.0)*sinDigree, pointA.y + (centerDistance / 2.0)*cosDigree);
    pointP = CGPointMake(pointB.x + (centerDistance / 2.0)*sinDigree,pointB.y + (centerDistance / 2.0)*cosDigree);
    [self drawRect];

}

- (void)addAniamtionLikeGameCenterBubble{
    if (self.isShowShakeAnmation) {
        [self addPositionAnimation];
    }
    [self addScaleAnimation];
}

- (void)removeAniamtionLikeGameCenterBubble{
    if (self.isShowShakeAnmation) {
        [self removePositionAnimation];
    }
    [self removeScaleAnimation];
}

- (void)addPositionAnimation{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = HUGE_VAL;
    pathAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 5.0;
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer =  CGRectInset(self.frontView.frame, self.frontView.bounds.size.width / 2 - 3, self.frontView.bounds.size.width / 2 - 3);
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    [self.frontView.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
}

- (void)addScaleAnimation{
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.duration = 1;
    scaleX.values = @[@1.0, @1.1, @1.0];
    scaleX.keyTimes = @[@0.0, @0.5, @1.0];
    scaleX.repeatCount = HUGE_VAL;
    scaleX.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = 1.5;
    scaleY.values = @[@1.0, @1.1, @1.0];;
    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
    scaleY.repeatCount = HUGE_VAL;
    scaleY.autoreverses = YES;
    scaleY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleY forKey:@"scaleYAnimation"];

}

- (void)removePositionAnimation{
    [self.frontView.layer removeAnimationForKey:@"myCircleAnimation"];
}

- (void)removeScaleAnimation{
    [self.frontView.layer removeAnimationForKey:@"scaleXAnimation"];
    [self.frontView.layer removeAnimationForKey:@"scaleYAnimation"];
}


- (void)drawRect{
    self.backView.center = oldBackViewCenter;
    self.backView.bounds = CGRectMake(0, 0, r1*2, r1*2);
    self.backView.layer.cornerRadius = r1;
    

    self.cutePath = [UIBezierPath bezierPath];
    [self.cutePath moveToPoint:pointA];
    [self.cutePath addQuadCurveToPoint:pointD controlPoint:pointO];
    [self.cutePath addLineToPoint:pointC];
    [self.cutePath addQuadCurveToPoint:pointB controlPoint:pointP];
    [self.cutePath moveToPoint:pointA];
    
    if (self.backView.hidden == NO) {
        self.shapeLayer.path = self.cutePath.CGPath;
        self.shapeLayer.fillColor = self.fillColorForCute.CGColor;
        [self.containerView.layer insertSublayer:self.shapeLayer below:self.frontView.layer];
    }
}

- (void)hideCuteView:(BOOL)isHide{
    if (isHide) {
        self.frontView.hidden = YES;
        self.hidden = YES;
    }else {
        self.frontView.hidden = NO;
        self.hidden = NO;
    }
}

- (void)upDateViewsFrame:(CGRect)frame{
    self.frame = frame;
    self.initialPoint = frame.origin;
    self.frontView.frame = frame;
    self.backView.frame = frame;
    [self.containerView bringSubviewToFront:self];
    [self.containerView bringSubviewToFront:self.backView];
    [self.containerView bringSubviewToFront:self.frontView];
    [self initializeData];
}


@end
