//
//  PaymentViewController.m
//  asap
//
//  Created by Hari on 03/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentTableViewCell.h"
#import "SucessViewController.h"

@interface PaymentViewController ()
@property NSArray*titleArray;
@property NSArray*subTitleArray;
@end

@implementation PaymentViewController
#pragma mark Methods For View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = @[@"Cash",@"Wallet",@"Cards",@"Net Banking"];
    self.subTitleArray =@[@"Cash on Delivery",@"Paytm",@"Debit Card & Credit Card",@"Pay directly from your bank"];
    // Do any additional setup after loading the view.
}
#pragma mark Methods For TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaymentTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentTableViewCell"];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.subTitleLabel.text = self.subTitleArray[indexPath.row];
    cell.layer.cornerRadius = 8;
    cell.clipsToBounds = YES;
    cell.layer.borderWidth = 8;
    cell.layer.borderColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1].CGColor;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)confirmOrderBtn:(UIButton *)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SucessViewController*SucessVc = [storyBoard instantiateViewControllerWithIdentifier:@"SucessViewController"];
    [self.navigationController pushViewController:SucessVc animated:YES];
}
@end
