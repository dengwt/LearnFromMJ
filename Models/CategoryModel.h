//
//  CategoryModel.h
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/31.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;


@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger currentPage;

@end
