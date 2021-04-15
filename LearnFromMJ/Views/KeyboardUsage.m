//
//  ViewController.m
//  键盘处理
//
//  Created by xiaomage on 15/7/23.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "KeyboardUsage.h"
#import "KeyboardTool.h"

@interface KeyboardUsage () <UITextFieldDelegate, KeyboardToolDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;

/** 所有的文本框数组 */
@property (nonatomic, strong) NSArray *fields;

/** 工具条 */
@property (nonatomic, weak) KeyboardTool *toolbar;
@end

@implementation KeyboardUsage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fields = @[self.nameField, self.emailField, self.addressField];
    
    // 加载工具条控件
    KeyboardTool *toolbar = [KeyboardTool init];
    toolbar.toolbarDelegate = self;
    self.toolbar = toolbar;
    
    // 设置工具条
    self.nameField.inputAccessoryView = toolbar;
    self.emailField.inputAccessoryView = toolbar;
    self.addressField.inputAccessoryView = toolbar;
}

//- (void)testInputViewAndInputAccessoryView
//{
//    // 更换键盘
//    UIView *keyboard = [[UIView alloc] init];
//    keyboard.frame = CGRectMake(0, 0, 0, 100);
//    keyboard.backgroundColor = [UIColor redColor];
//    self.emailField.inputView = keyboard;
//    
//    // 设置键盘顶部的工具条;
//    UIView *toolbar = [[UIView alloc] init];
//    toolbar.frame = CGRectMake(0, 0, 0, 44);
//    toolbar.backgroundColor = [UIColor blueColor];
//    self.nameField.inputAccessoryView = toolbar;
//    //    self.nameField.inputAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - <XMGKeyboardToolDelegate>

//- (void)keyboardToolDidClickPreviousItem:(XMGKeyboardTool *)tool
//{
//    NSUInteger currentIndex = 0;
//    for (UIView *view in self.view.subviews) {
//        if ([view isFirstResponder]) {
//            currentIndex = [self.fields indexOfObject:view];
//        }
//    }
//    currentIndex--;
//
//    [self.fields[currentIndex] becomeFirstResponder];
//
//    self.toolbar.previousItem.enabled = (currentIndex != 0);
//    self.toolbar.nextItem.enabled = YES;
//}
//
//- (void)keyboardToolDidClickNextItem:(XMGKeyboardTool *)tool
//{
//    NSUInteger currentIndex = 0;
//    for (UIView *view in self.view.subviews) {
//        if ([view isFirstResponder]) {
//            currentIndex = [self.fields indexOfObject:view];
//        }
//    }
//    currentIndex++;
//
//    [self.fields[currentIndex] becomeFirstResponder];
//
//    self.toolbar.previousItem.enabled = YES;
//    self.toolbar.nextItem.enabled = (currentIndex != self.fields.count - 1);
//}
//
//- (void)keyboardToolDidClickDoneItem:(XMGKeyboardTool *)tool
//{
//    [self.view endEditing:YES];
//}

- (void)keyboardTool:(KeyboardTool *)tool didClickItem:(KeyboardToolItem)item
{
    if (item == KeyboardToolPrevious) {
        NSUInteger currentIndex = 0;
        for (UIView *view in self.view.subviews) {
            if ([view isFirstResponder]) {
                currentIndex = [self.fields indexOfObject:view];
            }
        }
        currentIndex--;
        
        [self.fields[currentIndex] becomeFirstResponder];
        
        self.toolbar.previousItem.enabled = (currentIndex != 0);
        self.toolbar.nextItem.enabled = YES;
        
    } else if (item == KeyboardToolNext) {
        NSUInteger currentIndex = 0;
        for (UIView *view in self.view.subviews) {
            if ([view isFirstResponder]) {
                currentIndex = [self.fields indexOfObject:view];
            }
        }
        currentIndex++;
        
        [self.fields[currentIndex] becomeFirstResponder];
        
        self.toolbar.previousItem.enabled = YES;
        self.toolbar.nextItem.enabled = (currentIndex != self.fields.count - 1);
    
    } else if (item == KeyboardToolDone) {
        
        [self.view endEditing:YES];
    }
}

#pragma mark - <UITextFieldDelegate>
/**
 * 当点击键盘右下角的return key时,就会调用这个方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameField) {
        // 让emailField成为第一响应者
        [self.emailField becomeFirstResponder];
    } else if (textField == self.emailField) {
        // 让addressField成为第一响应者
        [self.addressField becomeFirstResponder];
    } else if (textField == self.addressField) {
        [self.view endEditing:YES];
//        [textField resignFirstResponder];
    }
    return YES;
}

/**
 * 键盘弹出就会调用这个方法
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSUInteger currentIndex = [self.fields indexOfObject:textField];
    
    self.toolbar.previousItem.enabled = (currentIndex != 0);
    self.toolbar.nextItem.enabled = (currentIndex != self.fields.count - 1);
}

@end
