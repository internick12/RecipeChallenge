//
//  PQAUser.m
//  DIVERCITY
//
//  Created by Trinidad on 5/12/21.
//

#import "Recipie.h"

@implementation Recipie

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.recipie_id = [dictionary[@"id"] integerValue];
        if ([dictionary objectForKey:@"main"]) {
            NSDictionary *mainDic = dictionary[@"main"];
            if ([mainDic objectForKey:@"title"]) {
                self.title = [mainDic objectForKey:@"title"];
            }
            if ([mainDic objectForKey:@"primary_picture_url"]) {
                self.primary_picture_url = [mainDic objectForKey:@"primary_picture_url"];
            }
            if ([mainDic objectForKey:@"ingredients"]) {
                NSDictionary *dicIn = [mainDic objectForKey:@"ingredients"];
                int i=1;
                while (i>0) {
                    if ([dicIn objectForKey:[NSString stringWithFormat:@"%d", i]]) {
                        NSString *tmpIn = [dicIn objectForKey:[NSString stringWithFormat:@"%d", i]];
                        if (self.ingredients.length == 0) {
                            self.ingredients = [NSString stringWithFormat:@"1. %@\n", tmpIn];
                        } else {
                            self.ingredients = [NSString stringWithFormat:@"%@%d. %@\n", self.ingredients, i, tmpIn];
                        }
                    } else {
                        break;
                    }
                    i++;
                }
            }
            if ([mainDic objectForKey:@"instructions"]) {
                NSDictionary *dicIn = [mainDic objectForKey:@"instructions"];
                
                int i=1;
                while (i>0) {
                    if ([dicIn objectForKey:[NSString stringWithFormat:@"%d", i]]) {
                        NSString *tmpIn = [dicIn objectForKey:[NSString stringWithFormat:@"%d", i]];
                        if (self.instructions.length == 0) {
                            self.instructions = [NSString stringWithFormat:@"1. %@\n", tmpIn];
                        } else {
                            self.instructions = [NSString stringWithFormat:@"%@%d. %@\n", self.instructions, i, tmpIn];
                        }
                    } else {
                        break;
                    }
                    i++;
                }
            }
        }
    }
    return self;
}

+ (NSString *)primaryKey {
    return @"recipie_id";
}

+ (Recipie *)retrieveRecipieWithResponse:(NSDictionary *)response
{
    Recipie *recipie = [[Recipie alloc] initWithDictionary:response];
    return recipie;
}

@end
