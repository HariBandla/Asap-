//
//  RegisterViewController.m
//  asap
//
//  Created by Hari on 22/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "NetWork.h"
#import "OTPViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.text = @"Srihari";
    self.emailTextField.text = @"sriharibandla@gmail.com";
    self.mobileNumberTextField.text = @"7977777777";
    self.passwordTextField.text = @"12345678";
    self.reEnterPasswordTF.text = @"12345678";
    [self.createButton addTarget:self action:@selector(forCreateAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(void)forCreateAction
{
    NSString *successMsg = [self validateData];
    if(successMsg == nil)
    {
        [self registerAccount];
    }
    else{
        [self showAlert:@"Data Validation Failed!" message:successMsg];
    }
}
-(void)registerAccount
{
    [[NetWork networkManager]Register:@{@"mobile":self.mobileNumberTextField.text,@"password":self.passwordTextField.text,@"device_type":@"3",@"name":self.nameTextField.text,@"email":self.emailTextField.text} complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"hence data is %@",jsonDict);
        if ([jsonDict[@"responseCode"] integerValue] == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                OTPViewController*otp = [storyBoard instantiateViewControllerWithIdentifier:@"otpViewControllerID"];
                otp.userDetails= @{@"name":self.nameTextField.text,@"phone":self.mobileNumberTextField.text,@"password":self.passwordTextField.text,@"email":self.emailTextField.text};
                [self.navigationController pushViewController:otp animated:YES];
            });
        }
        else
        {
            [self showAlert:@"Sorry" message:[jsonDict[@"message"] objectAtIndex:0]];
        }

    }];
  //  [NetWork networkManager]for
//    [[NetWork networkManager]Register:@{@"mobile":self.mobileNumberTextField.text,@"password":self.passwordTextField.text,@"device_type":@"3",@"name":self.nameTextField.text,@"email":self.emailTextField.text} complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
//        NSLog(@"HENCE DATA IS %@",jsonDict);
//    }];
}

-(NSString *)validateData
{
    NSString *successMessage = nil;
    
    if(!self.nameTextField.text.length)
    {
        successMessage = @"Please Enter User Name";
        return successMessage;
    }
    
    if(!self.emailTextField.text.length)
    {
        successMessage = @"Please Enter Email Addres";
        return successMessage;
    }
    else if(![BaseViewController isValideEmail:self.emailTextField.text])
    {
        successMessage = @"Please Enter Valid Email Addres";
    }
    
    if(!self.mobileNumberTextField.text.length)
    {
        successMessage = @"Please Enter Phone Number";
        return successMessage;
    }
    else if(![BaseViewController isValidePhonuNumber:self.mobileNumberTextField.text])
    {
        successMessage = @"Please Enter Valid Phone Number";
    }
    
    if(!self.passwordTextField.text.length)
    {
        successMessage = @"Please Enter Pasword";
        return successMessage;
    }
    
    if(!self.reEnterPasswordTF.text.length)
    {
        successMessage = @"Please Enter Confirm Pasword";
        return successMessage;
    }
    
    if(![self.passwordTextField.text isEqualToString:self.reEnterPasswordTF.text])
    {
        successMessage = @"Entered Password and Confirm Password not matched.";
        return successMessage;
    }
    return successMessage;
}
@end
