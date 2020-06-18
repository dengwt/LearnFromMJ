//
//  MarkCell.h
//  LearnFromMJ
//
//  Created by LIANDI on 2018/09/05.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkModel.h"

@interface MarkCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *themeLabel;
@property (strong, nonatomic) IBOutlet UILabel *subNumLabel;

@property (strong, nonatomic) MarkModel *markModel;

@end
