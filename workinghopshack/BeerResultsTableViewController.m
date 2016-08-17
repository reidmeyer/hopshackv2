//
//  BeerResultsTableViewController.m
//  workinghopshack
//
//  Created by Blake Butterworth on 2/28/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import "BeerResultsTableViewController.h"
#import "BeerProfileViewController.h"


@interface BeerResultsTableViewController ()

@end

@implementation BeerResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myGreen=[[UIColor alloc] initWithRed:0.376 green:0.729 blue:0.318 alpha:1.000];
    _myBlue=[[UIColor alloc] initWithRed:0.11 green:0.27 blue:0.53 alpha:1.0];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.filteredbeers.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer=@"pCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer ];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellIdentifer];}
    cell.detailTextLabel.text=[self.filteredbeers [indexPath.row] company];
    cell.detailTextLabel.textColor=_myBlue;
   cell.textLabel.text=[self.filteredbeers [indexPath.row] name];
   cell.textLabel.textColor=_myBlue;
  cell.imageView.image=[UIImage imageNamed:[self.filteredbeers[indexPath.row] typePhot]];
    return cell;
}


@end
