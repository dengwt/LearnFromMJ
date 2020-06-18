//
//  CategoryModel.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/31.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
