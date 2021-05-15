//
//  DetailViewController.m
//  Recipe_test
//
//  Created by Trinidad on 5/12/21.
//

#import "DetailViewController.h"
#import "Global.h"
#import <SDWebImage/SDWebImage.h>
#import "EditTitleViewController.h"

@interface DetailViewController ()
{
    Recipie *selectedRecipe;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_scContainer_height;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getSelectedRecipe];
    [self setUI];
}

- (void) getSelectedRecipe {
    selectedRecipe = [Recipie objectsWhere:@"recipie_id=%d", self.selectedRecipeId].firstObject;
    
}

- (void) setUI {
    if (selectedRecipe == nil) {
        return;
    }
    [self.imgPhoto sd_setImageWithURL:[NSURL URLWithString:selectedRecipe.primary_picture_url] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.lblTitle.text = selectedRecipe.title;
    self.lblIngredients.text = selectedRecipe.ingredients;
    self.lblInstruction.text = selectedRecipe.instructions;
    [self setScrollViewHeight];
}

- (void) setScrollViewHeight {
    float scHeight = 774;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGRect boundingRect = [self.lblIngredients.text
                           boundingRectWithSize:CGSizeMake(width-90, CGFLOAT_MAX)
                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                           attributes:@{ NSFontAttributeName:self.lblIngredients.font}
                           context:nil];
    float lblHeight = CGRectGetHeight(boundingRect);
    
    CGRect boundingRect1 = [self.lblInstruction.text
                            boundingRectWithSize:CGSizeMake(width-90, CGFLOAT_MAX)
                            options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                            attributes:@{ NSFontAttributeName:self.lblInstruction.font}
                            context:nil];
    float lblHeight1 = CGRectGetHeight(boundingRect1);
    if (lblHeight > 40) {
        scHeight = scHeight + lblHeight - 40;
    }
    if (lblHeight1 > 40) {
        scHeight = scHeight + lblHeight1 - 40;
    }
    self.constraint_scContainer_height.constant = scHeight;
    [self.view layoutIfNeeded];
}

- (IBAction)onBtnEdit:(id)sender {
    EditTitleViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditTitleViewController"];
    vc.selectedRecipeId = selectedRecipe.recipie_id;
    [self.navigationController pushViewController:vc animated:true];
}

@end
