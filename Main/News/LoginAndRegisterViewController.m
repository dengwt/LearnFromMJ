//
//  LoginAndRegisterViewController.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/09/06.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "LoginAndRegisterViewController.h"

@interface LoginAndRegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LoginRegisterConstraint;

@end

@implementation LoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:attrs];
}

- (IBAction)CloseAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)LoginOrRegisterAction:(id)sender {
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    // show register page
    if (self.LoginRegisterConstraint.constant == 0) {
        self.LoginRegisterConstraint.constant = -self.view.width;
        btn.selected = YES;
    } else {
        // show login page
        self.LoginRegisterConstraint.constant = 0;
        btn.selected = NO;
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.view layoutIfNeeded];
    }];
}

// status bar color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
