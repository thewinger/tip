//
//  customCell.m
//  tip
//
//  Created by Win on 25/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import "customCell.h"



@implementation customCell
@synthesize imageView, infoView, cellName, cellPosition, cellRestaurant;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIFont* boldFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        
        self.autoresizingMask = UIViewAutoresizingNone;
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 145.0f, 120.0f)];
        infoView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 120.0f, 145.0f, 55.0f)];
        cellName = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 125.0f, 145.0f, 15.0f)];
        cellName.font = [UIFont systemFontOfSize:12];
        cellName.font = boldFont;
        cellName.tag= 200;
        
        cellPosition = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 140.0f, 145.0f, 15.0f)];
        cellPosition.font = [UIFont systemFontOfSize:10];
        cellPosition.tag = 200;
        
        cellRestaurant = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 155.0f, 145.0f, 15.0f)];
        cellRestaurant.font = [UIFont systemFontOfSize:10];
        cellRestaurant.tag = 200;
        
        CGFloat borderWidth = 0.5f;
        CGRect myContentRect = CGRectInset(self.contentView.bounds, 0, 0);
        
        UIView *myContentView = [[UIView alloc] initWithFrame:myContentRect];
        myContentView.backgroundColor = [UIColor clearColor];
        myContentView.layer.borderColor = [UIColor colorWithRed:212.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1.0f].CGColor;
        myContentView.layer.borderWidth = borderWidth;
    
        CGFloat borderWithBg = 1.0f;
        UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
        bgView.backgroundColor = [UIColor clearColor];
        bgView.layer.borderColor = [UIColor redColor].CGColor;
        bgView.layer.borderWidth = borderWithBg;
       // self.selectedBackgroundView = bgView; //Para los cell seleccionados
        
        [self.contentView addSubview:imageView];
        [self.contentView addSubview:cellName];
        [self.contentView addSubview:cellPosition];
        [self.contentView addSubview:cellRestaurant];
        [self.contentView addSubview:myContentView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
