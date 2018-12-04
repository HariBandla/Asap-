//
//  AddAddressViewController.m
//  asap
//
//  Created by Kardas Veeresham on 11/19/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "AddAddressViewController.h"
#import "NetWork.h"
#import "ProfileViewController.h"

@interface AddAddressViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@end
NSArray * pikerDataArray;
NSString * name;
@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController setNavigationBarHidden:YES];
    self.pickerScreenView.hidden = YES;
    
    pikerDataArray = @[@"Home",@"Office",@"Other"];
    
    self.houseNoTextField.text = self.editAddressData[@"house_no"];
     self.streetTextField.text = self.editAddressData[@"street_no"];
     self.areaTextField.text = self.editAddressData[@"area"];
     self.cityTextField.text = self.editAddressData[@"city"];
     self.landMarkTextField.text = self.editAddressData[@"land_mark"];
    if ([self.editAddressData[@"address_type"] length] == 0) {
        self.addressLabel.text = @"Select AddressType";
    }else
    {
        self.addressLabel.text = self.editAddressData[@"address_type"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.addressLabel.tag == 1) {
       // [self.pickerView reloadAllComponents];
        self.pickerScreenView.hidden = NO;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pikerDataArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    name = pikerDataArray[row];
    
    return name;
}


- (IBAction)pickerDoneButton:(UIButton *)sender {
    self.pickerScreenView.hidden = true;
    if ([name isEqualToString:@""]) {
        name = pikerDataArray[0];
    }
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@", name];
}
- (IBAction)submitBtn:(UIButton *)sender {
    NSString *successMsg = [self validateData];
    if(successMsg == nil)
    {
        if ([self.addNewData isEqualToString:@"addNew"]) {
            
            [self addAddressDataUrl];
        }
        else{
            [self editAddressdata];
        }
        
    }
    else{
        [self showAlert:@"Data Validation Failed!" message:successMsg];
    }
}

- (IBAction)backButton:(UIButton *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)addAddressDataUrl
{
    NSDictionary * params = @{@"userId":@"4998256",@"user_token":@"224ac6539f91b642e50c94df881013a9",@"house_no":self.houseNoTextField.text,@"street_no":self.streetTextField.text,@"area":self.areaTextField.text,@"city":self.cityTextField.text,@"land_mark":self.landMarkTextField.text,@"address_type":self.addressLabel.text};
    [[NetWork networkManager]AddAddressData:params complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"data %@",jsonDict);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProfileViewController*view = [storyBoard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
            
         //   [self.navigationController pushViewController:view animated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    }];
}

-(void)editAddressdata
{
    NSDictionary * params = @{@"userId":@"4998256",@"user_token":@"224ac6539f91b642e50c94df881013a9",@"house_no":self.houseNoTextField.text,@"street_no":self.streetTextField.text,@"area":self.areaTextField.text,@"city":self.cityTextField.text,@"land_mark":self.landMarkTextField.text,@"address_type":self.addressLabel.text,@"id":self.cellId};
    
    [[NetWork networkManager]getEditAddress:params complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"Addressdata %@",jsonDict);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProfileViewController*view = [storyBoard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });

    }];
}

-(NSString *)validateData
{
    NSString *successMessage = nil;
    
    if(!self.houseNoTextField.text.length)
    {
        successMessage = @"Please Enter HouseNumber";
        return successMessage;
    }
    
    if(!self.streetTextField.text.length)
    {
        successMessage = @"Please Enter StreetName";
        return successMessage;
    }
    
    if(!self.areaTextField.text.length)
    {
        successMessage = @"Please Enter AreaName";
        return successMessage;
    }
    
    if(!self.cityTextField.text.length)
    {
        successMessage = @"Please cityName";
        return successMessage;
    }
    
    if(!self.landMarkTextField.text.length)
    {
        successMessage = @"Please Enter LandMark";
        return successMessage;
    }
    
    if(!self.addressLabel.text.length)
    {
        successMessage = @"Please Enter AddressType";
        return successMessage;
    }
    return successMessage;
}

- (IBAction)pikerBtnAction:(UIButton *)sender {
     [self.pickerView reloadAllComponents];
    self.pickerScreenView.hidden = NO;
}
@end
