//
//  TIPViewController.m
//  tip
//
//  Created by Win on 25/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import "TIPViewController.h"
#import "detailViewController.h"
#import "customCell.h"

static NSString * const BaseURLString = @"http://experiences-events.com/tip/consulta.php";


@interface TIPViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *employeesArray;
@property (nonatomic, strong) NSDictionary *employeesDict;
@property (assign) NSInteger selectedCellIndex;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIImage *cellImage;
@property (nonatomic, strong) NSString *cellName;
@property (nonatomic, strong) NSString *cellPosition;
@property (nonatomic, strong) NSString *cellRestaurant;
@property (nonatomic, strong) NSMutableArray *selectedEmployees;
@property (nonatomic, strong) UIBarButtonItem *splitButton;
@property (nonatomic) BOOL multipleEnable;

@end

@implementation TIPViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.selectedEmployees = [NSMutableArray array];
   // UIBarButtonItem *splitButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selectMultiple:)];
    self.splitButton = [[UIBarButtonItem alloc] initWithTitle:@"Split" style:UIBarButtonItemStylePlain
                                                                   target:self action:@selector(selectMultiple:)];

    self.splitButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.splitButton;
    
    
    // Creating URL
    NSString *string = [NSString stringWithString:BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Connecting
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Stuff when it works
        NSLog(@"done");
        
        
        if([responseObject isKindOfClass:[NSArray class]]){
            //Is array
            NSLog(@"es un array");
        }else if([responseObject isKindOfClass:[NSDictionary class]]){
            //is dictionary
            NSLog(@"es un dict");
//            Employee *employee = [[Employee alloc] init];
            
            self.employeesDict = (NSDictionary *)responseObject;
            self.employeesArray = (NSMutableArray *)[self.employeesDict objectForKey:@"employees"];
            
            
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            
            self.collectionView = [[UICollectionView alloc] initWithFrame:[self.view frame] collectionViewLayout:flowLayout];
            self.collectionView.backgroundColor =[UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
            
            [self.collectionView setContentInset:UIEdgeInsetsMake(65.0f, 0, 0, 0)];
            [self.collectionView setDataSource:self];
            [self.collectionView setDelegate:self];
            [self.collectionView registerClass:[customCell class] forCellWithReuseIdentifier:@"cell"];
            self.collectionView.allowsMultipleSelection = NO;
            [self.view addSubview:self.collectionView];
            
            
        }else{
            //is something else
            NSLog(@"no se que cojones es");
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //Stuff when doesn't work
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Employees"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertview show];
    }];
    
    [operation start];


    
}

#pragma mark - UICollectionView DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.employeesArray count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    customCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    NSString *picURL = [[self.employeesArray objectAtIndex:indexPath.item] objectForKey:@"pic_url"];
    [cell.imageView setImageWithURL:[NSURL URLWithString:picURL]];
    cell.cellName.text = [[self.employeesArray objectAtIndex:indexPath.item] objectForKey:@"name"];
    cell.cellPosition.text = [[self.employeesArray objectAtIndex:indexPath.item] objectForKey:@"position"];
    cell.cellRestaurant.text = [[self.employeesArray objectAtIndex:indexPath.item] objectForKey:@"restaurant"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCellIndex = indexPath.row;

    if (self.multipleEnable) {
        customCell *cell = (customCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.cellName.textColor = [UIColor whiteColor];
        cell.cellPosition.textColor = [UIColor whiteColor];
        cell.cellRestaurant.textColor = [UIColor whiteColor];
        //Determine the selected items by using the indexPath
        NSString *selectedEmployee = [self.employeesArray objectAtIndex:indexPath.item];
        //Add selected item into array
        [self.selectedEmployees addObject:selectedEmployee];
    } else {
    [self performSegueWithIdentifier:@"toDetailView" sender:self];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.multipleEnable) {
        NSString *deselectedEmployee = [self.employeesArray objectAtIndex:indexPath.item];
        [self.selectedEmployees removeObject:deselectedEmployee];
        customCell *cell = (customCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.cellName.textColor = [UIColor blackColor];
        cell.cellPosition.textColor = [UIColor blackColor];
        cell.cellRestaurant.textColor = [UIColor blackColor];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval = CGSizeMake(145.0f, 175.0f);
    return retval;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDetailView"]) {
        
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        detailViewController *destViewController = segue.destinationViewController;

        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        destViewController.name = [[self.employeesArray objectAtIndex:self.selectedCellIndex] objectForKey:@"name"];
        destViewController.position = [[self.employeesArray objectAtIndex:self.selectedCellIndex] objectForKey:@"position"];
        destViewController.restaurant = [[self.employeesArray objectAtIndex:self.selectedCellIndex] objectForKey:@"restaurant"];
        destViewController.imageURL = [[self.employeesArray objectAtIndex:self.selectedCellIndex] objectForKey:@"pic_url"];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
    
}
/*
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"toDetailView"]) {
        if (self.multipleEnable) {
            return NO;
        } else {
            return YES;
        }
    }
    return YES;
}
*/
- (IBAction)selectMultiple:(id)sender {
    
    if (self.multipleEnable) {
        NSLog(@"Disable");
        if ([self.selectedEmployees count] > 0) {
            //hacer algo
        }
        //deselect
        for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
        [self.selectedEmployees removeAllObjects];
        
        self.multipleEnable = NO;
        self.collectionView.allowsMultipleSelection = NO;
        [self.splitButton setTitle:@"Split"];
    } else {
        self.multipleEnable = YES;
        self.collectionView.allowsMultipleSelection = YES;
        [self.splitButton setTitle:@"TIP"];
        NSLog(@"Enable");
    }
}
@end
