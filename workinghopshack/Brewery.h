//
//  Brewery.h
//  hopshack
//
//  Created by Blake Butterworth on 1/29/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

@interface Brewery : NSObject /*<NSCoding,NSKeyedArchiverDelegate>*/

@property(strong,nonatomic) NSArray *favoriteBeers;
@property(strong,nonatomic) NSArray *ratedBeers;


@property(strong,nonatomic) NSString *abv;
@property(strong,nonatomic) NSString *city;
@property(strong,nonatomic) NSString *companyDetail;
@property(strong,nonatomic) NSString *country;
@property(strong,nonatomic) NSString *identificationDetail;
@property(strong,nonatomic) NSString *nameDetail;
@property(strong,nonatomic) NSString *desc;
@property(strong,nonatomic) NSString *state;
@property(strong,nonatomic) NSString *typeNumber;
@property(strong,nonatomic) NSString *ratingDetail;




@property(strong,nonatomic) NSString *typeName;
@property(strong,nonatomic) NSString *typeDesc;
@property(strong,nonatomic) NSString *typePhot;


-(id)initWithAbv:(NSString *)anAbv
            city:(NSString *)aCity
   companyDetail:(NSString *)aCompanyDetail
         country:(NSString *)aCountry
identificationDetail:(NSString *)anIdentificationDetal
      nameDetail:(NSString *)aNameDetail
     desc:(NSString *)aDesc
           state:(NSString *)aState
      typeNumber:(NSString *)atypeNumber
    ratingDetail:(NSString *)aRatingDetail;



+(NSString *)getPathToArchive;
+(Brewery *)getBrewery;
+(void)saveBrewery:(Brewery *)aBrewery;
+ (NSString *)filePathDirectory;
+ (BOOL)createEmployeeDirectory;

@property(strong,nonatomic) NSArray *everything;

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *company;
@property(strong,nonatomic) NSString *identificaiton;
//@property(strong,nonatomic) NSString *typeNumber;

-(void)initEverythingWithSuccess:(void (^)(NSArray*))success
                         failure:(void (^)(NSError *error))failure;

-(id)initWithName:(NSString *)aName
          company:(NSString *)aComp
       typeNumber:(NSString *)aTypeNumber
   identification:(NSString *)anID;

@end