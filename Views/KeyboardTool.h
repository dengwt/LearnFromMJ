//
//  KeyboardTool.h
//  LearnFromMJ
//
//  Created by LIANDI on 2018/09/06.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KeyboardToolPrevious,
    KeyboardToolNext,
    KeyboardToolDone
} KeyboardToolItem;

@class KeyboardTool;

@protocol KeyboardToolDelegate <NSObject>

@optional
- (void)keyboardTool:(KeyboardTool *)tool didClickItem:(KeyboardToolItem)item;

@end

@interface KeyboardTool : UIToolbar

@property (weak, nonatomic, readonly) IBOutlet UIBarButtonItem *previousItem;
@property (weak, nonatomic, readonly) IBOutlet UIBarButtonItem *nextItem;

+ (instancetype)init;

@property (weak, nonatomic) id<KeyboardToolDelegate> toolbarDelegate;

@end
