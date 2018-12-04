//
//  LogInViewController.h
//  asap
//
//  Created by Hari on 02/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@import GoogleSignIn;

@interface LogInViewController : BaseViewController<GIDSignInUIDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *gmailView;
@property (weak, nonatomic) IBOutlet UIView *FBView;
@property (weak, nonatomic) IBOutlet UIButton *sigInBt;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *sigUpBT;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;

@end
