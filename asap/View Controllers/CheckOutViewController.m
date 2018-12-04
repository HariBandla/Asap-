//
//  CheckOutViewController.m
//  asap
//
//  Created by Hari on 01/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "CheckOutViewController.h"
#import "PaymentViewController.h"
#import "ProfileViewController.h"
#import "AddToGroupViewController.h"
#import "NetWork.h"

@interface CheckOutViewController ()

@property NSArray * groupListArray;
@end

@implementation CheckOutViewController
#pragma mark Methods For View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getCheckOutAddress];
    [self groupListData];
    [self.navigationController setNavigationBarHidden:YES];
   
   
}

#pragma mark Methods For TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupListArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.groupListArray[section] valueForKey:@"group_userList"]count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = UIColor.lightGrayColor;
    UILabel * titellabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0,self.view.frame.size.width/2, 40)];
    //  titellabel.text = self.sectionName[section];
    titellabel.text = [self.groupListArray[section] valueForKey:@"group_name"];
    [view addSubview:titellabel];
    UIButton * editBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 0, 80, 40)];
    editBtn.titleLabel.text = @"Edit";
    //  editBtn.currentTitleColor = [UIColor blueColor].CGColor;
    editBtn.backgroundColor = UIColor.redColor;
    editBtn.tag = section;
    [editBtn addTarget:self action:@selector(clickEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [ view addSubview: editBtn];
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"groupListCell"];
    NSDictionary * items = [[self.groupListArray[indexPath.section] valueForKey:@"group_userList"] objectAtIndex:indexPath.row];
    cell.textLabel.text = items [@"user_name"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)clickEditBtn :(UIButton *)sender
{
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddToGroupViewController*addGroupVc = [storyBoard instantiateViewControllerWithIdentifier:@"AddToGroupViewController"];
    NSDictionary * items = self.groupListArray[sender.tag];
    addGroupVc.GroupUserListDict = items;
   // addGroupVc.groupNameTextField.text = items[@"group_name"];
    NSLog(@"list %@",addGroupVc.GroupUserListDict);
    [self.navigationController pushViewController:addGroupVc animated:YES];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)continueBtn:(UIButton *)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PaymentViewController*paymentVc = [storyBoard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    [self.navigationController pushViewController:paymentVc animated:YES];
}

- (IBAction)viewCartBtn:(UIButton *)sender {
}

- (IBAction)changeAddressBtn:(UIButton *)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileViewController*profileVc = [storyBoard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:profileVc animated:YES];
}

- (IBAction)creatGropBtn:(UIButton *)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddToGroupViewController*groupVc = [storyBoard instantiateViewControllerWithIdentifier:@"AddToGroupViewController"];
    [self.navigationController pushViewController:groupVc animated:YES];
}

-(void)getCheckOutAddress
{
    NSString* url = @"http://asapfood.in/dev/api/addressList";
    NSDictionary* parms = @{@"userId":@"4998256",@"user_token":@"1245",@"default_address":@"1"};
    [[NetWork networkManager]getAddressList:url Address:parms completa:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"checkOut Address Data%@",jsonDict);
       
        dispatch_async(dispatch_get_main_queue(), ^{
            self.houseNoLabel.text = [[jsonDict[@"list"] objectAtIndex:0]valueForKey:@"house_no"];
            self.streetLabel.text= [[jsonDict[@"list"] objectAtIndex:0]valueForKey:@"street_no"];
            self.areaLabel.text = [[jsonDict[@"list"] objectAtIndex:0]valueForKey:@"area"];
            self.cityLabel.text = [[jsonDict[@"list"] objectAtIndex:0]valueForKey:@"city"];
        //    self.phoneNumberLabel.text = checkOutDataDict[@""];
           
        });
    }];
}


-(void)groupListData
{
    NSDictionary* parms = @{
                            @"userId":@"4998256",
                            @"user_token":@"224ac6539f91b642e50c94df881013a9",
                            @"owner_id":@"4998256"
                            };
    
    [[NetWork networkManager]getGroupListData:parms complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"group list data %@",jsonDict);
        self.groupListArray = jsonDict[@"list"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.groupListTableView reloadData];
        });
        
    }];
}


@end
