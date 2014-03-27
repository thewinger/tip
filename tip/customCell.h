//
//  customCell.h
//  tip
//
//  Created by Win on 25/03/14.
//  Copyright (c) 2014 TIP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *infoView;
@property(nonatomic, strong) UILabel *cellName;
@property(nonatomic, strong) UILabel *cellPosition;
@property(nonatomic, strong) UILabel *cellRestaurant;

@end
