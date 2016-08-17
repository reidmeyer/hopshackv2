//
//  RecommendTableViewController.h
//  HopshackFinal
//
//  Created by Blake Butterworth on 12/17/14.
//  Copyright (c) 2014 Blake Butterworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brewery.h"

@interface RecommendTableViewController : UITableViewController <UISearchDisplayDelegate,UISearchBarDelegate>
{
    NSArray *searchResults;
    NSMutableArray *searchData;
    
    UISearchBar *searchBar;
}
@property (strong,nonatomic)NSArray *typeSearchResults;
@property (strong,nonatomic)NSArray *beer;
@property(strong,nonatomic)Brewery *brewery;
@property(strong,nonatomic)NSString *tempTypeNumber;

@property(strong,nonatomic)NSArray *everythingType;
@property(strong,nonatomic)NSArray *beerType;
@property (strong,nonatomic) UIColor *myGreen;
@property (strong,nonatomic) UIColor *myBlue;



@end
