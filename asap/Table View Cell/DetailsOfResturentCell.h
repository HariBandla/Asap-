//
//  DetailsOfResturentCell.h
//  asap
//
//  Created by Hari on 03/09/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsOfResturentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameOfItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOfItemLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vegOrNonVegImage;
@property (weak, nonatomic) IBOutlet UIButton *AddButton;

@end
