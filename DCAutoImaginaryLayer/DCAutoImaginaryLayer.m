//
//  DCAutoImaginaryLayer.m
//  DCAutoImaginaryLayer
//
//  Created by 徐德昌 on 2017/12/31.
//  Copyright © 2017年 徐德昌. All rights reserved.
//

#import "DCAutoImaginaryLayer.h"

@implementation DCAutoImaginaryLayer{
    CGFloat _startAngle;
    CGFloat _endAngle;
    CGPoint _startPoint;
    CGPoint _endPoint;
    UIBezierPath *_path;
    CAShapeLayer *_shapeLayer;
    UIView *_redView;
    BOOL _canMove;
    CGFloat _lastX;
    UIImageView *_img;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _canMove = NO;
        self.backgroundColor = [UIColor yellowColor];
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.path = _path.CGPath;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        
        _shapeLayer.strokeColor = [UIColor colorWithRed:119/255.0 green:213/255.0 blue:114/255.0 alpha:1].CGColor;
        //每个虚线宽度为2，间隔为3 整个线条宽度为30
        _shapeLayer.lineWidth = 30.0f;
        _shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:4], [NSNumber numberWithInt:3], nil];
        [self.layer addSublayer:_shapeLayer];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2 - 90, frame.size.height/2 - 90, 180, 180)];
        imageView.image = [UIImage imageNamed:@"volume_text_area"];//volume_text_area
        imageView.layer.cornerRadius = 90;
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView];
        // 根据图片layer进行裁剪
        CALayer *maskLayer = [CALayer layer];
        maskLayer.frame = CGRectMake(frame.size.width/2 - 97, frame.size.height/2 - 97, 194, 194);
        UIImage *maskImage = [UIImage imageNamed:@"volume_area"];
        maskLayer.contents = (__bridge id)maskImage.CGImage;
        self.layer.mask = maskLayer;
        
        UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2 - 80, frame.size.height/2 - 80, 160, 160)];
        redView.backgroundColor = [UIColor clearColor];
        [self addSubview:redView];
        _redView = redView;
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 68, 24, 24)];
        img.image = [UIImage imageNamed:@"button"];
        [_redView addSubview:img];
        _img = img;
        
        _redView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        CATransform3D rotatedTransform = _redView.layer.transform;
        rotatedTransform = CATransform3DMakeRotation(2.15-M_PI, 0, 0, 1.0);//rotate为旋转弧度，绕Z轴转
        _redView.layer.transform = rotatedTransform;
        
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    //    _shapeLayer = [CAShapeLayer layer];
    //    _shapeLayer.frame = self.bounds;
    ////    _path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.height/2 startAngle:-M_PI_2 endAngle:M_PI*3/2 clockwise:1];
    //    _shapeLayer.path = _path.CGPath;
    //    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    //    _shapeLayer.lineWidth = 30.0f;
    //
    //    if ([self.flag isEqualToString:@"track"]) {
    //        _shapeLayer.strokeColor = [UIColor colorWithRed:146/255.0f green:146/255.0f blue:146/255.0f alpha:1].CGColor;
    //    } else{
    //        _shapeLayer.strokeColor = [UIColor colorWithRed:61/255.0f green:191/255.0f blue:135/255.0f alpha:1].CGColor;
    //    }
    //
    //    //每个虚线宽度为2，间隔为3
    //    _shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:4], [NSNumber numberWithInt:3], nil];
    //
    //    [self.layer addSublayer:_shapeLayer];
    
    //    if ([self.flag isEqualToString:@"process"]) {
    //        CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //        pathAnima.duration = self.time;
    //        pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //        pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    //        pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    //        pathAnima.fillMode = kCAFillModeForwards;
    //        pathAnima.removedOnCompletion = NO;
    //        [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    //    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    touchPoint = [_img.layer convertPoint:touchPoint fromLayer:self.layer];
    NSLog(@"touchPoint==%.f",touchPoint.x);
    if ([_img.layer containsPoint:touchPoint]) {
        _canMove = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    _endPoint = touchPoint;
    
    float x = _endPoint.y - self.frame.size.height/2;
    float y = _endPoint.x - self.frame.size.width/2;
    float a = atanf(x/y);
    float angle = 0.0;
    // ========== 4个象限角度的处理 start =============//
    if (x <0 && y < 0) {
        angle = a-M_PI;
    }
    if (x > 0 && y < 0) {
        angle = M_PI + a;
    }
    if (x > 0 && y > 0) {
        angle = a;
    }
    if (x < 0 && y > 0) {
        angle = a;
    }
    // ========== 4个象限角度的处理 end =============//
    
    
    NSLog(@"sss%.2f",M_PI - angle);
    
    // ================= 以下是新增的 view 旋转 =================//
    /*
     范围在 -3.14 ~~~~~~~ 3.14 (M_PI - angle 得到 2π~0 区间范围)
     在 0.72 ~~~~ 2 不旋转 范围自定义
     
     
     
     */
    
    
    if (0.72 < angle && angle < 2) {
        _canMove = NO;
    }
    
    if (_canMove) {
        
        _path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:90 startAngle:2 endAngle:angle clockwise:1];
        _shapeLayer.path = _path.CGPath;
        
        _redView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        CATransform3D rotatedTransform = _redView.layer.transform;
        rotatedTransform = CATransform3DMakeRotation(angle-M_PI, 0, 0, 1.0);//rotate为旋转弧度，绕Z轴转
        _redView.layer.transform = rotatedTransform;
    }
    
    
    
    // ================= view 旋转 end ======================== //
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    CGAffineTransform _trans = _redView.transform;
    CGFloat rotate = acosf(_trans.a);
    NSLog(@"%.2f",rotate);
    NSString *str = [NSString stringWithFormat:@"%.f",rotate];
    if ([str isEqualToString:@"2"]) {
        _redView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        CATransform3D rotatedTransform = _redView.layer.transform;
        rotatedTransform = CATransform3DMakeRotation(0.70-M_PI, 0, 0, 1.0);//rotate为旋转弧度，绕Z轴转
        _redView.layer.transform = rotatedTransform;
        
    }
    if ([str isEqualToString:@"1"]) {
        _redView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        CATransform3D rotatedTransform = _redView.layer.transform;
        rotatedTransform = CATransform3DMakeRotation(2.15-M_PI, 0, 0, 1.0);//rotate为旋转弧度，绕Z轴转
        _redView.layer.transform = rotatedTransform;
        
    }
    
    
}
@end

