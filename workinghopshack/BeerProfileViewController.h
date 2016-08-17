//
//  BeerProfileViewController.h
//  hopshack
//
//  Created by Blake Butterworth on 1/31/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brewery.h"


@interface BeerProfileViewController : UIViewController

@property (strong,nonatomic) NSString *idPressed;
@property (strong,nonatomic) NSArray *beerProfileDetails;

@property (strong,nonatomic) Brewery *club;

@property (strong,nonatomic) Brewery *bar;
@property (strong,nonatomic) Brewery *bar1;


 
@property (strong,nonatomic) UITextView *descriptionLabel;
@property (strong,nonatomic) UILabel *companyLabel;
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *cityStateLabel;
@property (strong,nonatomic) NSString *cityState;
@property (strong,nonatomic) UIButton *abvLabel;
@property (strong,nonatomic) UIButton *ratingLabel;


@property(nonatomic) UIBaselineAdjustment baselineAdjustment;


@property (strong,nonatomic) UIColor *myGreen;
@property (strong,nonatomic) UIColor *myBlue;

@property (strong,nonatomic) NSArray *searchResultsFav;
@property (strong,nonatomic) NSArray *searchResultsRate;


@end
