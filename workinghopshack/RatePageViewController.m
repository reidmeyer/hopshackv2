//
//  ViewController.m
//  workinghopshack
//
//  Created by Blake Butterworth on 2/21/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import "RatePageViewController.h"
#import "RatedBeersTableViewController.h"
#import "APIClient.h"


@interface RatePageViewController ()

@end

@implementation RatePageViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Rate Page";
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self dataRetrieved];
    
    
    dispatch_async(dispatch_queue_create("beerdata", 0), ^{
        [[APIClient sharedClient] getBeerDetailsWithId:self.idPressed
                                               success:^(NSArray *results) {
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       //NSLog(@"%@",results);
                                                       self.beerProfileDetails=results;
                                                       [self dataRetrieved];
                                                       
                                                   });
                                                   
                                                   
                                                   
                                               } failure:^(NSError *error) {
                                                   //
                                                   NSLog(@"%@",error);
                                               }];
    });

    
    
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
    
    
    self.zipField=[[UITextField alloc]init];
    
    
    
    self.zipField.frame=CGRectMake(20,320,150,30);
    self.zipField.backgroundColor=[UIColor whiteColor];
    self.zipField.borderStyle=UITextBorderStyleBezel;
    self.zipField.keyboardType=UIKeyboardTypeDefault;
    self.zipField.placeholder=@"Enter Rating 0.00";
    self.zipField.delegate=self;
    [self.view addSubview:self.zipField];
    
    
    self.bar=[Brewery getBrewery];
    if (!self.bar){
        self.bar=[[Brewery alloc]init];
    }
    self.bar1=[Brewery getBrewery];
    if (!self.bar1){
        self.bar1=[[Brewery alloc]init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)ratedButtonPressed:(id)sender{
    RatedBeersTableViewController *ratedBeers=[[RatedBeersTableViewController alloc]init];
    [[self navigationController]pushViewController:ratedBeers animated:YES];
}

-(void)ratingEntered {
    NSLog(@"it gets here");
    [Brewery createEmployeeDirectory];
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithArray:self.bar1.ratedBeers];
    
    [tempArray addObject:self.club];
    self.bar1.ratedBeers = tempArray;
    [Brewery saveBrewery:self.bar1];
    NSLog(@"does all that");
    //NSLog(self.club.personalRatingDetail);


}

-(void)rateMethod:(NSString*)tempRating
{
    
    //LocationResultTableViewController *locationResultTVC=[[LocationResultTableViewController alloc]init];
    //locationResultTVC.stateResult=self.tempRating;
    //NSLog(@"%@",locationResultTVC.stateResult);
    // [[self navigationController]pushViewController:locationResultTVC animated:YES];
    //self.club.personalRatingDetail = tempRating;
    
    dispatch_async(dispatch_queue_create("updateRating", 0), ^{
        [[APIClient sharedClient] updateBeerRatingWithIdAndRating:self.idPressed andRating:tempRating
                                                          success:^(NSString *results) {
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  //NSLog(@"%@",results);
                                                                  
                                                                     //[self dataRetrieved];

                                                                  [self ratingEntered];
                                                                  
                                                              });
                                                              
                                                              
                                                          } failure:^(NSError *error) {
                                                              //
                                                              NSLog(@"%@",error);
                                                          }];
    });
    
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.zipField) {
        //NSLog(@"%@",self.zipField.text);
        [textField resignFirstResponder];
        [self rateMethod:self.zipField.text];
        return NO;
    }
    return YES;
}


- (void)dataRetrieved{
    for (NSDictionary *oneDictionary in self.beerProfileDetails){
        self.club=[[Brewery alloc]initWithAbv:oneDictionary[@"abv"]
                                         city:oneDictionary[@"city"]
                                companyDetail:oneDictionary[@"company"]
                                      country:oneDictionary[@"country"]
                         identificationDetail:oneDictionary[@"id"]
                                   nameDetail:oneDictionary[@"name"]
                                         desc:oneDictionary[@"notes"]
                                        state:oneDictionary[@"state"]
                                   typeNumber:oneDictionary[@"type"]
                                 ratingDetail:oneDictionary[@"rating"]
                   ];
        
    }
    /*self.descriptionLabel.text=self.club.desc;
    self.companyLabel.text=self.club.companyDetail;
    self.nameLabel.text=self.club.nameDetail;
    self.cityState=[[self.club.city stringByAppendingString:@","]stringByAppendingString:self.club.state];
    self.cityStateLabel.text=self.cityState;
    //    [self.abvLabel setTitle:self.club.abv forState:UIControlStateNormal];
    */
    
    }


@end
