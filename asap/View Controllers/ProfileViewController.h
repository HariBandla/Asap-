//
//  ProfileViewController.h
//  asap
//
//  Created by Hari on 20/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)BackButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *maillabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumber;

- (IBAction)addAddressBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *transVc;
@property (weak, nonatomic) IBOutlet UIView *editPopUpVc;
@property (weak, nonatomic) IBOutlet UITextField *editFullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *editEmailTextField;
- (IBAction)editAdressSubmitBtnAction:(UIButton *)sender;
- (IBAction)editAddressOpenPopUpBtnAction:(UIButton *)sender;



@end
@interface ProfileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *addressTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *addressCelleditButton;


@end
