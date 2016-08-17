//
//  FavoritesTableViewController.m
//  hopshack
//
//  Created by Blake Butterworth on 1/31/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "BeerProfileViewController.h"

@interface FavoritesTableViewController ()

@end

@implementation FavoritesTableViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title=@"Shack";
        self.tabBarItem.image=[UIImage imageNamed:@"shack"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _myGreen=[[UIColor alloc] initWithRed:0.376 green:0.729 blue:0.318 alpha:1.000];
    _myBlue=[[UIColor alloc] initWithRed:0.11 green:0.27 blue:0.53 alpha:1.0];

    
}
-(void)viewWillAppear:(BOOL)animated{
    self.bar=[Brewery getBrewery];
    self.bar1=[Brewery getBrewery];

    //NSLog(@"%@",self.bar.favoriteBeers);
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
    return self.bar.favoriteBeers.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pCell" ];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"pCell"];
        cell.detailTextLabel.text=[self.bar.favoriteBeers [indexPath.row] companyDetail];
        cell.textLabel.text=[self.bar.favoriteBeers[indexPath.row]nameDetail];
        cell.detailTextLabel.textColor=_myBlue;
        cell.textLabel.textColor=_myBlue;
        cell.imageView.image=[UIImage imageNamed:[self.bar.favoriteBeers[indexPath.row] typePhot]];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BeerProfileViewController *beerProfileVC = [[BeerProfileViewController alloc]init];
    beerProfileVC.idPressed=[self.bar.favoriteBeers[indexPath.row]identificationDetail];
    [[self navigationController] pushViewController:beerProfileVC animated:YES];
    
}
@end
