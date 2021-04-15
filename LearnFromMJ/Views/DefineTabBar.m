//
//  DefineTabBar.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/24.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "DefineTabBar.h"

@interface DefineTabBar()
@property (nonatomic, weak) UIButton *addButton;

@end

@implementation DefineTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *adBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [adBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [adBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self addSubview:adBtn];
        self.addButton = adBtn;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    self.addButton.width = self.addButton.currentBackgroundImage.size.width;
    self.addButton.height = self.addButton.currentBackgroundImage.size.height;
    self.addButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:[UIControl class]] || view == self.addButton) {
            continue;
        }
        
        CGFloat buttonX = buttonW * (index > 1 ? (index + 1) : index);
        view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index ++;
    }
}

@end
