//
//  LocationResultTableViewController.m
//  workinghopshack
//
//  Created by Blake Butterworth on 2/28/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import "LocationResultTableViewController.h"
#import "APIClient.h"
//#import "Brewery.h"
#import "BreweryBeersTableViewController.h"

@interface LocationResultTableViewController ()

@end

@implementation LocationResultTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title=@"Results";
    }
    return self;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    _myGreen=[[UIColor alloc] initWithRed:0.376 green:0.729 blue:0.318 alpha:1.000];
    _myBlue=[[UIColor alloc] initWithRed:0.11 green:0.27 blue:0.53 alpha:1.0];

    self.Brewery=[Brewery getBrewery];
    
    
    NSLog(@"%@",self.stateResult);

    [[APIClient sharedClient] getBeerDetailsWithState:self.stateResult
                                             success:^(NSArray *results) {
                                                 self.everythingState=results;
                                                 // NSLog(@"%@",self.everythingType);
                                             } failure:^(NSError *error) {
                                                 //
                                                 NSLog(@"%@",error);
                                             }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRetrieved) name:@"beerLocationFinishedLoading" object:nil];
 
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


-(void)dataRetrieved{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (NSDictionary *oneDictionary in self.everythingState){
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
    self.beerState=[[NSArray alloc]initWithArray:tempArray];
    [self.tableView reloadData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.beerState.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pCell" ];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"pCell"];
    };
    cell.detailTextLabel.text=[self.beerState[indexPath.row] city];
    cell.textLabel.text=[self.beerState[indexPath.row] companyDetail];
    cell.detailTextLabel.textColor=_myBlue;
    cell.textLabel.textColor=_myBlue;
    cell.imageView.image=[UIImage imageNamed:[self.beerState[indexPath.row] typePhot]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BreweryBeersTableViewController *breweryBeersTableVC = [[BreweryBeersTableViewController alloc]init];
    breweryBeersTableVC.companyPressed=[self.beerState[indexPath.row]companyDetail];
    [[self navigationController] pushViewController:breweryBeersTableVC animated:YES];
    
}
@end
