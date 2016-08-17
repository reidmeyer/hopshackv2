//
//  BeerProfileViewController.m
//  hopshack
//
//  Created by Blake Butterworth on 1/31/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//



#import "BeerProfileViewController.h"
#import "APIClient.h"
#import "TypeViewController.h"
#import "RatePageViewController.h"

@interface BeerProfileViewController ()

@end

@implementation BeerProfileViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Brew Information";
    self.myGreen=[[UIColor alloc] initWithRed:0.376 green:0.729 blue:0.318 alpha:1.000];
    self.myBlue=[[UIColor alloc] initWithRed:0.11 green:0.27 blue:0.53 alpha:1.0];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"beerprofilepage"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    dispatch_async(dispatch_queue_create("beerdata", 0), ^{
        [[APIClient sharedClient] getBeerDetailsWithId:self.idPressed
                                               success:^(NSArray *results) {
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       //NSLog(@"%@",results);
                                                       self.beerProfileDetails=results;
                                                       
                                                       [self dataRetrieved];
                                                       UIImageView *glassView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.club.typePhot]];
                                                       glassView.userInteractionEnabled = NO;
                                                       glassView.exclusiveTouch = NO;
                                                       [glassView setContentMode:UIViewContentModeScaleAspectFill];
                                                       
                                                       //Depending on screen size. it will work on iphone 5, 6, 6plus. wont work in landscape mode
                                                       
                                                       CGRect screenRect = [[UIScreen mainScreen] bounds];
                                                       //NSLog(@"%f", screenRect.size.width);
                                                       //NSLog(@"%f", screenRect.size.height);
                                                       
                                                       //iphone 5
                                                       if (screenRect.size.width == 320 && screenRect.size.height == 568)
                                                           glassView.frame=CGRectMake(25, 100, 50, 70);
                                                       //iphone 6
                                                       else if (screenRect.size.width == 375)
                                                           glassView.frame=CGRectMake(30, 110, 50, 100);
                                                       //iphone 6+
                                                       else if (screenRect.size.width==414)
                                                           glassView.frame=CGRectMake (50, 150, 50, 70);
                                                       //other ?
                                                       else
                                                           glassView.frame=CGRectMake(25, 100, 50, 50);
                                                       
                                                       [self.view addSubview:glassView];
                                                       
                                                       
                                                       
                                                     
                                                   });
                                                
                                                   
                                                   
                                               } failure:^(NSError *error) {
                                                   //
                                                   NSLog(@"%@",error);
                                               }];
    });
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.descriptionLabel =[[UITextView alloc]init];
    self.descriptionLabel.exclusiveTouch = NO;
    //heres a description label
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        self.descriptionLabel.frame= CGRectMake(30,180,275,325);
    //iphone 6
    else if (screenRect.size.width == 375)
        self.descriptionLabel.frame= CGRectMake(30,280, 325,260);
    //iphone 6+
    else if (screenRect.size.width==414)
        self.descriptionLabel.frame= CGRectMake(35,250,340,325);
    //other ?
    else
        self.descriptionLabel.frame= CGRectMake(30,210,275,100);
        //self.descriptionLabel.frame= CGRectMake(30,210,275,160);
    
    self.descriptionLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
    [self.descriptionLabel setUserInteractionEnabled:YES];
    [self.descriptionLabel setScrollEnabled:YES];
    self.descriptionLabel.textColor=_myBlue;
    self.descriptionLabel.backgroundColor=[UIColor clearColor];
    self.descriptionLabel.editable=NO;
    
    self.descriptionLabel.layer.borderWidth = 1.0f;
    self.descriptionLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self.view addSubview:self.descriptionLabel];

    
    

    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRetrieved) name:@"beerDetailsFinishedLoading" object:nil];
    self.bar=[Brewery getBrewery];
    if (!self.bar){
        self.bar=[[Brewery alloc]init];
        }
    self.bar1=[Brewery getBrewery];
    if (!self.bar1){
        self.bar1=[[Brewery alloc]init];
    }
   
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
    self.descriptionLabel.text=self.club.desc;
    self.companyLabel.text=self.club.companyDetail;
    self.nameLabel.text=self.club.nameDetail;
    self.cityState=[[self.club.city stringByAppendingString:@","]stringByAppendingString:self.club.state];
    self.cityStateLabel.text=self.cityState;
