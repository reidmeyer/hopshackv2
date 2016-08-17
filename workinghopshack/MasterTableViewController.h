//
//  MasterTableViewController.h
//  hopshack
//
//  Created by Blake Butterworth on 1/29/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brewery.h"
#import "BeerResultsTableViewController.h"

@interface MasterTableViewController : UITableViewController<UISearchControllerDelegate,UISearchBarDelegate,UISearchResultsUpdating>

@property (strong,nonatomic) NSArray *searchResults;
@property (strong,nonatomic) NSMutableArray *searchData;
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UISearchController *searchController;
@property (strong,nonatomic) BeerResultsTableViewController *resultsTableController;

@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;


@property (strong,nonatomic) Brewery *brewery;
@property (strong,nonatomic) NSArray *beerBasic;

@property (strong,nonatomic) UIColor *myGreen;
@property (strong,nonatomic) UIColor *myBlue;



@end
