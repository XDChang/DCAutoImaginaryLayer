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
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor yellowColor];
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.path = _path.CGPath;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth = 30.0f;
        _shapeLayer.strokeColor = [UIColor colorWithRed:141/255.0 green:175/255.0 blue:40/255.0 alpha:1].CGColor;
        //每个虚线宽度为2，间隔为3
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
        angle =  a;
    }
    if (x < 0 && y > 0) {
        angle = a;
    }
    // ========== 4个象限角度的处理 end =============//
    _path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:90 startAngle:-M_PI endAngle:angle clockwise:1];
    _shapeLayer.path = _path.CGPath;
}
@end
