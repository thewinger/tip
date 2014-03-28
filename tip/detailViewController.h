//
//  detailViewController.h
//  tip
//
//  Created by Win on 27/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *nameDetail;
@property (strong, nonatomic) IBOutlet UIImageView *imageDetail;
@property (strong, nonatomic) IBOutlet UILabel *positionDetail;
@property (strong, nonatomic) IBOutlet UILabel *restaurantDetail;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *restaurant;
@property (strong, nonatomic) IBOutlet UIView *cardView;
@property (strong, nonatomic) UIFloatLabelTextField *tipTF;

- (IBAction)close:(id)sender;

@end
