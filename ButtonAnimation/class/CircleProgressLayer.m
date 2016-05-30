//
//  CircleProgressLayer.m
//  ButtonAnimation
//
//  Created by GXY on 16/5/27.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "CircleProgressLayer.h"

@implementation CircleProgressLayer

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat radius = self.bounds.size.width / 2;
    CGFloat lineWidth = 4.0;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius - lineWidth / 2 startAngle:-M_PI / 2 endAngle:M_PI * 2 * self.progress clockwise:YES];
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.9, 1.0);
    CGContextSetLineWidth(ctx, 4);
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (instancetype)initWithLayer:(CircleProgressLayer *)layer {
    if (self = [super initWithLayer:layer]) {
        self.progress = layer.progress;
    }
    return self;
}

@end
