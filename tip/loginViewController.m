//
//  loginViewController.m
//  tip
//
//  Created by Win on 28/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import "loginViewController.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"
#import <QuartzCore/QuartzCore.h>

@interface loginViewController ()


@end

@implementation loginViewController
@synthesize userTF, passTF, loginButton;

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:76.0f/255.0f green:217.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(100.0f, 55.0f, 120.0f, 120.0f)];
    iconView.image = [UIImage imageNamed:@"Icon"];
    [self.view addSubview:iconView];
    
    
    
    
    [[UIFloatLabelTextField appearance] setBackgroundColor:[UIColor colorWithRed:76.0f/255.0f green:217.0f/255.0f blue:100.0f/255.0f alpha:1.0f]];
    userTF = [UIFloatLabelTextField new];
    userTF.frame = CGRectMake(10.0f, 240.0f, 300.0f, 45.0f);
    userTF.font = [UIFont systemFontOfSize:20.0f];
    userTF.textColor = [UIColor whiteColor];
    userTF.tintColor = [UIColor colorWithRed:37.0f/255.0f green:108.0f/255.0f blue:49.0f/255.0f alpha:1.0f];

    userTF.placeholder = @"Username";
    
    if ([userTF respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        userTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:userTF.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    userTF.floatLabelActiveColor = [UIColor whiteColor];
    userTF.floatLabelPassiveColor = [UIColor whiteColor];
    
    passTF = [UIFloatLabelTextField new];
    passTF.frame = CGRectMake(10.0f, 290.0f, 300.0f, 45.0f);
    passTF.font = [UIFont systemFontOfSize:20.0f];
    passTF.textColor = [UIColor whiteColor];
    passTF.tintColor = [UIColor colorWithRed:37.0f/255.0f green:108.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
    
    passTF.secureTextEntry = YES;
    passTF.placeholder = @"Password";
    
    if ([passTF respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        passTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:passTF.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    passTF.floatLabelActiveColor = [UIColor whiteColor];
    passTF.floatLabelPassiveColor = [UIColor whiteColor];
    
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(110.0f, 340.0f, 100.0f, 60.0f)];
    [loginButton setTitle:@"Log In" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:userTF];
    [self.view addSubview:passTF];
    [self.view addSubview:loginButton];
    
    //Add bottom border
    CALayer *bottomBorderUser = [CALayer layer];
    CALayer *bottomBorderPass = [CALayer layer];
    
    bottomBorderUser.frame = CGRectMake(0.0f, 43.0f, userTF.frame.size.width, 1.0f);
    bottomBorderPass.frame = CGRectMake(0.0f, 43.0f, passTF.frame.size.width, 1.0f);
    bottomBorderUser.backgroundColor = [UIColor whiteColor].CGColor;
    bottomBorderPass.backgroundColor = [UIColor whiteColor].CGColor;
    [userTF.layer addSublayer:bottomBorderUser];
    [passTF.layer addSublayer:bottomBorderPass];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setShouldToolbarUsesTextFieldTintColor:NO];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
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

-(void)loginButtonPressed {
    [self performSegueWithIdentifier:@"toNavigationController" sender:self];
}


@end
