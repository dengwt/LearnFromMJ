//
//  BaseTabBarViewController.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/23.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "HomeViewController.h"
#import "FriendViewController.h"
#import "DefineTabBar.h"
#import "NewsViewController.h"
#import "MeViewController.h"
#import "BaseNavigationController.h"
#import <objc/runtime.h>

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

+ (void)initialize
{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = attrs[NSForegroundColorAttributeName];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    
    [appearance setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

- (void)fetchMethodList:(Class)className {
    unsigned int count;
    
    objc_property_t *propertyList = class_copyPropertyList(className, &count);
    for(int i = 0; i< count; i++) {
        objc_property_t property = propertyList[i];
        Log(@"%s", property_getName(property));
    }
    
//    Method *methodList = class_copyMethodList(className, &count);
//    for(int i = 0; i < count; i++){
//        Method method = methodList[i];
//        NSString *methodName = NSStringFromSelector(method_getName(method));
//        NSLog(@"方法名：%@ \n", methodName);
//    }
    
    free(propertyList);
}

- (void)fetchIvarList:(Class)className
{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(className, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSLog(@"%@", ivarName);
    }
    free(ivarList);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
    
    [self fetchMethodList:[UITabBarController class]];
    
    [self setValue:[[DefineTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup {
    HomeViewController *home = [[HomeViewController alloc] init];
    [self setupTabItemAttrs:home title:@"Home" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    FriendViewController *friend = [[FriendViewController alloc] init];
    [self setupTabItemAttrs:friend title:@"Friend" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    NewsViewController *news = [[NewsViewController alloc] init];
    [self setupTabItemAttrs:news title:@"News" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    MeViewController *me = [[MeViewController alloc] init];
    [self setupTabItemAttrs:me title:@"Me" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}

- (void)setupTabItemAttrs: (UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
