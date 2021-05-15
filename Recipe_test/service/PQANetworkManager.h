//
//  PQANetworkManager.h
//  DIVERCITY
//
//  Created by Trinidad on 5/12/21.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^networkCompletion)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject, NSError * _Nullable error);



@interface PQANetworkManager : AFHTTPSessionManager
- (void)retrieveRecipeDetails:(NSString * _Nullable) strUrl
                    completion:(nullable networkCompletion)callback;
@end