//    [self.abvLabel setTitle:self.club.abv forState:UIControlStateNormal];
    
    
    [self.abvLabel setImage:[UIImage imageNamed:@"abvbutt.png"] forState:UIControlStateNormal];
    [self.abvLabel setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.abvLabel setTitle:self.club.abv forState:UIControlStateNormal];
    
    [self.abvLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    //[self.ratingLabel setImage:[UIImage imageNamed:@"abvbutt.png"] forState:UIControlStateNormal];
    [self.ratingLabel setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.ratingLabel setTitle:self.club.ratingDetail forState:UIControlStateNormal];
    [self.ratingLabel setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
 
    
    //Depending on screen size. it will work on iphone 5, 6, 6plus. wont work in landscape mode
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //NSLog(@"%f", screenRect.size.width);
    //NSLog(@"%f", screenRect.size.height);
    
   
    
    UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //Here's the type button
    
    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        typeButton.frame = CGRectMake(65, 230, 200, 20);
    //iphone 6
    else if (screenRect.size.width == 375)
        typeButton.frame = CGRectMake(60, 260, 260, 20);
    //iphone 6+
    else if (screenRect.size.width==414)
        typeButton.frame = CGRectMake(105, 300, 200, 20);
    //other ?
    else
        typeButton.frame = CGRectMake(65, 190, 200, 20);
    
    typeButton.layer.borderWidth = 1.0f;
    typeButton.layer.borderColor = [[UIColor grayColor] CGColor];
    
    
    [typeButton setTitle:self.club.typeName forState:UIControlStateNormal];
    [typeButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:typeButton];
    [typeButton addTarget:self action:@selector(typeButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
   
    NSPredicate *resultPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[[NSPredicate predicateWithFormat:@"nameDetail contains[c] %@", self.club.nameDetail],[NSPredicate predicateWithFormat:@"companyDetail contains[c] %@",self.club.companyDetail]]];
    self.searchResultsFav =[self.bar.favoriteBeers filteredArrayUsingPredicate:resultPredicate];
    self.searchResultsRate = [self.bar1.ratedBeers filteredArrayUsingPredicate:resultPredicate];

    
    if(self.searchResultsRate.count==0){
        UIButton *rateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        //iphone 5
        if (screenRect.size.width == 320 && screenRect.size.height == 568)
            rateButton.frame = CGRectMake(20, 450, 200, 40);
        //iphone 6
        else if (screenRect.size.width == 375)
            rateButton.frame = CGRectMake(15, 540, 200, 40);
        //iphone 6+
        else if (screenRect.size.width==414)
            rateButton.frame = CGRectMake(20, 600, 200, 40);
        //other ?
        else
            rateButton.frame = CGRectMake(20,320,150,30);
        
        rateButton.layer.borderWidth = 1.0f;
        rateButton.layer.borderColor = [[UIColor grayColor] CGColor];
        
        [rateButton setTitle:@"Rate" forState:UIControlStateNormal];
        [rateButton setTitle:@"Rate" forState:UIControlStateHighlighted];
        
        [rateButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        
        
        [rateButton setImage:[UIImage imageNamed:@"shack"]forState:UIControlStateNormal];
        [rateButton setImage:[UIImage imageNamed:@"shack"] forState:UIControlStateHighlighted];
        
        rateButton.titleLabel.adjustsFontSizeToFitWidth=YES;
        
        [self.view addSubview:rateButton];
        [rateButton addTarget:self action:@selector(rateButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
    }
    
    else{
        UIButton *unrateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        //iphone 5
        if (screenRect.size.width == 320 && screenRect.size.height == 568)
            unrateButton.frame = CGRectMake(20, 450, 200, 40);
        //iphone 6
        else if (screenRect.size.width == 375)
            unrateButton.frame = CGRectMake(20, 525, 200, 40);
        //iphone 6+
        else if (screenRect.size.width==414)
            unrateButton.frame = CGRectMake(20, 600, 200, 40);
        //other ?
        else
            unrateButton.frame = CGRectMake(20,320,150,30);
        
        unrateButton.layer.borderWidth = 1.0f;
        unrateButton.layer.borderColor = [[UIColor grayColor] CGColor];
        
        [unrateButton setTitle:@"Unrate" forState:UIControlStateNormal];
        [unrateButton setTitle:@"Unrate" forState:UIControlStateHighlighted];
        [unrateButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        
        [unrateButton setImage:[UIImage imageNamed:@"shakabutt"]forState:UIControlStateNormal];
        [unrateButton setImage:[UIImage imageNamed:@"shakabutt"] forState:UIControlStateHighlighted];
        unrateButton.titleLabel.adjustsFontSizeToFitWidth=YES;
        [self.view addSubview:unrateButton];
        [unrateButton addTarget:self action:@selector(unrateButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
    }

    
    //if not in shack
    if(self.searchResultsFav.count==0){
        
        UIButton *favButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        //iphone 5
        if (screenRect.size.width == 320 && screenRect.size.height == 568)
            favButton.frame = CGRectMake(20, 450, 200, 40);
        //iphone 6
        else if (screenRect.size.width == 375)
            favButton.frame = CGRectMake(15, 540, 200, 40);
        //iphone 6+
        else if (screenRect.size.width==414)
            favButton.frame = CGRectMake(20, 600, 200, 40);
        //other ?
        else
            favButton.frame = CGRectMake(10, 375, 200, 40);
        
        favButton.layer.borderWidth = 1.0f;
        favButton.layer.borderColor = [[UIColor grayColor] CGColor];
        
        [favButton setTitle:@" Add to Shack" forState:UIControlStateNormal];
        [favButton setTitle:@" Add to Shack" forState:UIControlStateHighlighted];
        
        [favButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        

        
        [favButton setImage:[UIImage imageNamed:@"shack"]forState:UIControlStateNormal];
        [favButton setImage:[UIImage imageNamed:@"shack"] forState:UIControlStateHighlighted];
        
        favButton.titleLabel.adjustsFontSizeToFitWidth=YES;

        [self.view addSubview:favButton];
        [favButton addTarget:self action:@selector(favbuttonPressed:)forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
    }else{
        UIButton *unfavButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        //iphone 5
        if (screenRect.size.width == 320 && screenRect.size.height == 568)
            unfavButton.frame = CGRectMake(20, 450, 200, 40);
        //iphone 6
        else if (screenRect.size.width == 375)
            unfavButton.frame = CGRectMake(20, 525, 200, 40);
        //iphone 6+
        else if (screenRect.size.width==414)
            unfavButton.frame = CGRectMake(20, 600, 200, 40);
        //other ?
        else
            unfavButton.frame = CGRectMake(3, 375, 240, 40);
        
        unfavButton.layer.borderWidth = 1.0f;
        unfavButton.layer.borderColor = [[UIColor grayColor] CGColor];
        
        [unfavButton setTitle:@" Remove from Shack" forState:UIControlStateNormal];
        [unfavButton setTitle:@" Remove from Shack" forState:UIControlStateHighlighted];
        [unfavButton.titleLabel setFont:[UIFont systemFontOfSize:18]];


        [unfavButton setImage:[UIImage imageNamed:@"shakabutt"]forState:UIControlStateNormal];
        [unfavButton setImage:[UIImage imageNamed:@"shakabutt"] forState:UIControlStateHighlighted];
        unfavButton.titleLabel.adjustsFontSizeToFitWidth=YES;
        [self.view addSubview:unfavButton];
        [unfavButton addTarget:self action:@selector(unfavbuttonPressed:)forControlEvents:UIControlEventTouchUpInside];
    }
}


-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    
    
    
    
    self.companyLabel =[[UILabel alloc]init];
    self.companyLabel.userInteractionEnabled = NO;
    self.companyLabel.exclusiveTouch = NO;
    //heres a company label
    
    
    
    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        self.companyLabel.frame= CGRectMake(160,125,150,100);
    //iphone 6
    else if (screenRect.size.width == 375)
        self.companyLabel.frame= CGRectMake(184,155,175,35);
    //iphone 6+
    else if (screenRect.size.width==414)
        self.companyLabel.frame= CGRectMake(200,170,150,100);
    //other ?
    else
        self.companyLabel.frame= CGRectMake(155,110,150,25);
    
    
    self.companyLabel.layer.borderWidth = 1.0f;
    self.companyLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    
    self.companyLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
    self.companyLabel.numberOfLines = 1;
    self.companyLabel.adjustsFontSizeToFitWidth=YES;
    self.companyLabel.textAlignment=NSTextAlignmentCenter;
    self.companyLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;

    self.companyLabel.textColor=_myGreen;
    self.companyLabel.backgroundColor = [UIColor clearColor];
    //self.companyLabel.editable=NO;
    [self.view addSubview:self.companyLabel];
   
    
    
    
    self.nameLabel =[[UILabel alloc]init];
    self.nameLabel.userInteractionEnabled = NO;
    self.nameLabel.exclusiveTouch = NO;
    //Name label
    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        self.nameLabel.frame= CGRectMake(90,70,240,100);
    //iphone 6
    else if (screenRect.size.width == 375)
        self.nameLabel.frame= CGRectMake(90,80,270,70);
    //iphone 6+
    else if (screenRect.size.width==414)
        self.nameLabel.frame= CGRectMake(110,110,300,100);
    //other ?
    else
        self.nameLabel.frame= CGRectMake(90,65,220,45);
    
    
    self.nameLabel.layer.borderWidth = 1.0f;
    self.nameLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    
    self.nameLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:30];
    self.nameLabel.textColor=_myBlue;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.numberOfLines = 2;
    //self.nameLabel.minimumFontSize=8;
    self.nameLabel.adjustsFontSizeToFitWidth=YES;
    self.nameLabel.textAlignment=NSTextAlignmentCenter;
    self.companyLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    //self.nameLabel.editable=NO;
    [self.view addSubview:self.nameLabel];
    
  
    self.cityStateLabel =[[UILabel alloc]init];
    self.cityStateLabel.userInteractionEnabled = NO;
    self.cityStateLabel.exclusiveTouch = NO;
    

    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        self.cityStateLabel.frame= CGRectMake(160,155,150,50);
    //iphone 6
    else if (screenRect.size.width == 375)
        self.cityStateLabel.frame= CGRectMake(184,185,175,30);
    //iphone 6+
    else if (screenRect.size.width==414)
        self.cityStateLabel.frame= CGRectMake(200,205,150,50);
    //other ?
    else
        self.cityStateLabel.frame= CGRectMake(160,135,150,25);
    
    
    self.cityStateLabel.layer.borderWidth = 1.0f;
    self.cityStateLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    
    self.cityStateLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
    self.cityStateLabel.numberOfLines = 1;
    self.cityStateLabel.adjustsFontSizeToFitWidth=YES;
    self.cityStateLabel.textAlignment=NSTextAlignmentCenter;
    
    self.cityStateLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.cityStateLabel.textColor=_myGreen;
    self.cityStateLabel.backgroundColor = [UIColor clearColor];
    //self.cityStateLabel.editable=NO;
    [self.view addSubview:self.cityStateLabel];
    
    
    //UIButton* abvLabel = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.abvLabel setFrame:CGRectMake(50, 50, 100, 44)];
    
    //[self.view addSubview:abvLabel];
    
    
    
    self.abvLabel =[[UIButton alloc]init];
    self.abvLabel.userInteractionEnabled = NO;
    self.abvLabel.exclusiveTouch = NO;
    
    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        [self.abvLabel setFrame: CGRectMake(30,300,30,70)];
    //iphone 6
    else if (screenRect.size.width == 375)
        [self.abvLabel setFrame: CGRectMake(320, 540, 40, 40)];
    //iphone 6+
    else if (screenRect.size.width==414)
        [self.abvLabel setFrame: CGRectMake(30,300,30,70)];
    //other ?
    else
        [self.abvLabel setFrame: CGRectMake(250,385,60,30)];
    
    self.abvLabel.font=[UIFont fontWithName:@"Helvetica" size:15];
    //self.abvLabel.backgroundColor = [UIColor clearColor];
    //self.abvLabel.editable=NO;
    
    
    self.abvLabel.layer.borderWidth = 1.0f;
    self.abvLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self.view addSubview:self.abvLabel];
    
    
    
    self.ratingLabel =[[UIButton alloc]init];
    self.ratingLabel.userInteractionEnabled = NO;
    self.ratingLabel.exclusiveTouch = NO;
    
    
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        [self.ratingLabel setFrame: CGRectMake(30,300,30,70)];
    //iphone 6
    else if (screenRect.size.width == 375)
        [self.ratingLabel setFrame: CGRectMake(320, 540, 40, 40)];
    //iphone 6+
    else if (screenRect.size.width==414)
        [self.ratingLabel setFrame: CGRectMake(30,300,30,70)];
    //other ?
    else
        [self.ratingLabel setFrame: CGRectMake(250,320,60,30)];
    
    self.ratingLabel.font=[UIFont fontWithName:@"Helvetica" size:15];
    //self.abvLabel.backgroundColor = [UIColor clearColor];
    //self.abvLabel.editable=NO;
    
    
    self.ratingLabel.layer.borderWidth = 1.0f;
    self.ratingLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self.view addSubview:self.ratingLabel];
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)favbuttonPressed:(id)sender{
    [Brewery createEmployeeDirectory];
    //NSLog(@"bar before favorites archive:%@",self.bar);
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithArray:self.bar.favoriteBeers];
    [tempArray addObject:self.club];
    self.bar.favoriteBeers=tempArray;
    [Brewery saveBrewery:self.bar];
    [sender removeFromSuperview];
    [self dataRetrieved];
}

-(void)rateButtonPressed:(id)sender{
    /*
    [Brewery createEmployeeDirectory];
    //NSLog(@"bar before favorites archive:%@",self.bar);
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithArray:self.bar.ratedBeers];
    [tempArray addObject:self.club];
    self.bar.ratedBeers=tempArray;
    [Brewery saveBrewery:self.bar];
    [sender removeFromSuperview];
    [self dataRetrieved];
     */
    
        RatePageViewController *RatePageVC=[[RatePageViewController alloc]init];
        RatePageVC.idPressed=self.idPressed;
        [[self navigationController] pushViewController:RatePageVC animated:YES];

    
}


-(void)unfavbuttonPressed:(id)sender{
    self.bar=[Brewery getBrewery];
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithArray:self.bar.favoriteBeers];
    [tempArray removeObject:self.club];
    [tempArray enumerateObjectsUsingBlock: ^(id obj,NSUInteger idx,BOOL *stop) {
        Brewery* currentObject = (Brewery*)(obj);
        if ([currentObject.nameDetail isEqualToString: self.club.nameDetail] && [currentObject.companyDetail isEqualToString: self.club.companyDetail]) {
            *stop = YES;
            [tempArray removeObject: currentObject];
        }
    }];
    self.bar.favoriteBeers=[[NSArray alloc]initWithArray:tempArray];
    [Brewery saveBrewery:self.bar];
    [sender removeFromSuperview];
    [self dataRetrieved];
}

-(void)unrateButtonPressed:(id)sender{
    self.bar1=[Brewery getBrewery];
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithArray:self.bar1.ratedBeers];
    [tempArray removeObject:self.club];
    [tempArray enumerateObjectsUsingBlock: ^(id obj,NSUInteger idx,BOOL *stop) {
        Brewery* currentObject = (Brewery*)(obj);
        if ([currentObject.nameDetail isEqualToString: self.club.nameDetail] && [currentObject.companyDetail isEqualToString: self.club.companyDetail]) {
            *stop = YES;
            [tempArray removeObject: currentObject];
        }
    }];
    self.bar1.ratedBeers=[[NSArray alloc]initWithArray:tempArray];
    [Brewery saveBrewery:self.bar1];
    [sender removeFromSuperview];
    [self dataRetrieved];
}

-(void)typeButtonPressed:(id)sender{
    TypeViewController *typeVC=[[TypeViewController alloc]init];
    typeVC.typeName=self.club.typeName;
    typeVC.typePhot=self.club.typePhot;
    typeVC.typeDesc=self.club.typeDesc;
    [[self navigationController] pushViewController:typeVC animated:YES];
}
@end
