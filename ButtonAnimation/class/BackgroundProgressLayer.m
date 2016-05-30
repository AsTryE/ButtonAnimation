//
//  BackgroundProgressLayer.m
//  ButtonAnimation
//
//  Created by GXY on 16/5/27.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "BackgroundProgressLayer.h"

@implementation BackgroundProgressLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat radius = self.bounds.size.width / 2;
    CGFloat lineWidth = 4.0;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius - lineWidth / 2 startAngle:0.f endAngle:M_PI * 2 * 1 clockwise:YES];
    CGContextSetRGBStrokeColor(ctx, 0.9, 0.9, 0.9, 1.0);//笔颜色
    CGContextSetLineWidth(ctx, 4);//线条宽度
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

@end
