//
//  ADGuideView.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/09/10.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "ADGuideView.h"

@implementation ADGuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)IKnowAction:(id)sender {
    [self removeFromSuperview];
}

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *storedVersion = [defaults stringForKey:key];
    
    if (![currentVersion isEqualToString:storedVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        ADGuideView *adView = [self adGuideView];
        adView.frame = window.bounds;
        [window addSubview:adView];
        
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}

+ (instancetype)adGuideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
