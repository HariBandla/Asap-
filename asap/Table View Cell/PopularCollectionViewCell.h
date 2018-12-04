//
//  PopularCollectionViewCell.h
//  asap
//
//  Created by Gopal Gundaram on 31/07/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopularCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *restarentItemImage;
@property (weak, nonatomic) IBOutlet UILabel *restarentName;
@property (weak, nonatomic) IBOutlet UILabel *layoutsLable;
@property (weak, nonatomic) IBOutlet UILabel *minOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
