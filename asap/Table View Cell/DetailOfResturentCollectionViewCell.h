//
//  DetailOfResturentCollectionViewCell.h
//  asap
//
//  Created by Hari on 23/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailOfResturentCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *forAddingCount;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)plusAction:(UIButton *)sender;
- (IBAction)subAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *numberOfItemsLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)addAction:(UIButton *)sender;

@end
