//
//  OutletsTableViewCell.h
//  asap
//
//  Created by Hari on 12/09/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutletsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *deliverTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end
