//
//  loginViewController.h
//  tip
//
//  Created by Win on 28/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController


@property (strong, nonatomic) UIFloatLabelTextField *userTF;
@property (strong, nonatomic) UIFloatLabelTextField *passTF;
@property (strong, nonatomic) UIButton *loginButton;

-(void)loginButtonPressed;

@end
