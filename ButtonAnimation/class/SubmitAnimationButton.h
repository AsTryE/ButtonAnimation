//
//  SubmitAnimationButton.h
//  ButtonAnimation
//
//  Created by GXY on 16/5/26.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"

typedef void(^SubmitButtonAnimationFinishBlock)();

IB_DESIGNABLE
@interface SubmitAnimationButton : UIButton

// 调用开始动画
- (void)startAnimaiton;

// 动画按钮执行动画结束回调block *****************可在回调后面写跳转代码或是开始请求网络数据
@property (nonatomic,assign) SubmitButtonAnimationFinishBlock block;

// 支持故事版-----动画按钮左边约束
@property (nonatomic, strong) NSLayoutConstraint * leftConstraint;
// 支持故事版-----动画按钮右边约束
@property (nonatomic, strong) NSLayoutConstraint * rightConstraint;
// 进度圆
@property (nonatomic, strong) CircleProgressView * circleProgressView;
/*
 以下属性值可在故事版中右侧属性栏配置预览 **********************************
*/
// 动画按钮边框宽度
@property (nonatomic) IBInspectable CGFloat submitBorderWidth;
// 动画按钮边框颜色
@property (nonatomic,strong) IBInspectable UIColor * submitBorderColor;
// 动画按钮正常背景颜色
@property (nonatomic,strong) IBInspectable UIColor * submitNormalBackgroundColor;
//@property (nonatomic,strong) IBInspectable UIColor * submitNormalTitleColor;
// 动画按钮激活后（点击后）显示的背景颜色
@property (nonatomic,strong) IBInspectable UIColor * submitActiveBackgroundColor;
// 动画按钮圆角大小
@property (nonatomic) IBInspectable CGFloat submitCornerRadius;

@end
