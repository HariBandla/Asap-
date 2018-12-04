//
//  SucessViewController.m
//  asap
//
//  Created by Hari on 27/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "SucessViewController.h"
#import "HomeViewController.h"

@interface SucessViewController ()

@end

@implementation SucessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)onceAgain:(UIButton *)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController*homeVc = [storyBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:homeVc animated:YES];
}
@end
