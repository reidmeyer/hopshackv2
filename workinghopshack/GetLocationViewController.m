//
//  GetLocationViewController.m
//  hopshack
//
//  Created by Blake Butterworth on 1/31/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import "GetLocationViewController.h"
#import "LocationResultTableViewController.h"

@import CoreLocation;
@import MapKit;


@interface GetLocationViewController ()  <CLLocationManagerDelegate,MKMapViewDelegate>
{
   CLLocationManager *locationManagerBlake;
    CLLocation *currentLocationBlake;
}
@property (strong,nonatomic)  MKMapView *map;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLLocation *location;
@property (assign,nonatomic) BOOL pendingAuthorization;

@end

@implementation GetLocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)viewDidAppear:(BOOL)animated{
    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Near Me";
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"wood2"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];

    
    self.zipField=[[UITextField alloc]init];
    
    
    
    self.zipField.frame=CGRectMake(20,200,150,40);
    self.zipField.backgroundColor=[UIColor whiteColor];
    self.zipField.borderStyle=UITextBorderStyleBezel;
    self.zipField.keyboardType=UIKeyboardTypeDefault;
    self.zipField.placeholder=@"Enter State";
    self.zipField.delegate=self;
    [self.view addSubview:self.zipField];

    self.pendingAuthorization = NO;
    locationManagerBlake = [CLLocationManager new];
    locationManagerBlake.delegate = self;
    //------
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    
    locationButton.frame = CGRectMake(150, 260, 150, 10);
    [locationButton setTitle:@"get my location" forState:UIControlStateNormal];
    [self.view addSubview:locationButton];
    [locationButton addTarget:self action:@selector(locationGet:)forControlEvents:UIControlEventTouchUpInside];
}
-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
 
}
-(void)locationGet:(id)sender
{
    NSLog(@"It gets to the locationGet method");
    // authorized
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.map setShowsUserLocation:YES];
        locationManagerBlake = [CLLocationManager new];
        locationManagerBlake.delegate = self;
        locationManagerBlake.distanceFilter = kCLDistanceFilterNone;
        locationManagerBlake.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManagerBlake startUpdatingLocation];
        NSLog(@"its authorized and does the stuff");

        }
    
    // not authorized
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusRestricted)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Location is not authorized or is currently restricted. You must change your Privacy --> Location settings to enable it again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        NSLog(@"its not authorized and does the stuff");

        return;
    }
    
    // needs authorization
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
        [locationManagerBlake requestWhenInUseAuthorization];
        self.pendingAuthorization = YES;
        NSLog(@"it needs authorization and does the stuff");

        return;
    }
    
    // other
    assert("Authorization status not valid. Please check all possible cases and fix the app!");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"gets to the location manager");

    currentLocationBlake = locationManagerBlake.location;
    [locationManagerBlake stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocationBlake completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             self.tempcurrentState=[placemark administrativeArea];
             NSLog(@"no error");

             //NSLog(@"%@",self.tempcurrentState);
            [self stateconvert:_tempcurrentState];

         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             
         }
         
     }];
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    // we call getLocation: again after the authorization request
    // if the user replied NO an error will be displayed, if the user replied YES the location will be displayed
    // NOTE: we must check for "pendingAuthorization" flag because the delegate is called immediately once the delegate
    // is set even if the user didn't tap the auth request button
    if(self.pendingAuthorization) {
        self.pendingAuthorization = NO;
        [self locationGet:nil];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.zipField) {
        //NSLog(@"%@",self.zipField.text);
        [textField resignFirstResponder];
        [self stateconvert:self.zipField.text];
        return NO;
    }
    return YES;
}

-(void)stateconvert:(NSString*)tempcurrentState
{
    
    if([tempcurrentState caseInsensitiveCompare:@"AL"]==0){
        self.currentState=@"alabama";
    }
    else if([tempcurrentState caseInsensitiveCompare:@"AK"] == 0){
        self.currentState=@"alaska";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"AZ"] == 0){
        self.currentState=@"arizona";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"AR"] == 0){
        self.currentState=@"arkansas";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"CA"] == 0){
        self.currentState=@"california";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"CO"] == 0){
        self.currentState=@"colorado";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"CT"] == 0){
        self.currentState=@"connecticut";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"DE"] == 0){
        self.currentState=@"delaware";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"FL"] == 0){
        self.currentState=@"florida";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"GA"] == 0){
        self.currentState=@"georgia";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"HI"] == 0){
        self.currentState=@"hawaii";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"ID"] == 0){
        self.currentState=@"idaho";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"IL"] == 0){
        self.currentState=@"illinois";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"IN"] == 0){
        self.currentState=@"indiana";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"IA"] == 0){
        self.currentState=@"iowa";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"KS"] == 0){
        self.currentState=@"kansas";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"KY"] == 0){
        self.currentState=@"kentucky";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"LA"] == 0){
        self.currentState=@"louisiana";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"ME"] == 0){
        self.currentState=@"maine";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"MD"] == 0){
        self.currentState=@"maryland";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"MA"] == 0){
        self.currentState=@"massachusetts";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"MI"] == 0){
        self.currentState=@"michigan";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"MN"] == 0){
        self.currentState=@"minnesota";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"MS"] == 0){
        self.currentState=@"mississippi";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"MO"] == 0){
        self.currentState=@"missouri";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"MT"] == 0){
        self.currentState=@"montana";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"NE"] == 0){
        self.currentState=@"nebraska";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"NV"] == 0){
        self.currentState=@"nevada";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"NH"] == 0){
        self.currentState=@"new hampshire";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"NJ"] == 0){
        self.currentState=@"new jersey";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"NM"] == 0){
        self.currentState=@"new mexico";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"NY"] == 0){
        self.currentState=@"new york";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"NC"] == 0){
        self.currentState=@"north carolina";
    }
    else if ([tempcurrentState caseInsensitiveCompare:  @"ND"] == 0){
        self.currentState=@"north dakota";
    }
    else if ([tempcurrentState caseInsensitiveCompare:   @"OH"] == 0){
        self.currentState=@"ohio";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"OK"] == 0){
        self.currentState=@"oklahoma";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"OR"] == 0){
        self.currentState=@"oregon";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"PA"] == 0){
        self.currentState=@"pennsylvania";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"RI"] == 0){
        self.currentState=@"rhode island";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"SC"] == 0){
        self.currentState=@"south carolina";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"SD"] == 0){
        self.currentState=@"south dakota";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"TN"] == 0){
        self.currentState=@"tennessee";
    }
    else if ([tempcurrentState caseInsensitiveCompare:@"TX"] == 0){
        self.currentState=@"texas";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"UT"] == 0){
        self.currentState=@"utah";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"VA"] == 0){
        self.currentState=@"virginia";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"VT"] == 0){
        self.currentState=@"vermont";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"WA"] == 0){
        self.currentState=@"washington";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"WV"] == 0){
        self.currentState=@"west virginia";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"WI"] == 0){
        self.currentState=@"wisconsin";
    }
    else if ([tempcurrentState caseInsensitiveCompare: @"WY"] == 0){
        self.currentState=@"wyoming";
    }
    
    else{
        self.currentState=tempcurrentState;
    }
    LocationResultTableViewController *locationResultTVC=[[LocationResultTableViewController alloc]init];
    locationResultTVC.stateResult=self.currentState;
    //NSLog(@"%@",locationResultTVC.stateResult);
    [[self navigationController]pushViewController:locationResultTVC animated:YES];

}


@end
