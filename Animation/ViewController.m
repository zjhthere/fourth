//
//  ViewController.m
//  Animation
//
//  Created by zhaojiahang on 2018/1/18.
//  Copyright © 2018年 zhaojiahang. All rights reserved.
//
//
//  ViewController.m
//  Animation
//
//  Created by zhaojiahang on 2018/1/18.
//  Copyright © 2018年 zhaojiahang. All rights reserved.
////
//  ViewController.m
//  Animation
//
//  Created by zhaojiahang on 2018/1/18.
//  Copyright © 2018年 zhaojiahang. All rights reserved.
////
//  ViewController.m
//  Animation
//
//  Created by zhaojiahang on 2018/1/18.
//  Copyright © 2018年 zhaojiahang. All rights reserved.
////
//  ViewController.m
//  Animation
//
//  Created by zhaojiahang on 2018/1/18.
//  Copyright © 2018年 zhaojiahang. All rights reserved.
//
#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
@interface ViewController ()
@property (nonatomic, strong) UIImageView *v1;
@property (nonatomic, strong) UIImageView *v2;
@property (nonatomic, strong) CALayer *frontLayer;
@property (nonatomic, strong) CALayer *backLayer;
@property (nonatomic, assign) CGPoint start;
@property (nonatomic, assign) CGRect frame1;
@property (nonatomic, assign) CGRect frame2;
@property (nonatomic, assign) CGFloat angle1;
@property (nonatomic, assign) CGFloat angle2;
@property (nonatomic, strong) UIImageView * frontView;
@property (nonatomic, strong) UIImageView * backView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _v1 = [[UIImageView alloc] initWithFrame:CGRectMake(37.5, 150, 300, 200)];
    _v1.image = [UIImage imageNamed:@"a1.jpg"];
    _v2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 160, 335, 180)];
    _v2.image = [UIImage imageNamed:@"a2.jpg"];
    [self.view addSubview:_v1];
    [self.view addSubview:_v2];
//    _logoLayer = _v1.layer;
    _backLayer = _v2.layer;
    _frame1 = _v1.frame;
    _frame2 = _v2.frame;
    _angle1 = 0.0;
    _angle2 = 0.0;
    _frontView = _v2;
    _backView = _v1;
    _frontLayer = _frontView.layer;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%f %f", _start.x,_start.y);
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self.view];
    CGPoint previous = [touch previousLocationInView:self.view];
    
    CGPoint offSet = CGPointMake(current.x - previous.x, 0);
    
    CGPoint center = _frontView.center;
    CGPoint center2 = _backView.center;
    
    _frontView.center = CGPointMake(center.x + offSet.x, center.y + offSet.y);
    
    _backView.center = CGPointMake(center2.x + -offSet.x, center2.y + -offSet.y);
    
    
    CGFloat x = current.x - _start.x;
    CGFloat angle = x / (self.view.frame.size.width/2.0);

    if (angle > 0.7) {
        angle = 0.7;
    }
    if (angle < -0.7) {
        angle = -0.7;
    }
    _angle1 = angle;
    NSLog(@"%f", angle);
    _frontLayer.transform = [self get3DWithAngle:-angle];
//    _backLayer.transform = [self get3DWithAngle:angle];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    _start = [t locationInView:self.view];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.3 animations:^{
        if (_angle1 >= 0.5 || _angle1 <= -0.5) {
            if (_frontView == _v1) {
                _v1.frame = _frame1;
                _v2.frame = _frame2;
                _frontView = _v2;
                _backView = _v1;
                _frontLayer = _frontView.layer;
                _backLayer = _v1.layer;
                
                _frontLayer.zPosition = 100;
                _backLayer.zPosition = 50;
            }else {
                _v1.frame = _frame2;
                _v2.frame = _frame1;
                _frontView = _v1;
                _backView = _v2;
                _frontLayer = _frontView.layer;
                _backLayer = _v2.layer;
                _frontLayer.zPosition = 100;
                _backLayer.zPosition = 50;
            }
        }

        [self.view bringSubviewToFront:_frontView];
        _v1.layer.transform = [self get3DWithAngle:0];
        _v2.layer.transform = [self get3DWithAngle:0];
        self.v1.center = CGPointMake(187.5, 250);
        self.v2.center = CGPointMake(187.5, 250);
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)rotation {
    //旋转动画
    CABasicAnimation* rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI_4];
    // 3 is the number of 360 degree rotations
    // Make the rotation animation duration slightly less than the other animations to give it the feel
    // that it pauses at its largest scale value
    rotationAnimation.duration = 2.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; //缓入缓出
//    _logoLayer.position = CGPointMake(20, 50);
//    _logoLayer.anchorPoint = CGPointMake(0, 0);
//    [_logoLayer addAnimation:rotationAnimation forKey:@"r1"];
    
//    CATransition *ani = [CATransition animation];
//    ani.type = @"cube";
//    ani.subtype = @"cube";
//    ani.duration = 2.0f;
//    [_logoLayer addAnimation:ani forKey:@"ani"];
    
    //缩放动画
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
//    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = 2.0f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    /*
     kCAMediaTimingFunctionLinear
     kCAMediaTimingFunctionEaseIn
     kCAMediaTimingFunctionEaseOut
     kCAMediaTimingFunctionEaseInEaseOut
