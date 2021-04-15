//
//  UIBarButtonItem+Category.h
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/28.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (InitCategory)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
