//
//  TabBarViewController.m
//  asap
//
//  Created by Hari on 20/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()
@property (weak, nonatomic) IBOutlet UITabBar *tabBarItem;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[tabBar setSelectedItem: [tabBar.items objectAtIndex:0]];
   // [self.tabBarItem setSelectedItem:[self.tabBarItem.items objectAtIndex:1]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
