//
//  CurrentOrderViewController.m
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "CurrentOrderViewController.h"

@interface CurrentOrderViewController ()

@end

@implementation CurrentOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.currentOrderTableView.layer.borderWidth = 1;
    //self.currentOrderTableView.layer.borderColor = (UIColor.blackColor).CGColor;
    self.contactUsBT.layer.cornerRadius = 8;
    self.cookingView.layer.cornerRadius = 10;
    self.deliveryView.layer.cornerRadius = 10;
    self.homeView.layer.cornerRadius = 10;
    self.currentOrderTableView.separatorColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"currentOrder" forIndexPath:indexPath];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    label.text = @"Items";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}
@end
