//
//  RegisterViewController.h
//  asap
//
//  Created by Hari on 22/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface RegisterViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@end
