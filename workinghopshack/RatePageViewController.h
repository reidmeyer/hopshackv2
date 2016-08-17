//
//  ViewController.h
//  workinghopshack
//
//  Created by Blake Butterworth on 2/21/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brewery.h"

@interface RatePageViewController : UIViewController


@property(strong,nonatomic) NSString *idPressed;
@property (strong,nonatomic) IBOutlet UITextField *zipField;
@property (strong,nonatomic) Brewery *club;
@property (strong,nonatomic) Brewery *bar;
@property (strong,nonatomic) Brewery *bar1;
@property (strong,nonatomic) NSArray *beerProfileDetails;



@end

