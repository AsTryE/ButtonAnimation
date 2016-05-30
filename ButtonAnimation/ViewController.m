//
//  ViewController.m
//  ButtonAnimation
//
//  Created by GXY on 16/5/26.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "ViewController.h"
#import "SubmitAnimationButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView_head;
@property (weak, nonatomic) IBOutlet SubmitAnimationButton *button_submit;
@property (strong, nonatomic) CircleProgressView *circleProgressView;
@property (strong, nonatomic) CABasicAnimation *ani;
@property (strong, nonatomic) UIColor *sColor;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_right;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _button_submit.submitBorderWidth = 4;
    _button_submit.leftConstraint = self.constraint_right;
    _button_submit.rightConstraint = self.constraint_left;
    _button_submit.block = ^() {
        NSLog(@"动画执行结束！！！！");
    };
    _button_submit.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.circleProgressView.progress += 1;
}

- (IBAction)reverAction:(UIButton *)btn {
    [_button_submit setBackgroundColor:[UIColor whiteColor]];
    [_button_submit setTitleColor:_sColor forState:UIControlStateNormal];
}

- (IBAction)animationAction:(SubmitAnimationButton *)btn {
//    [btn setBackgroundColor:[UIColor colorWithRed: 0.915 green: 0.084 blue: 0.201 alpha: 0.1]];
    if (_sColor == nil) {
        _sColor = btn.currentTitleColor;
    }
    [btn startAnimaiton];
}

@end
