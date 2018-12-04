//
//  CheckOutViewController.h
//  asap
//
//  Created by Hari on 01/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckOutViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
- (IBAction)continueBtn:(UIButton *)sender;
- (IBAction)viewCartBtn:(UIButton *)sender;
- (IBAction)changeAddressBtn:(UIButton *)sender;
- (IBAction)creatGropBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *houseNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITableView *groupListTableView;

@end
