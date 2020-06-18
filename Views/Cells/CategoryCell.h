//
//  CategoryCell.h
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/31.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface CategoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *selectedIndicator;

@property (nonatomic, strong) CategoryModel *categoryModel;

@end
