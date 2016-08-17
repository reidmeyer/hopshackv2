//
//  MasterTableViewController.m
//  hopshack
//
//  Created by Blake Butterworth on 1/29/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import "MasterTableViewController.h"
#import "BeerProfileViewController.h"
#import "BeerResultsTableViewController.h"

@interface MasterTableViewController ()

@end

@implementation MasterTableViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title=@"All Beer";
         self.tabBarItem.image=[UIImage imageNamed:@"encyclopedia"];
        }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _myGreen=[[UIColor alloc] initWithRed:0.376 green:0.729 blue:0.318 alpha:1.000];
    _myBlue=[[UIColor alloc] initWithRed:0.11 green:0.27 blue:0.53 alpha:1.0];
    
    
    self.brewery=[[Brewery alloc]init];
    //create uiactivity indicator view 
    [self.brewery initEverythingWithSuccess:^(NSArray *results) {
        //
        [self dataRetrieved];
    } failure:^(NSError *error) {
        NSLog(@"error with initeverythingwithsuccess,%@",error);
        //
    }];
   
   
    _resultsTableController=[[BeerResultsTableViewController alloc]init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.hidesNavigationBarDuringPresentation=NO;
    self.navigationItem.titleView=self.searchController.searchBar;

    self.resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)dataRetrieved{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    //NSLog(@"%@",self.brewery.everything);
    for (NSDictionary *oneDictionary in self.brewery.everything){
        //fact that it is initWithName means you can't have other info not included there on the mastertableviewcontroller. If you want abv, rating, etc, init with the other one
        Brewery *tempBrewery=[[Brewery alloc]initWithName:oneDictionary[@"name"]
                                      company:oneDictionary[@"company"]
                                   typeNumber:oneDictionary[@"type"]
                               identification:oneDictionary[@"id"]];
        
        [tempArray addObject:tempBrewery];
    }
    
    self.beerBasic=[[NSArray alloc]initWithArray:tempArray];
    //NSLog(@"%lu",(unsigned long)self.beerBasic.count);
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 return [_beerBasic count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer=@"pCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer ];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellIdentifer];}
    cell.detailTextLabel.text=[self.beerBasic [indexPath.row] company];
    cell.detailTextLabel.textColor=_myBlue;
    cell.textLabel.text=[self.beerBasic[indexPath.row]name];
    cell.textLabel.textColor=_myBlue;
  cell.imageView.image=[UIImage imageNamed:[self.beerBasic[indexPath.row] typePhot]];
return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.tableView){
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BeerProfileViewController *beerProfileVC = [[BeerProfileViewController alloc]init];
    beerProfileVC.idPressed=[self.beerBasic[indexPath.row]identificaiton];
    [[self navigationController] pushViewController:beerProfileVC animated:YES];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        BeerProfileViewController *beerProfileVC = [[BeerProfileViewController alloc]init];
        beerProfileVC.idPressed=[self.searchResults[indexPath.row]identificaiton];
        [[self navigationController] pushViewController:beerProfileVC animated:YES];
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;

    
    NSPredicate *resultPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[[NSPredicate predicateWithFormat:@"name contains[c] %@", searchText],[NSPredicate predicateWithFormat:@"company contains[c] %@",searchText]]];
    self.searchResults =[self.beerBasic filteredArrayUsingPredicate:resultPredicate];
    
    BeerResultsTableViewController *tableController = (BeerResultsTableViewController *)self.searchController.searchResultsController;
    tableController.filteredbeers = self.searchResults;
    [tableController.tableView reloadData];
}
@end
