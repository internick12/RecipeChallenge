//
//  ViewController.m
//  Recipe_test
//
//  Created by Trinidad on 5/12/21.
//

#import "ViewController.h"
#import "Recipie.h"
#import "PQANetworkManager.h"
#import "Global.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "RecipeTableViewCell.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *arrRecipe;
@property PQANetworkManager *networkMgr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrRecipe = [[NSMutableArray alloc] init];
    self.networkMgr = [[PQANetworkManager alloc] init];
    [self.tbRecipes registerNib:[UINib nibWithNibName:@"RecipeTableViewCell" bundle:nil] forCellReuseIdentifier:@"RecipeTableViewCell"];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAllRecipesFromRealm];
}

- (void) getAllRecipesFromRealm{
    [self.arrRecipe removeAllObjects];
    RLMResults *allObjects = [Recipie allObjects];
    for (int i=0; i<allObjects.count; i++) {
        Recipie *recipe = [allObjects objectAtIndex:i];
        [self.arrRecipe addObject:recipe];
    }
    [self.tbRecipes reloadData];
    [self getRecipesFromInternet];
}

- (void) getRecipesFromInternet{
    NSArray *arrRecipeUrls = @[@"http://emeals-menubuilder-public.s3.amazonaws.com/v1/recipes/46168/46168_295947.json", @"http://emeals-menubuilder-public.s3.amazonaws.com/v1/recipes/37767/37767_241270.json"];
    
    for (int i=0; i<arrRecipeUrls.count; i++) {
        NSString *strUrl = [arrRecipeUrls objectAtIndex:i];
        
        [self.networkMgr retrieveRecipeDetails:strUrl completion:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject, NSError * _Nullable error)
        {
            if (error) {
                alertView(@"Sorry", @"Unable to get the recipe right now.", self);
                return;
            }
            Recipie *recipe = [Recipie retrieveRecipieWithResponse:responseObject];
            Recipie *existingRecipe = [Recipie objectsWhere:@"recipie_id=%d", recipe.recipie_id].firstObject;
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            if (existingRecipe != nil) {
                recipe.title = existingRecipe.title;
            }
            [realm addOrUpdateObject:recipe];
            [realm commitWriteTransaction];
            [self addRecipeToArray:recipe];
            
        }];
    }
}

- (void) addRecipeToArray:(Recipie *) recipe {
    bool isUpdated = false;
    for (int i=0; i<self.arrRecipe.count; i++) {
        Recipie *recipeTmp = [self.arrRecipe objectAtIndex:i];
        if (recipe.recipie_id == recipeTmp.recipie_id) {
            [self.arrRecipe replaceObjectAtIndex:i withObject:recipe];
            isUpdated = true;
            break;
        }
    }
    if (!isUpdated) {
        [self.arrRecipe addObject:recipe];
    }
    // table view reload
    [self.tbRecipes reloadData];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrRecipe.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RecipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeTableViewCell"];
    Recipie *recipe = [self.arrRecipe objectAtIndex:indexPath.row];
    [cell configureCell:recipe];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Recipie *recipe = [self.arrRecipe objectAtIndex:indexPath.row];
    DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.selectedRecipeId = recipe.recipie_id;
    [self.navigationController pushViewController:vc animated:true];
}

@end
