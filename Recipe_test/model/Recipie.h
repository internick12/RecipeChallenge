//
//  PQAUser.h
//  DIVERCITY
//
//  Created by Trinidad on 5/12/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import Realm;

@interface Recipie : RLMObject

@property NSInteger recipie_id;
@property NSString *title;
@property NSString *primary_picture_url;
@property NSString *ingredients;
@property NSString *instructions;


+ (Recipie *)retrieveRecipieWithResponse:(NSDictionary *)response;

@end

