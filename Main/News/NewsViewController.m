//
//  NewsViewController.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/28.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "NewsViewController.h"
#import "FollowViewController.h"
#import "LoginAndRegisterViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(newsClick)];
    
    self.view.backgroundColor = GlobalBg;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newsClick {
    FollowViewController *vc = [[FollowViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)LoginAndRegisterAction:(id)sender {
    LoginAndRegisterViewController *vc = [[LoginAndRegisterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
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
