//
//  TIPViewController.m
//  tip
//
//  Created by Win on 25/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import "TIPViewController.h"
#import "customCell.h"

static NSString * const BaseURLString = @"http://experiences-events.com/tip/consulta.php";


@interface TIPViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *employeesArray;
@property (nonatomic, strong) NSDictionary *employeesDict;
@property(nonatomic, strong) NSArray *items;

@end

@implementation TIPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
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
            self.collectionView.allowsMultipleSelection = YES;
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
    cell.backgroundColor = [UIColor whiteColor];
    NSString *picURL = [[self.employeesArray objectAtIndex:indexPath.item] objectForKey:@"pic_url"];
    [cell.imageView setImageWithURL:[NSURL URLWithString:picURL]];
    cell.cellName.text = [[self.employeesArray objectAtIndex:indexPath.item] objectForKey:@"name"];
    NSLog(@"%@", cell.cellName.text);
    cell.cellPosition.text = [[self.employeesArray objectAtIndex:indexPath.item] objectForKey:@"position"];
    cell.cellRestaurant.text = [[self.employeesArray objectAtIndex:indexPath.item] objectForKey:@"restaurant"];
    return cell;
}

/*-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    customCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
}
*/
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

@end