kCAMediaTimingFunctionDefault
    */
//
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2.0f;
    animationGroup.autoreverses = NO;   //是否重播，原动画的倒播
    animationGroup.repeatCount = 0;//HUGE_VALF;     //HUGE_VALF,源自math.h
    [animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];
    //将上述两个动画编组
//    [_logoLayer addAnimation:animationGroup forKey:@"animationGroup"];
}
- (void)ddd {
    CATransform3D move = CATransform3DMakeTranslation(0, 0, _v1.bounds.size.width/2);
    CATransform3D rotate = CATransform3DMakeRotation(0.5, 0, 1, 0);
    
}
- (CATransform3D)get3DWithAngle:(CGFloat)angle {
    CATransform3D tr = CATransform3DIdentity;
    tr.m34 = 4.5/-2000;
    tr = CATransform3DRotate(tr, angle, 0, 1, 0);
    return tr;
}
- (void)bounds {
    
    //本次偏移角度
//      CGFloat deltaAngle=currentOffset/self.view.bounds.size.width * M_PI_2;
//****************当前视图移动变幻***************
//设置锚点
//      currentView.layer.anchorPoint=CGPointMake(0.5, 0.5);
//向屏幕前方移动
    CATransform3D move = CATransform3DMakeTranslation(0, 0, self.view.bounds.size.width/2);//旋转
    CATransform3D rotate = CATransform3DMakeRotation(0.1, 0, 1, 0);
    //平移
CATransform3D plaintMove=CATransform3DMakeTranslation( 0.1, 0, 0);
//向屏幕后方移动
CATransform3D back = CATransform3DMakeTranslation(0, 0, -self.view.bounds.size.width/2);

//连接
//CATransform3D concat=CATransform3DConcat( CATransform3DConcat(move, CATransform3DConcat(rotate, plaintMove)),back);
//CATransform3D transform = CATransform3DPerspect(concat, CGPointMake(0.1/2, self.view.bounds.size.height), 5000.0f);//添加变幻特效
//    _logoLayer.transform=transform;
////****************下一个视图移动变幻***************
////设置锚点
//nextView.layer.anchorPoint=CGPointMake(0.5, 0.5);
////向屏幕前方移动
//CATransform3D move2 = CATransform3DMakeTranslation(0, 0, self.view.bounds.size.width/2);
////旋转
//CATransform3D rotate2 = CATransform3DMakeRotation(-deltaAngle+M_PI_2, 0, 1, 0);
////平移
//    CATransform3D plaintMove2=CATransform3DMakeTranslation( currentOffset-self.view.bounds.size.width, 0, 0);
////向屏幕后方移动
//CATransform3D back2 = CATransform3DMakeTranslation(0, 0, -self.view.bounds.size.width/2);
//
////拼接
//CATransform3D concat2=CATransform3DConcat( CATransform3DConcat(move2, CATransform3DConcat(rotate2, plaintMove2)),back2);
//CATransform3D transform2=CATransform3DPerspect(concat2, CGPointMake(self.view.bounds.size.width/2+currentOffset/2, self.view.bounds.size.height), 5000.0f);
////添加变幻特效
//nextView.layer.transform=transform2;
////****************上一个视图移动变幻***************
////设置锚点
//lastView.layer.anchorPoint=CGPointMake(0.5, 0.5);
////向屏幕前方移动
//CATransform3D move3 = CATransform3DMakeTranslation(0, 0, self.view.bounds.size.width/2);
////旋转
//CATransform3D rotate3 = CATransform3DMakeRotation(-deltaAngle-M_PI_2, 0, 1, 0);
////平移
//    CATransform3D plaintMove3=CATransform3DMakeTranslation( currentOffset+self.view.bounds.size.width, 0, 0);
//     //向屏幕后方移动
//    CATransform3D back3 = CATransform3DMakeTranslation(0, 0, -self.view.bounds.size.width/2);
//
//      //拼接
//      CATransform3D concat3=CATransform3DConcat(CATransform3DConcat(move3, CATransform3DConcat(rotate3, plaintMove3)),back3);
//
//      CATransform3D transform3=CATransform3DPerspect(concat3, CGPointMake(-self.view.bounds.size.width/2+currentOffset/2, self.view.bounds.size.height), 5000.0f);
//
//      //添加变幻特效
//    lastView.layer.transform=transform3;
    
    //界限
//    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    boundsAnimation.fromValue = [NSValue valueWithCGRect: _logoLayer.bounds];
//    boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectZero];
}
- (void)alphaa {
    //透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.5];
}
- (void)position {
    //位置移动
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation.fromValue =  [NSValue valueWithCGPoint: _logoLayer.position];
//    CGPoint toPoint = _logoLayer.position;
//    toPoint.x += 180;
//    animation.toValue = [NSValue valueWithCGPoint:toPoint];
}

- (void)removeAnimation {
    //去掉所有动画
//    [_logoLayer removeAllAnimations];
//    //去掉key动画
//    [_logoLayer removeAnimationForKey:@"animationGroup"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
