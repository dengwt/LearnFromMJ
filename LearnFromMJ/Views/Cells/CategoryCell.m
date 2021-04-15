//
//  CategoryCell.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/31.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = RGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = RGBColor(219, 21, 26);
}

- (void)setCategoryModel:(CategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    self.textLabel.text = categoryModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    // Configure the view for the selected state
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : RGBColor(78, 78, 78);
}

@end
