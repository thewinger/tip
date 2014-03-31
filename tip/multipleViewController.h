//
//  multipleViewController.h
//  tip
//
//  Created by Win on 28/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface multipleViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIFloatLabelTextField *tipTF;

@property (nonatomic, strong) NSMutableArray *selectedEmployees;

- (IBAction)close:(id)sender;

@end
