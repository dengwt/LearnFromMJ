//
//  UserCell.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/09/03.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "UserCell.h"
#import "UIImageView+WebCache.h"

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUserModel:(UserModel *)userModel
{
    _userModel = userModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:userModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.userNameLabel.text = userModel.screen_name;
    NSString *fansCount = nil;
    if (userModel.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", userModel.fans_count];
    } else {
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", userModel.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
}

@end
