//
//  UserCell.h
//  LearnFromMJ
//
//  Created by LIANDI on 2018/09/03.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface UserCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *followButton;

@property (strong, nonatomic) UserModel *userModel;

@end
