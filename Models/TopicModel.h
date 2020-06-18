//
//  TopicModel.h
//  LearnFromMJ
//
//  Created by LIANDI on 2018/09/14.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *profile_image;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger ding;

@property (nonatomic, assign) NSInteger cai;

@property (nonatomic, assign) NSInteger repost;

@property (nonatomic, assign) NSInteger comment;

@end
