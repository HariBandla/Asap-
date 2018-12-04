//
//  ProfileViewController.m
//  asap
//
//  Created by Hari on 20/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "ProfileViewController.h"
#import "NetWork.h"
#import "AddAddressViewController.h"
#import "CheckOutViewController.h"


@implementation ProfileCell;

@end
@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property NSArray * addressArray;
@property NSString * makeDefaultCellId;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [self.navigationController setNavigationBarHidden:YES];
    
   
   
     [self.navigationController setNavigationBarHidden:YES];
    self.addressTableView.tableFooterView = [UIView new];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getProfileDetails];
    [self getAddressListData];
    self.transVc.hidden = YES;
    self.editPopUpVc.hidden = YES;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCell*cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    NSDictionary* AddressDict = self.addressArray[indexPath.row];
    cell.addressTypeLabel.text = AddressDict[@"address_type"];
    NSString* houseNumber = AddressDict[@"house_no"];
    NSString* streetNumber = AddressDict[@"street_no"];
    NSString* city = AddressDict[@"city"];
    NSString* totalAdress = [NSString stringWithFormat:@"%@ %@ %@",houseNumber,streetNumber,city];
    cell.addressLabel.text = totalAdress;
    cell.addressCelleditButton.tag = indexPath.row;
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* AddressDict = self.addressArray[indexPath.row];
       self.makeDefaultCellId =AddressDict[@"id"];
    [self makeDefaultData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (IBAction)BackButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editAddressOpenPopUpBtnAction:(UIButton *)sender {
    
    self.transVc.hidden = NO;
    self.editPopUpVc.hidden = NO;
    self.editFullNameTextField.text =  self.nameLabel.text;
    self.editEmailTextField.text = self.maillabel.text;
}
- (IBAction)editAdressSubmitBtnAction:(UIButton *)sender {
    [self updateProfile];
}
- (IBAction)addAddressBtn:(UIButton *)sender {
    
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddAddressViewController*view = [storyBoard instantiateViewControllerWithIdentifier:@"AddAddressViewController"];
    view.addNewData = @"addNew";
    // [self.navigationController presentViewController:view animated:YES completion:nil];
    [self presentViewController:view animated:YES completion:nil];
}
- (IBAction)CellEditAddressBtn:(UIButton *)sender {
    
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddAddressViewController*view = [storyBoard instantiateViewControllerWithIdentifier:@"AddAddressViewController"];
    NSDictionary* AddressDict = [self.addressArray objectAtIndex:sender.tag];
    view.self.editAddressData = AddressDict;
    view.self.cellId = AddressDict[@"id"];
     [self presentViewController:view animated:YES completion:nil];
    
}


-(void)getProfileDetails
{
    //http://asapfood.in/dev/api/profile?userId=1023863&user_token=83bca3c384f2b1e1d0aa7390e7997f77
    [[NetWork networkManager]getProfileUrl:@"http://asapfood.in/dev/api/profile" profile:@{@"userId":@"1023863",@"user_token":@"83bca3c384f2b1e1d0aa7390e7997f77"} completa:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
       // NSLog(@"%@",jsonDict);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = [jsonDict[@"list"] valueForKey:@"user_name"];
            self.maillabel.text = [jsonDict[@"list"] valueForKey:@"user_email"];
            self.mobileNumber.text = [jsonDict[@"list"] valueForKey:@"user_mobile"];
        });
    }];
}

-(void)updateProfile
{
    [[NetWork networkManager]updateProfileUrl:@"http://asapfood.in/dev/api/profileupdate" parameters:@{@"user_token":@"83bca3c384f2b1e1d0aa7390e7997f77",@"userId":@"1023863",@"name":self.editFullNameTextField.text,@"email":self.editEmailTextField.text} complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
         NSLog(@"%@",jsonDict);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.transVc.hidden = YES;
            self.editPopUpVc.hidden = YES;
            [self getProfileDetails];
        });
    }];
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

-(void)makeDefaultData
{
     NSDictionary* parms = @{@"userId":@"4998256",@"user_token":@"224ac6539f91b642e50c94df881013a9",@"id":self.makeDefaultCellId};
    [[NetWork networkManager]getMakeDefaultAddress:parms complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"makeDefault Data%@",jsonDict);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CheckOutViewController*view = [storyBoard instantiateViewControllerWithIdentifier:@"CheckOutViewController"];
            [self.navigationController pushViewController:view animated:YES];

        });
    }];
}

@end
