//
//  CircleProgressView.h
//  ButtonAnimation
//
//  Created by GXY on 16/5/27.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundProgressLayer.h"
#import "CircleProgressLayer.h"

typedef void(^progressBlock)();

@interface CircleProgressView : UIView

@property (strong, nonatomic) CircleProgressLayer *circleProgressLayer;
@property (strong, nonatomic) BackgroundProgressLayer *bgCircleProgressLayer;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) progressBlock block;

@end
