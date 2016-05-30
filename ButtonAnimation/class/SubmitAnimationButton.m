//
//  SubmitAnimationButton.m
//  ButtonAnimation
//
//  Created by GXY on 16/5/26.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "SubmitAnimationButton.h"

@interface SubmitAnimationButton ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CALayer *bgLayer;

@end

@implementation SubmitAnimationButton

- (void)drawRect:(CGRect)rect {
    if (self.bgLayer == nil) {
        self.bgLayer = [self buttonLayer:rect];
        [self.layer insertSublayer:self.bgLayer atIndex:0];
    }
}

#pragma mark - setter method

- (void)setSubmitBorderColor:(UIColor *)submitBorderColor {
    _submitBorderColor = submitBorderColor;
    self.layer.borderColor = submitBorderColor.CGColor;
}

- (void)setSubmitNormalBackgroundColor:(UIColor *)submitNormalBackgroundColor {
    _submitNormalBackgroundColor = submitNormalBackgroundColor;
    self.backgroundColor = _submitNormalBackgroundColor;
}

- (void)setSubmitActiveBackgroundColor:(UIColor *)submitActiveBackgroundColor {
    _submitActiveBackgroundColor = submitActiveBackgroundColor;
    self.bgLayer.backgroundColor = _submitActiveBackgroundColor.CGColor;
}

- (void)setSubmitBorderWidth:(CGFloat)submitBorderWidth {
    _submitBorderWidth = submitBorderWidth;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = submitBorderWidth;
}

- (void)setSubmitCornerRadius:(CGFloat)submitCornerRadius {
    _submitCornerRadius = submitCornerRadius;
    self.layer.cornerRadius = submitCornerRadius;
}

#pragma mark - animaiton method public

- (void)startAnimaiton {
    self.userInteractionEnabled = NO;
    SubmitAnimationButton *weakSelf = self;
    // 获取按钮文字Label
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UIButtonLabel")]) {
            weakSelf.label = obj;
        }
    }];
    if (self.circleProgressView == nil) {
        self.circleProgressView = [[CircleProgressView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
        self.circleProgressView.center = self.center;
        self.circleProgressView.block = ^(){
            weakSelf.circleProgressView.alpha = 0.f;
            weakSelf.alpha = 1.0;
            weakSelf.bgLayer.opacity = 0.f;
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                // 按钮放大
                weakSelf.leftConstraint.constant = 40 / 2;
                weakSelf.rightConstraint.constant = 40 / 2;
                weakSelf.bgLayer.opacity = 1.f;
                [weakSelf layoutIfNeeded];
            } completion:^(BOOL finished) {
                [weakSelf.label.layer addAnimation:[weakSelf buttonScale2BasicAnimation] forKey:@"scaleLayerLast"];
                [weakSelf.circleProgressView removeFromSuperview];
                weakSelf.circleProgressView = nil;
            }];
        };
        [self.superview addSubview:self.circleProgressView];
    }
    weakSelf.circleProgressView.alpha = 0.f;
    self.bgLayer.backgroundColor = self.submitActiveBackgroundColor.CGColor;
    // 添加缩放动画
    self.bgLayer.opacity = 0.f;
    [UIView animateWithDuration:0.7 delay:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        // 改变背景颜色
        self.bgLayer.opacity = 1.f;
        [weakSelf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [weakSelf.label.layer addAnimation:[self buttonScaleBasicAnimation] forKey:@"scaleLayer"];
    }];
}

#pragma mark - private method

- (CALayer *)buttonLayer:(CGRect)rect {
    CALayer *layer = [CALayer layer];
    layer.frame = rect;
    layer.backgroundColor = self.submitNormalBackgroundColor.CGColor;
    layer.cornerRadius = self.submitCornerRadius;
    layer.borderColor = self.submitBorderColor.CGColor;
    layer.borderWidth = self.submitBorderWidth;
    return layer;
}

- (CABasicAnimation *)buttonScaleBasicAnimation {
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.33;
    animation.repeatCount = 1;
    animation.autoreverses = YES;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.3];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    return animation;
}

- (CABasicAnimation *)buttonScale2BasicAnimation {
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.33;
    animation.repeatCount = 1;
    animation.autoreverses = YES;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.3];
    animation.toValue = [NSNumber numberWithFloat:1.0];

    return animation;
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    if ([self.label.layer animationForKey:@"scaleLayer"] == anim) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            // 缩小为小圈
            self.leftConstraint.constant = ([[UIScreen mainScreen] bounds].size.width - self.bounds.size.height) / 2;
            self.rightConstraint.constant = ([[UIScreen mainScreen] bounds].size.width - self.bounds.size.height) / 2;
            self.alpha = 0.f;
            // 重新布局
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.bgLayer.opacity = 0.f;
            self.bgLayer.backgroundColor = self.submitActiveBackgroundColor.CGColor;

            self.circleProgressView.alpha = 1.f;
            self.circleProgressView.progress = 1.f;
        }];
    }
    else if ([self.label.layer animationForKey:@"scaleLayerLast"] == anim) {
        if (self.block) {
            // 动画结束回调
            self.userInteractionEnabled = YES;
            self.block();
        }
    }
}

@end
