//
//  KeyboardTool.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/09/06.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "KeyboardTool.h"

@implementation KeyboardTool

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 *Usage
 *
 *Implement <KeyboardToolDelegate>
 *
 *KeyboardTool *toolbar = [KeyboardTool init];
 *toolbar.toolbarDelegate = self;
 *
 *xxxTextField.inputAccessoryView = toolbar;
 *
 *- (void)keyboardTool:(KeyboardTool *)tool didClickItem:(KeyboardToolItem)item
 *{
 *if (item == KeyboardToolPrevious）{
 *referance KeyboardUsage.m file
 *}
 *
 */

+ (instancetype)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (IBAction)PreviousAction:(id)sender {
    if ([_toolbarDelegate respondsToSelector:@selector(keyboardTool:didClickItem:)]) {
        [_toolbarDelegate keyboardTool:self didClickItem:KeyboardToolPrevious];
    }
}

- (IBAction)NextAction:(id)sender {
    if ([_toolbarDelegate respondsToSelector:@selector(keyboardTool:didClickItem:)]) {
        [_toolbarDelegate keyboardTool:self didClickItem:KeyboardToolNext];
    }
}

- (IBAction)DoneAction:(id)sender {
    if ([_toolbarDelegate respondsToSelector:@selector(keyboardTool:didClickItem:)]) {
        [_toolbarDelegate keyboardTool:self didClickItem:KeyboardToolDone];
    }
}

@end
