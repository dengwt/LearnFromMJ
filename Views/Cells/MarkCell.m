//
//  MarkCell.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/09/05.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "MarkCell.h"
#import "UIImageView+WebCache.h"

@implementation MarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMarkModel:(MarkModel *)markModel
{
    _markModel = markModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:markModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeLabel.text = markModel.theme_name;
    NSString *subNum = nil;
    if (markModel.sub_number < 10000) {
        subNum = [NSString stringWithFormat:@"%zd人订阅", markModel.sub_number];
    } else {
        subNum = [NSString stringWithFormat:@"%.1f万人订阅", markModel.sub_number / 10000.0];
    }
    self.subNumLabel.text = subNum;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
