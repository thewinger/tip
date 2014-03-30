//
//  multipleViewController.m
//  tip
//
//  Created by Win on 28/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import "multipleViewController.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"

@interface multipleViewController (){
    UIAlertView *confirmationAV;
    UIAlertView *doneAV;
}
@property (assign) int numberOfEmployees;
@property (strong, nonatomic) NSString *texto;
@end

@implementation multipleViewController
@synthesize tipTF, textLabel, selectedEmployees;

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
    
    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 40.0f, 300.0f, 150.0f)];
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.font = [UIFont systemFontOfSize:16.0f];
    textLabel.numberOfLines = 0;
    textLabel.textColor = [UIColor whiteColor];
    if ([self.selectedEmployees count] == 1) {
        NSString *labelText = [NSString stringWithFormat:@"You have selected %i employee,\nyour TIP will be divided between them.", [self.selectedEmployees count]];
        textLabel.text = labelText;
    } else {
        NSString *labelText = [NSString stringWithFormat:@"You have selected %i employees,\nyour TIP will be divided between them.", [self.selectedEmployees count]];
        textLabel.text = labelText;
    }
    
    
    [self.view addSubview:textLabel];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    
    [[UIFloatLabelTextField appearance] setBackgroundColor:[UIColor colorWithRed:76.0f/255.0f green:217.0f/255.0f blue:100.0f/255.0f alpha:1.0f]];
    tipTF = [UIFloatLabelTextField new];
    tipTF.frame = CGRectMake(10.0f, 170.0f, 300.0f, 45.0f);
    tipTF.font = [UIFont systemFontOfSize:20.0f];
    tipTF.textAlignment = NSTextAlignmentCenter;
    tipTF.keyboardType = UIKeyboardTypeNumberPad;
    tipTF.textColor = [UIColor whiteColor];
    tipTF.tintColor = [UIColor colorWithRed:37.0f/255.0f green:108.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
    tipTF.placeholder = @"Introduce your TIP";
    
    if ([tipTF respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        tipTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:tipTF.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    tipTF.clearButtonMode = UITextFieldViewModeNever;
    tipTF.floatLabelActiveColor = [UIColor whiteColor];
    tipTF.floatLabelPassiveColor = [UIColor whiteColor];
    tipTF.delegate = self;
    [self.view addSubview:tipTF];

    //Add bottom border
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 43.0f, tipTF.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [tipTF.layer addSublayer:bottomBorder];
    
    tipTF.inputAccessoryView = [[UIView alloc] init];
    
    [tipTF addRightLeftOnKeyboardWithTarget:self leftButtonTitle:@"Back" rightButtonTitle:@"TIP" rightButtonAction:@selector(tipAction:) leftButtonAction:@selector(close:)];
    
    [tipTF becomeFirstResponder];

    
    
    
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

- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)tipAction:(id)sender {
    confirmationAV = [[UIAlertView alloc] initWithTitle:@"TIP Security" message:@"Please enter your PIN code" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    confirmationAV.tag = 2;
    confirmationAV.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [confirmationAV textFieldAtIndex:0].delegate = self;
    [confirmationAV textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    [confirmationAV show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == confirmationAV) {
        if (buttonIndex == 0) {
            [confirmationAV dismissWithClickedButtonIndex:0 animated:YES];
        } else {
            [confirmationAV dismissWithClickedButtonIndex:1 animated:YES];
            doneAV = [[UIAlertView alloc] initWithTitle:@"YUHU!" message:@"Your TIP has been made" delegate:self cancelButtonTitle:@"Finish" otherButtonTitles:nil];
            [doneAV show];
        }
    } else if (alertView == doneAV) {
        if (buttonIndex == 0) {
            [doneAV dismissWithClickedButtonIndex:0 animated:YES];
            [tipTF resignFirstResponder];
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.texto = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"%@", self.texto);
    
    if ([self.texto hasPrefix:@"£"]) {
        return YES;
    } else {
        textField.text = [NSString stringWithFormat:@"£%@", self.texto];
    }
    return NO;
}

@end
