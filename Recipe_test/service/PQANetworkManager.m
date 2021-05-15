//
//  PQANetworkManager.m
//  DIVERCITY
//
//  Created by Trinidad on 5/12/21.
//

#import "PQANetworkManager.h"

@implementation PQANetworkManager

- (void)retrieveRecipeDetails:(NSString *) strUrl
                    completion:(networkCompletion) completion {
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [self GET:strUrl
   parameters:nil
      headers:nil
     progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(task, responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"ErrorResponse=%@",ErrorResponse);
        completion(task, nil, error);
    }];
    
}

@end
