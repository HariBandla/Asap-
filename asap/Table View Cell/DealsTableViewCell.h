//
//  DealsTableViewCell.h
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *coupenCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *coupenPersentageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *offerImage;
@end
