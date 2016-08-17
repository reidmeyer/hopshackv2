//
//  FavoritesTableViewController.h
//  hopshack
//
//  Created by Blake Butterworth on 1/31/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brewery.h"

@interface RatedBeersTableViewController : UITableViewController

@property (strong,nonatomic) Brewery *bar;
@property (strong,nonatomic) Brewery *bar1;

@property (strong,nonatomic) UIColor *myGreen;
@property (strong,nonatomic) UIColor *myBlue;
@end
