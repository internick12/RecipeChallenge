//
//  ExperienceTableViewCell.h
//
//  Created by Trinidad on 5/12/21.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "Recipie.h"
NS_ASSUME_NONNULL_BEGIN



@interface RecipeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbIngredients;

- (void) configureCell:(Recipie *) recipe;

@end

NS_ASSUME_NONNULL_END
