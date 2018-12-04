

#import "LogInViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "TabBarViewController.h"
#import "RegisterViewController.h"
#import "ForSelectingBarvagesViewController.h"
#import "NetWork.h"
@interface LogInViewController ()
//@property (nonatomic, retain) NSOperationQueue *operationQueue;
@end

@implementation LogInViewController
#pragma mark Methods For View
- (void)viewDidLoad {
    [super viewDidLoad];
    //_operationQueue = [[NSOperationQueue alloc] init];
    self.userNameTF.delegate = self;
    self.passwordTF.delegate = self;
    
    //================GMail login===================//
    [GIDSignIn sharedInstance].uiDelegate = self;
    GIDSignInButton*gmailSigninBT = [[GIDSignInButton alloc]initWithFrame:CGRectMake(0, 0, self.gmailView.frame.size.width, self.gmailView.frame.size.height)];
    gmailSigninBT.alpha = 0.02;
    [self.gmailView addSubview:gmailSigninBT];
    
   //================facebook login===================//
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.frame = CGRectMake(0, 0, self.FBView.frame.size.width, self.FBView.frame.size.height);
    loginButton.alpha = 0.02;
    [self.FBView addSubview:loginButton];
    self.sigInBt.layer.cornerRadius = 8;
   self.userNameTF.text = @"8555979257";
    self.passwordTF.text = @"Naga@123";
     [self.sigInBt addTarget:self action:@selector(forLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.sigUpBT addTarget:self action:@selector(forSigUpAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewDidAppear:(BOOL)animated
{

   // self.sigInBt.alpha = 0.5;
   // [self.sigInBt setUserInteractionEnabled:NO];
     [self.passwordTF setUserInteractionEnabled:YES];
    // Gmail User Data
    [self.navigationController setNavigationBarHidden:YES];
    NSUserDefaults*currentDefault = [NSUserDefaults standardUserDefaults];
    NSString*userID = [currentDefault objectForKey:@"userId"];
    NSString*IDToken = [currentDefault objectForKey:@"idToken"];
    NSString*fullName = [currentDefault objectForKey:@"fullName"];
    NSString*givenName = [currentDefault objectForKey:@"givenName"];
    NSString*familyName = [currentDefault objectForKey:@"familyName"];
    NSString*email = [currentDefault objectForKey:@"email"];
    
    NSLog(@"userID:%@",userID);
    NSLog(@"IDToken:%@",IDToken);
    NSLog(@"fullName:%@",fullName);
    NSLog(@"givenName:%@",givenName);
    NSLog(@"familyName:%@",familyName);
    NSLog(@"email:%@",email);
    
    [[GIDSignIn sharedInstance] signOut];
    [[GIDSignIn sharedInstance] disconnect];
    
    // Facebook user Data
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,first_name,last_name,email,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSString * email = [result valueForKey:@"email"];
                NSLog(@"facebook email of the user  is  %@",email);
                
                NSString *nameOfLoginUser = [result valueForKey:@"name"];
                NSLog(@"facebook name of the user  is  %@",nameOfLoginUser);
                NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                NSLog(@"facebook image of the user  is  %@",imageStringOfLoginUser);
                //                NSURL *url = [[NSURL alloc] initWithURL: imageStringOfLoginUser];
                //                [self.imageView setImageWithURL:url placeholderImage: nil];
            }
        }];
        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [[GIDSignIn sharedInstance] signOut];
    [[GIDSignIn sharedInstance] disconnect];
}
#pragma mark For text field delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.userNameTF.text.length == 0)
    {
        self.passwordTF.text = @"";
        self.sigInBt.alpha = 0.5;
        [self.sigInBt setUserInteractionEnabled:NO];
        
    }
    
//    if([self.passwordTF.text isEqualToString: @""])
//    {
//        self.sigInBt.alpha = 0.5;
//        [self.sigInBt setEnabled:YES];
//    }
//    else
//    {
//        self.sigInBt.alpha = 1.0;
//        [self.sigInBt setEnabled:NO];
//    }
    
//    if !text.isEmpty{
//        continueButton.userInteractionEnabled = true
//    } else {
//        continueButton.userInteractionEnabled = false
//    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.userNameTF.text isEqualToString:@""]) {
        //[self.passwordTF setUserInteractionEnabled:NO];
    }
    else
    {
         //[self.passwordTF setUserInteractionEnabled:NO];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2) {
        if(self.userNameTF.text == nil || [self.userNameTF.text isEqualToString:@""])
        {
            self.passwordTF.text = @"";
            return NO;
        }
        else
        {
            self.sigInBt.alpha = 1.0;
            [self.sigInBt setUserInteractionEnabled:YES];
            //[self.passwordTF setUserInteractionEnabled:YES];
            return YES;
        }
    }
    else
    {
        return  YES;
    }
}
#pragma mark For Button Action
-(void)forSigUpAction
{
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterViewController*registerView = [storyBoard instantiateViewControllerWithIdentifier:@"registerID"];
    [self.navigationController pushViewController:registerView animated:YES];
}
-(void)forLoginButton
{
//    if ([self.userNameTF.text isEqualToString:@"SRIHARI"] && [self.passwordTF.text isEqualToString:@"12345678"]) {
//        UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ForSelectingBarvagesViewController*viewController = [storyBoard instantiateViewControllerWithIdentifier:@"forSelectingBarvagesID"];
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
    [self forLoginAPI];
}
//http://asapfood.in/dev/api/login?mobile=7416842094&password=1234

-(void)forLoginAPI
{

    [[NetWork networkManager]ForLoginUrl:@"http://asapfood.in/dev/api/login" withParam:@{@"mobile":self.userNameTF.text,@"password":self.passwordTF.text} complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSString*message = jsonDict[@"message"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([jsonDict[@"responseCode"] integerValue] == 0) {
                        UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        ForSelectingBarvagesViewController*viewController = [storyBoard instantiateViewControllerWithIdentifier:@"forSelectingBarvagesID"];
                        [self.navigationController pushViewController:viewController animated:YES];
                    }
                    else
                    {
                        [self showAlert:@"error" message:message];
                    }
                });
    }];
//    [[NetWork networkManager]logIn:@{@"mobile":self.userNameTF.text,@"password":self.passwordTF.text} complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
//     //   NSLog(@"hence login data is ==== %@ ",jsonDict[@"message"]);
//       // NSLog(@"data from server is %@",jsonDict);
//        NSString*message = jsonDict[@"message"];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if ([message isEqualToString:@"login success"]) {
//            NSLog(@"%@",message);
//                UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                ForSelectingBarvagesViewController*viewController = [storyBoard instantiateViewControllerWithIdentifier:@"forSelectingBarvagesID"];
//                [self.navigationController pushViewController:viewController animated:YES];
//            }
//            else
//            {
//                [self showAlert:@"error" message:message];
//            }
//        });
//
//    }];
}

// Present a view that prompts the user to sign in with Google
#pragma mark For Google Sigin
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    //  [myActivityIndicator stopAnimating];
}
@end
