//
//  LocationResultTableViewController.h
//  workinghopshack
//
//  Created by Blake Butterworth on 2/28/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brewery.h"


@interface LocationResultTableViewController : UITableViewController <
UISearchDisplayDelegate, UISearchBarDelegate>
{
    NSArray *searchResults;
    NSMutableArray *searchData;
    
    UISearchBar *searchBar;
}


@property (strong,nonatomic)NSString * stateResult;


@property (strong,nonatomic)NSArray *stateSearchResults;
@property (strong,nonatomic)NSArray *beer;
@property(strong,nonatomic)Brewery *brewery;
@property(strong,nonatomic)NSString *tempStateName;

@property(strong,nonatomic)NSArray *everythingState;
@property(strong,nonatomic)NSArray *beerState;
@property (strong,nonatomic) UIColor *myGreen;
@property (strong,nonatomic) UIColor *myBlue;



//@property (strong,nonatomic) NSString *result;
//@property (strong,nonatomic) NSArray *everythingState;
//@property (strong,nonatomic) NSArray *beerState;
@end
