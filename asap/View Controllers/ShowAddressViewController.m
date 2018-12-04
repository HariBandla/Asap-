//
//  ShowAddressViewController.m
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "ShowAddressViewController.h"
#import "NetWork.h"

@implementation ShowAddressTableViewCell

@end

@interface ShowAddressViewController ()
@property NSArray * addressArray;
@end

@implementation ShowAddressViewController
#pragma mark Methods For View
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self getAddressListData];
}


#pragma mark Methods For TableViewDelegate
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
    ShowAddressTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"showAddressCellID" forIndexPath:indexPath];
    NSDictionary * itens  = self.addressArray[indexPath.row];
    cell.houseNoLabel.text = itens[@"house_no"];
    cell.streetNameLabel.text = itens[@"street_no"];
    cell.areaNameLabel.text = itens[@"area"];
    cell.cityNameLabel.text = itens[@"city"];
   // cell.phoneNumberLabel.text = itens[@"address_type"];
    cell.addressTypeLabel.text = itens[@"address_type"];
    
    cell.clipsToBounds = YES;
    cell.layer.cornerRadius = 4;
    cell.layer.borderWidth = 4;
    cell.layer.borderColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1].CGColor;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (IBAction)addNewAddressAction:(UIButton *)sender {
    
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getAddressListData
{
    //http://asapfood.in/dev/api/addressList?userId=4998256&user_token=1245
    NSString* url = @"http://asapfood.in/dev/api/addressList";
    NSDictionary* parms = @{@"userId":@"4998256",@"user_token":@"1245"};
    [[NetWork networkManager]getAddressList:url Address:parms completa:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"Address Data%@",jsonDict);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.addressArray = jsonDict[@"list"];
            [self.addressTableView reloadData];
        });
    }];
}
@end
