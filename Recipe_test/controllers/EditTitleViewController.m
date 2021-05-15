//
//  DetailViewController.m
//  Recipe_test
//
//  Created by Trinidad on 5/12/21.
//

#import "EditTitleViewController.h"
#import "Global.h"


@interface EditTitleViewController ()

{
    Recipie *selectedRecipe;
}
@property (weak, nonatomic) IBOutlet UITextField *tfTitle;

@end

@implementation EditTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getSelectedRecipe];
    
}

- (void) getSelectedRecipe {
    selectedRecipe = [Recipie objectsWhere:@"recipie_id=%d", self.selectedRecipeId].firstObject;
    if (selectedRecipe != nil) {
        self.tfTitle.text = selectedRecipe.title;
    }
    
}


- (IBAction)onBtnDone:(id)sender {
    if (selectedRecipe == nil) {
        return;
    }
    NSString *strTitle = self.tfTitle.text;
    NSString *strTmp = [strTitle stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (strTmp.length == 0) {
        alertView(@"Oops", @"Please check again.", self);
        return;
    }
    
    if (strTitle == selectedRecipe.title) {
        alertView(@"Oops", @"You didn't change anything yet. Please check again.", self);
        return;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    selectedRecipe.title = strTitle;
    [realm addOrUpdateObject:selectedRecipe];
    [realm commitWriteTransaction];
    [self.navigationController popViewControllerAnimated:true];
}




@end
