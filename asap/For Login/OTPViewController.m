
#import "OTPViewController.h"
#import "NetWork.h"
@interface OTPViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UITextField *thirdTextField;
@property (weak, nonatomic) IBOutlet UITextField *forthTextField;
@end

@implementation OTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self toSendOTP];
    // Do any additional setup after loading the view.
    self.view1.layer.cornerRadius = self.view1.frame.size.width/2;
    self.view2.layer.cornerRadius =self.view2.frame.size.width/2;
    self.view3.layer.cornerRadius =self.view3.frame.size.width/2;
    self.view4.layer.cornerRadius =self.view4.frame.size.width/2;
    self.forthTextField.delegate = self;
    self.secondTextField.delegate = self;
    self.thirdTextField.delegate = self;
    self.firstTextField.delegate = self;
}
- (IBAction)submitAction:(UIButton *)sender {
    [self toverificationOTP];
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self toverificationOTP];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * enteredString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(enteredString.length > 1)
    {
        UITextField *tf = ([self.firstTextField isEqual:textField]?self.secondTextField:(([self.secondTextField isEqual:textField]?self.thirdTextField:self.forthTextField)));
        [tf becomeFirstResponder];
        
        NSString *tfText = nil;
        if(tf.text.length >= range.location)
            tfText = [tf.text stringByReplacingCharactersInRange:range withString:string];
        if(tfText.length > 1 || [self.forthTextField isEqual:textField])
        {
            return NO;
        }
    }
    return YES;
}
-(void)toSendOTP
{
    [[NetWork networkManager]toSendOTP:@{@"mobile":self.userDetails[@"phone"],@"otp_type":@"1",@"device_type":@"3"} complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"message is %@",jsonDict);
    }];
}
-(void)toverificationOTP
{
    NSString*otpString = [NSString stringWithFormat:@"%@%@%@%@",self.firstTextField.text,self.secondTextField.text,self.thirdTextField.text,self.forthTextField.text];
    
    [[NetWork networkManager]otpVerification:@{@"mobile":self.userDetails[@"phone"],@"name": self.userDetails[@"name"],@"email":self.userDetails[@"email"],@"password":self.userDetails[@"password"],@"otp_type":@"1",@"device_type":@"2",@"otp":otpString} complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
        if ([jsonDict[@"responseCode"] integerValue] == 0) {
            [self showAlert:@"Success" message:jsonDict[@"message"]];
        }
        else
        {
            [self showAlert:@"Fail" message:jsonDict[@"message"]];
        }
        NSLog(@"message is %@",jsonDict);
          });
    }];
}
@end
