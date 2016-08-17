//
//  APIClient.m
//  JHRESTClient
//
//  Created by Jason Humphries on 1/15/15.
//  Copyright (c) 2015 Jason Humphries. All rights reserved.
//

#import "APIClient.h"

#define API_BASE_URL @"https://hopshack.com"

@interface APIClient ()

@end

@implementation APIClient

+ (id)sharedClient
{
    static APIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    return sharedClient;
}

- (id)init
{
    if (self = [super init]) {
        NSURL *baseURL = [NSURL URLWithString:API_BASE_URL];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSDictionary *headers = @{ @"Accept"        : @"application/json",
                                   @"Content-Type"  : @"application/json" };
        [config setHTTPAdditionalHeaders:headers];
        self = [[APIClient alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    }
    return self;
}

- (void)getBeerDetailsWithId:(NSString*)BeerId
                     success:(void (^)(NSArray*))success
                     failure:(void (^)(NSError *error))failure 

{
    __block NSHTTPURLResponse *httpResponse;
    NSString *path = @"/db_iphone_get_beer_details.php";
    NSDictionary *request = @{@"id":BeerId};
    APIClient *client = [APIClient sharedClient];
    [client GET:path
     parameters:request
        success:
     ^(NSURLSessionDataTask *task, id responseObject) {
         httpResponse = (NSHTTPURLResponse*)task.response;
         if (success) success(responseObject);
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"beerDetailsFinishedLoading" object:nil];
     } failure:
     ^(NSURLSessionDataTask *task, NSError *error) {
         if (failure) failure(error);
     }];
}

//gets one brewary from state
- (void)getBeerDetailsWithState:(NSString*)BeerState
                     success:(void (^)(NSArray*))success
                     failure:(void (^)(NSError *error))failure

{
    __block NSHTTPURLResponse *httpResponse;
    NSString *path = @"/db_iphone_get_beer_state.php";
    NSDictionary *request = @{@"state":BeerState};
    APIClient *client = [APIClient sharedClient];
    [client GET:path
     parameters:request
        success:
     ^(NSURLSessionDataTask *task, id responseObject)
    {
         httpResponse = (NSHTTPURLResponse*)task.response;
         if (success) success(responseObject);
[[NSNotificationCenter defaultCenter] postNotificationName:@"beerLocationFinishedLoading" object:nil];
     } failure:
     ^(NSURLSessionDataTask *task, NSError *error)
    {
         if (failure) failure(error);
     }];
}
- (void)getBeerDetailsWithType:(NSString*)BeerType
                        success:(void (^)(NSArray*))success
                        failure:(void (^)(NSError *error))failure

{
    __block NSHTTPURLResponse *httpResponse;
    NSString *path = @"/db_iphone_get_beer_type.php";
    NSDictionary *request = @{@"type":BeerType};
    APIClient *client = [APIClient sharedClient];
    [client GET:path
     parameters:request
        success:
     ^(NSURLSessionDataTask *task, id responseObject) {
         httpResponse = (NSHTTPURLResponse*)task.response;
         if (success) success(responseObject);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"beerTypeFinishedLoading" object:nil];
     } failure:
     ^(NSURLSessionDataTask *task, NSError *error) {
         if (failure) failure(error);
     }];
}

- (void)getBeerDetailsWithCompany:(NSString*)CompanyName
                       success:(void (^)(NSArray*))success
                       failure:(void (^)(NSError *error))failure

{
    __block NSHTTPURLResponse *httpResponse;
    NSString *path = @"/db_iphone_get_beer_company.php";
    NSDictionary *request = @{@"company":CompanyName};
    APIClient *client = [APIClient sharedClient];
    [client GET:path
     parameters:request
        success:
     ^(NSURLSessionDataTask *task, id responseObject) {
         httpResponse = (NSHTTPURLResponse*)task.response;
         if (success) success(responseObject);
         [[NSNotificationCenter defaultCenter] postNotificationName:@"beerCompanyFinishedLoading" object:nil];
     } failure:
     ^(NSURLSessionDataTask *task, NSError *error) {
         if (failure) failure(error);
     }];
}


- (void)updateBeerRatingWithIdAndRating:(NSString*)BeerId andRating:(NSString*)BeerRating
                          success:(void (^)(NSString*))success
                          failure:(void (^)(NSError *error))failure

{
    __block NSHTTPURLResponse *httpResponse;
    NSString *path = @"/db_iphone_new_rating.php";
    NSDictionary *request = @{@"id":BeerId, @"rating":BeerRating};
    APIClient *client = [APIClient sharedClient];
    [client GET:path
     parameters:request
        success:
     ^(NSURLSessionDataTask *task, id responseObject) {
         httpResponse = (NSHTTPURLResponse*)task.response;
         if (success) success(responseObject);
         [[NSNotificationCenter defaultCenter] postNotificationName:@"beerRatingUpdated" object:nil];
     } failure:
     ^(NSURLSessionDataTask *task, NSError *error) {
         if (failure) failure(error);
     }];
}





- (void)dealloc
{
    //
}

@end
