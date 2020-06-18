//
//  main.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/22.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

typedef void(^myBlock)(NSInteger);

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        __block int aa = 10;
//        void (^testBlock)(void) = ^void(void){
//            aa++;
//        };
//        void (^testBlock1)(void) = ^{
//            
//        };
//        void (^testBlock2)(NSString *) = ^(NSString *param) {
//            
//        };
//        NSInteger (^testBlock3)(NSInteger, NSString *) = ^NSInteger (NSInteger a, NSString *b) {
//            return 0;
//        };
//        NSLog(testBlock, testBlock1, testBlock2, testBlock3);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
