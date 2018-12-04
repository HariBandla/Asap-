//
//  AddAddressViewController.h
//  asap
//
//  Created by Kardas Veeresham on 11/19/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AddAddressViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *houseNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *areaTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *landMarkTextField;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction)pikerBtnAction:(UIButton *)sender;
@property NSString * addNewData;

@property NSDictionary* editAddressData;
@property NSString*cellId;

- (IBAction)submitBtn:(UIButton *)sender;
- (IBAction)backButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *pickerScreenView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)pickerDoneButton:(UIButton *)sender;
@end
