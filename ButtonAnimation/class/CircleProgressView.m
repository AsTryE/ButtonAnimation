//
//  CircleProgressView.m
//  ButtonAnimation
//
//  Created by GXY on 16/5/27.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "CircleProgressView.h"

@implementation CircleProgressView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.circleProgressLayer = [CircleProgressLayer layer];
        self.circleProgressLayer.frame = self.bounds;
        self.circleProgressLayer.contentsScale = [UIScreen mainScreen].scale;

        self.bgCircleProgressLayer = [BackgroundProgressLayer layer];
        self.bgCircleProgressLayer.frame = self.bounds;
        [self.bgCircleProgressLayer setNeedsDisplay];
        
        self.bgCircleProgressLayer.contentsScale = [UIScreen mainScreen].scale;

        [self.layer addSublayer:self.bgCircleProgressLayer];
        [self.layer addSublayer:self.circleProgressLayer];

    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"progress"];
    ani.duration = 1.4 * fabs(progress - _progress);
    ani.toValue = @(progress);
    ani.fillMode = kCAFillModeForwards;
    ani.delegate = self;
    ani.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.76:0.18:0.22:1.0];
    [self.circleProgressLayer addAnimation:ani forKey:@"progressAni"];
    _progress = progress;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.circleProgressLayer.progress = self.progress;
    if (self.block != nil) {
        self.block();
    }
}

@end
