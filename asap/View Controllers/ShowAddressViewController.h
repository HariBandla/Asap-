//
//  ShowAddressViewController.h
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowAddressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)addNewAddressAction:(UIButton *)sender;
- (IBAction)backAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;

@end

@interface ShowAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *houseNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressTypeLabel;

@end
