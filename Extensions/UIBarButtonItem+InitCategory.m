//
//  UIBarButtonItem+Category.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/28.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "UIBarButtonItem+InitCategory.h"

@implementation UIBarButtonItem (InitCategory)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:btn];
}

@end
