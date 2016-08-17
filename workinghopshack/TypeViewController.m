//
//  TypeViewController.m
//  HopshackFinal
//
//  Created by Blake Butterworth on 12/18/14.
//  Copyright (c) 2014 Blake Butterworth. All rights reserved.
//

#import "TypeViewController.h"

@interface TypeViewController ()

@end

@implementation TypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"wood2"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    UIImageView *glassView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.typePhot]];
    glassView.userInteractionEnabled = NO;
    glassView.exclusiveTouch = NO;
    [glassView setContentMode:UIViewContentModeScaleAspectFill];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        glassView.frame=CGRectMake(140, 100, 50, 70);
    //iphone 6
    else if (screenRect.size.width == 375)
        glassView.frame=CGRectMake(160, 110, 50, 100);
    //iphone 6+
    else if (screenRect.size.width==414)
        glassView.frame=CGRectMake (180, 125, 50, 70);
    //other ?
    else
        glassView.frame=CGRectMake(140, 110, 50, 80);

    [self.view addSubview:glassView];

}
- (void)viewDidAppear:(BOOL)animated{
    self.descriptionLabel =[[UITextView alloc]init];
    self.descriptionLabel.exclusiveTouch = NO;
    
    //
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //iphone 5
    if (screenRect.size.width == 320 && screenRect.size.height == 568)
        self.descriptionLabel.frame= CGRectMake(12,200,300,350);
    //iphone 6
    else if (screenRect.size.width == 375)
        self.descriptionLabel.frame= CGRectMake(30,220,300,350);
    //iphone 6+
    else if (screenRect.size.width==414)
        self.descriptionLabel.frame= CGRectMake(35,230,375,400);
    //other ?
    else
        self.descriptionLabel.frame= CGRectMake(12,220,300,175);
    
    
    self.descriptionLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
    [self.descriptionLabel setUserInteractionEnabled:YES];
    [self.descriptionLabel setScrollEnabled:YES];
    
    self.descriptionLabel.backgroundColor=[UIColor clearColor];
    self.descriptionLabel.editable=NO;
    self.descriptionLabel.text=self.typeDesc;
    
    self.descriptionLabel.layer.borderWidth = 1.0f;
    self.descriptionLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [self.view addSubview:self.descriptionLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
