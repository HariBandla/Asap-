//
//  OrderDetailTableViewCell.h
//  asap
//
//  Created by Hari on 20/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *orderSegmentView;
@property (weak, nonatomic) IBOutlet UITextView *orderTextView;

@end
