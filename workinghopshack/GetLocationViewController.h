//
//  GetLocationViewController.h
//  hopshack
//
//  Created by Blake Butterworth on 1/31/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface GetLocationViewController : UIViewController
@property (strong,nonatomic) NSArray *place;
@property (strong,nonatomic) NSString *tempcurrentState;
@property (strong,nonatomic) NSString *currentState;

@property (strong,nonatomic) IBOutlet UITextField *zipField;
//@property (strong,nonatomic) UITextField *zipField;


@end
