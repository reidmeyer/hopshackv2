//
//  RecommendTableViewController.m
//  HopshackFinal
//
//  Created by Blake Butterworth on 12/17/14.
//  Copyright (c) 2014 Blake Butterworth. All rights reserved.
//

#import "RecommendTableViewController.h"
#import "APIClient.h"
#import "BeerProfileViewController.h"

@interface RecommendTableViewController ()

@end

@implementation RecommendTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title=@"Recs";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _myGreen=[[UIColor alloc] initWithRed:0.376 green:0.729 blue:0.318 alpha:1.000];
    _myBlue=[[UIColor alloc] initWithRed:0.11 green:0.27 blue:0.53 alpha:1.0];

    self.Brewery=[Brewery getBrewery];
    if ([self.brewery.favoriteBeers count] >0 ) {
        int temp=arc4random_uniform([self.brewery.favoriteBeers count]);
        self.tempTypeNumber=[self.brewery.favoriteBeers[temp] typeNumber];//typenumber is a string
        [[APIClient sharedClient] getBeerDetailsWithType:self.tempTypeNumber
                                                 success:^(NSArray *results) {
                                                     self.everythingType=results;
                                                    // NSLog(@"%@",self.everythingType);
                                                 } failure:^(NSError *error) {
                                                     //
                                                     NSLog(@"%@",error);
                                                 }];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRetrieved) name:@"beerTypeFinishedLoading" object:nil];
    }
    else{
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"You have no beers in your shack"
                                                         message:@"Go back and add some beers to your shack"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
    }
   
}
-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];

}

- (void)dataRetrieved{
    //NSLog(@"%@",self.everythingType);
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (NSDictionary *oneDictionary in self.everythingType){
        Brewery *tempBrewery=[[Brewery alloc]initWithAbv:oneDictionary[@"abv"]
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
        [tempArray addObject:tempBrewery];
        
    }
    self.beerType=[[NSArray alloc]initWithArray:tempArray];
    [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.beerType.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pCell" ];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"pCell"];
    };
    cell.detailTextLabel.text=[self.beerType[indexPath.row] nameDetail];
    cell.textLabel.text=[self.beerType[indexPath.row] companyDetail];
    cell.detailTextLabel.textColor=_myBlue;
    cell.textLabel.textColor=_myBlue;
   cell.imageView.image=[UIImage imageNamed:[self.beerType[indexPath.row] typePhot]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
     BeerProfileViewController *beerProfileVC = [[BeerProfileViewController alloc]init];
     beerProfileVC.idPressed=[self.beerType[indexPath.row]identificationDetail];
     [[self navigationController] pushViewController:beerProfileVC animated:YES];
    
}
@end