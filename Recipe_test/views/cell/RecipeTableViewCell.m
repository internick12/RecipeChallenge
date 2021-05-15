//
//  RecipeTableViewCell.m
//  DIVERCITY
//
//  Created by Trinidad on 5/12/21.
//

#import "RecipeTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
@implementation RecipeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCell:(Recipie *) recipe {
    [self.imgPhoto sd_setImageWithURL:[NSURL URLWithString:recipe.primary_picture_url] placeholderImage: [UIImage imageNamed:@"placeholder.png"]];
    self.lblTitle.text = recipe.title;
    self.lbIngredients.text = recipe.ingredients;
}

@end
