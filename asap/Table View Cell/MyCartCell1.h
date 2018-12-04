//
//  MyCartCell1.h
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldingTableView.h"
@interface MyCartCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberOfItemsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmoutOfItem;
@property (weak, nonatomic) IBOutlet UILabel *priceOfItem;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UIImageView *resturentImage;
@property (weak, nonatomic) IBOutlet UIView *addOrSubView;

@property (weak, nonatomic) IBOutlet CartBtn *plusCartButton;
@property (weak, nonatomic) IBOutlet CartBtn *subCartButton;

@end
