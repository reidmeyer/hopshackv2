//
//  BreweryBeersTableViewController.m
//  HopshackFinal
//
//  Created by Reid Meyer on 7/23/16.
//  Copyright (c) 2014 Blake Butterworth. All rights reserved.
//

#import "BreweryBeersTableViewController.h"
#import "APIClient.h"
#import "BeerProfileViewController.h"

@interface BreweryBeersTableViewController ()

@end

@implementation BreweryBeersTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title=@"Beers From Brewery";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _myGreen=[[UIColor alloc] initWithRed:0.376 green:0.729 blue:0.318 alpha:1.000];
    _myBlue=[[UIColor alloc] initWithRed:0.11 green:0.27 blue:0.53 alpha:1.0];

    self.Brewery=[Brewery getBrewery];
    
    [[APIClient sharedClient] getBeerDetailsWithCompany:self.companyPressed
                                                 success:^(NSArray *results) {
                                                     self.everythingCompany=results;
                                                     // NSLog(@"%@",self.everythingType);
                                                 } failure:^(NSError *error) {
                                                     //
                                                     NSLog(@"%@",error);
                                                 }];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRetrieved) name:@"beerCompanyFinishedLoading" object:nil];
 
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)dataRetrieved{
    //NSLog(@"%@",self.everythingType);
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (NSDictionary *oneDictionary in self.everythingCompany){
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
    self.beerCompany=[[NSArray alloc]initWithArray:tempArray];
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
    return self.beerCompany.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pCell" ];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"pCell"];
    };
    cell.detailTextLabel.text=[self.beerCompany[indexPath.row] typeName];
    cell.textLabel.text=[self.beerCompany[indexPath.row] nameDetail];
    cell.detailTextLabel.textColor=_myBlue;
    cell.textLabel.textColor=_myBlue;
    cell.imageView.image=[UIImage imageNamed:[self.beerCompany[indexPath.row] typePhot]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BeerProfileViewController *beerProfileVC = [[BeerProfileViewController alloc]init];
    beerProfileVC.idPressed=[self.beerCompany[indexPath.row]identificationDetail];
    [[self navigationController] pushViewController:beerProfileVC animated:YES];
    
}
@end