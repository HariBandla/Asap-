
#import "ForSelectingBarvagesViewController.h"
#import "HomeViewController.h"
#import "TabBarViewController.h"
@interface ForSelectingBarvagesViewController ()

@end

@implementation ForSelectingBarvagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    //[self.navigationController setNavigationBarHidden:NO];
    
}
- (IBAction)beveragesAction:(id)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TabBarViewController*homeView = [storyBoard instantiateViewControllerWithIdentifier:@"TabbarId"];
   // homeView.numberToSelect = @"1";
    homeView.selectedViewController = homeView.viewControllers[1];
    [self.navigationController pushViewController:homeView animated:YES];
}
- (IBAction)foodAction:(UIButton *)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TabBarViewController*homeView = [storyBoard instantiateViewControllerWithIdentifier:@"TabbarId"];
 homeView.selectedViewController = homeView.viewControllers[0];
    [self.navigationController pushViewController:homeView animated:YES];
}

- (IBAction)bookATableAction:(UIButton *)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TabBarViewController*homeView = [storyBoard instantiateViewControllerWithIdentifier:@"TabbarId"];
 homeView.selectedViewController = homeView.viewControllers[3];    [self.navigationController pushViewController:homeView animated:YES];
}

- (IBAction)dealsAction:(id)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TabBarViewController*homeView = [storyBoard instantiateViewControllerWithIdentifier:@"TabbarId"];
 homeView.selectedViewController = homeView.viewControllers[4];    [self.navigationController pushViewController:homeView animated:YES];
}
@end
