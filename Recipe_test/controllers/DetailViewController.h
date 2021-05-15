//
//  ViewController.h
//  Recipe_test
//
//  Created by Trinidad on 5/12/21.
//

#import <UIKit/UIKit.h>
#import "Recipie.h"

@interface DetailViewController : UIViewController
@property (nonatomic, assign) NSInteger selectedRecipeId;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblIngredients;
@property (weak, nonatomic) IBOutlet UILabel *lblInstruction;



@end

