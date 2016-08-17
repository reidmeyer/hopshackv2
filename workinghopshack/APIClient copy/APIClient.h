//
//  APIClient.h
//  JHRESTClient
//
//  Created by Jason Humphries on 1/15/15.
//  Copyright (c) 2015 Jason Humphries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface APIClient : AFHTTPSessionManager

+ (id)sharedClient;

// GET call

- (void)getBeerDetailsWithId:(NSString*)BeerId
                     success:(void (^)(NSArray*))success
                     failure:(void (^)(NSError *error))failure;

- (void)getBeerDetailsWithState:(NSString*)BeerState
                     success:(void (^)(NSArray*))success
                     failure:(void (^)(NSError *error))failure;

- (void)getBeerDetailsWithType:(NSString*)BeerType
                        success:(void (^)(NSArray*))success
                        failure:(void (^)(NSError *error))failure;

- (void)getBeerDetailsWithCompany:(NSString*)BeerCompany
                       success:(void (^)(NSArray*))success
                       failure:(void (^)(NSError *error))failure;


- (void)updateBeerRatingWithIdAndRating:(NSString*)BeerId andRating:(NSString*)BeerRating
                                success:(void (^)(NSString*))success
                                failure:(void (^)(NSError *error))failure;


@end
