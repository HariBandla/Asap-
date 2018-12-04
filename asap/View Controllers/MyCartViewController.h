//
//  MyCartViewController.h
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldingTableView.h"
@interface MyCartViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *gstLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliveryChargesLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *addOrSubView;
- (IBAction)checkOutBtn:(UIButton *)sender;
@property NSMutableArray * dataInCoreDataArray;
@end
