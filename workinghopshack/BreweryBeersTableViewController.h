//
//  BreweryBeersTableViewController.m
//  HopshackFinal
//
//  Created by Reid Meyer on 7/23/16.
//  Copyright (c) 2014 Blake Butterworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brewery.h"

@interface BreweryBeersTableViewController : UITableViewController <UISearchDisplayDelegate,UISearchBarDelegate>
{
    NSArray *searchResults;
    NSMutableArray *searchData;
    
    UISearchBar *searchBar;
}

@property (strong,nonatomic) NSString *companyPressed;

@property (strong,nonatomic)NSArray *companySearchResults;
@property (strong,nonatomic)NSArray *beer;
@property(strong,nonatomic)Brewery *brewery;

@property(strong,nonatomic)NSArray *everythingCompany;
@property(strong,nonatomic)NSArray *beerCompany;
@property (strong,nonatomic) UIColor *myGreen;
@property (strong,nonatomic) UIColor *myBlue;




@end
