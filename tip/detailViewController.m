//
//  detailViewController.m
//  tip
//
//  Created by Win on 27/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import "detailViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface detailViewController ()

@end

@implementation detailViewController
@synthesize imageDetail, imageURL, nameDetail, positionDetail, restaurantDetail, tipTF, cardView;

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
    [nameDetail setTextAlignment:NSTextAlignmentLeft];
    CGFloat borderWidth = 10.0f;
  
    cardView = [[UIView alloc] init];
    //cardView.layer.borderColor = [UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0f].CGColor;
    cardView.layer.borderColor = [UIColor redColor].CGColor;
    cardView.layer.borderWidth = borderWidth;
  
    [self.imageDetail setImageWithURL:[NSURL URLWithString:self.imageURL]];
    self.nameDetail.text = self.name;
    self.positionDetail.text = self.position;
    self.restaurantDetail.text = self.restaurant;
    
    [tipTF becomeFirstResponder];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
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

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
