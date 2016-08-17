//
//  ViewController.m
//  workinghopshack
//
//  Created by Blake Butterworth on 2/21/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import "DiscoverViewController.h"
#import "GetLocationViewController.h"
#import "RecommendTableViewController.h"
#import "RatedBeersTableViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Discover";
        self.tabBarItem.image=[UIImage imageNamed:@"globe"];
    }
    return self;
}- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UIButton *ratedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        ratedButton.frame = CGRectMake(85, 160, 150, 50);
    //iphone 6
    else if (screenRect.size.width == 375)
        ratedButton.frame = CGRectMake(105, 240, 150, 50);
    //iphone 6+
    else if (screenRect.size.width==414)
        ratedButton.frame = CGRectMake(115, 300, 150, 50);
    //other ?
    else
        ratedButton.frame = CGRectMake(85, 250, 150, 50);
    
    [ratedButton setTitle:@"Rated Beers" forState:UIControlStateNormal];
    [self.view addSubview:ratedButton];
    
    [ratedButton addTarget:self action:@selector(ratedButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    

    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        locationButton.frame = CGRectMake(85, 160, 150, 50);
    //iphone 6
    else if (screenRect.size.width == 375)
        locationButton.frame = CGRectMake(105, 240, 150, 50);
    //iphone 6+
    else if (screenRect.size.width==414)
        locationButton.frame = CGRectMake(115, 300, 150, 50);
    //other ?
    else
        locationButton.frame = CGRectMake(85, 140, 150, 50);
    
    [locationButton setTitle:@"Local Breweries" forState:UIControlStateNormal];
    [self.view addSubview:locationButton];
    [locationButton addTarget:self action:@selector(locationButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *recommendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        recommendButton.frame = CGRectMake(90, 240, 150, 50);
    //iphone 6
    else if (screenRect.size.width == 375)
        recommendButton.frame = CGRectMake(110, 330, 150, 50);
    //iphone 6+
    else if (screenRect.size.width==414)
        recommendButton.frame = CGRectMake(120, 400, 150, 50);
    //other ?
    else
        recommendButton.frame = CGRectMake(90, 210, 150, 50);
    
    [recommendButton setTitle:@"Recommended Beers" forState:UIControlStateNormal];
    [self.view addSubview:recommendButton];
    [recommendButton addTarget:self action:@selector(recommendButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)recommendButtonPressed:(id)sender{
    RecommendTableViewController *recTVC=[[RecommendTableViewController alloc]init];
    [[self navigationController]pushViewController:recTVC animated:YES];
}
-(void)locationButtonPressed:(id)sender{
    GetLocationViewController *getLocation=[[GetLocationViewController alloc]init];
    [[self navigationController]pushViewController:getLocation animated:YES];
}

-(void)ratedButtonPressed:(id)sender{
    RatedBeersTableViewController *ratedBeers=[[RatedBeersTableViewController alloc]init];
    [[self navigationController]pushViewController:ratedBeers animated:YES];
}

@end
