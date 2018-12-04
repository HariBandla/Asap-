#import "AddToGroupViewController.h"
#import "ToAddGroupTableViewCell.h"
#import "NetWork.h"
@interface AddToGroupViewController (){
    NSString * groupID;
    
}

@end

@implementation AddToGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self forSetingGroup];
    // Do any additional setup after loading the view.
}
-(void)forSetingGroup
{
    if (groupID  != nil) {
        [self.addUserToGroupView setHidden:NO];
        [self.groupTableView setHidden:NO];
    }
    else
    {
        [self.addUserToGroupView setHidden:YES];
        [self.groupTableView setHidden:YES];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupDetailsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToAddGroupTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"toAddGroupCell" forIndexPath:indexPath];
    if (self.groupDetailsArray.count != 0) {
        NSDictionary*item = self.groupDetailsArray[indexPath.row];
        cell.nameLabel.text = item[@"user_name"];
        cell.custmerIdLabel.text = item[@"user_id"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


- (IBAction)crossAction:(UIButton *)sender
{
   
}
- (IBAction)creatGroupButtonAction:(UIButton *)sender {
    NSDictionary*parms = @{@"userId":@"4998256",
                           @"user_token":@"224ac6539f91b642e50c94df881013a9",
                           @"group_name":self.groupNameTextField.text,
                           @"owner_id":@"4998256"};
    if ([self.groupNameTextField.text length] != 0 ) {
        [[NetWork networkManager] createAGroup:parms complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
            if ([jsonDict[@"responseCode"] integerValue] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    groupID = jsonDict[@"groupd_id"];
                    NSLog(@"json by creating A group %@",jsonDict);
                    [self getGroupDetails];
                    [self forSetingGroup];
                });
            }
            
        }];
    }
}
- (IBAction)userAddButtonActon:(UIButton *)sender {
    NSArray * groupIdArray = @[@{ @"user_id" : @"1023863"}];
    NSDictionary * parms = @{
                             @"userId":@"4998256",
                             @"user_token":@"224ac6539f91b642e50c94df881013a9",
                             @"owner_id":@"4998256",
                             @"group_id":@"6435",
                             @"userList":groupIdArray
//                             @"userId":@"4998256",
//                             @"user_token":@"224ac6539f91b642e50c94df881013a9",
//                             @"owner_id":@"4998256",
//                             @"group_id":groupIdArray
                             };
    /*"userId":"4998256",
     "user_token":"224ac6539f91b642e50c94df881013a9",
     "owner_id":"4998256",
     "group_id":"6435",
     "userList":[
     { "user_id" : "1023863"},
     { "user_id" : "4106038"},
     { "user_id" : "3429165"}
     ]*/
    [[NetWork networkManager]addUserToGroup:parms complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
dispatch_async(dispatch_get_main_queue(), ^{
     NSLog(@"JSON DATA BY ADDING A GROUP %@",jsonDict);
            [self getGroupDetails];
        });
    }];
}

-(void)toGetDetailsOfGroup:(NSString *)groupID
{
    
}
- (IBAction)delectFromTableView:(UIButton *)sender {
    NSDictionary*parms = @{
                           @"userId":@"4998256",
                            @"user_token":@"224ac6539f91b642e50c94df881013a9",
                            @"id":@"1",
                            @"group_id":@"6463"
                           };
    [[NetWork networkManager]delectUserFromGroup:parms complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"JSON DATA BY DELECTING A GROUP %@",jsonDict);
            [self getGroupDetails];
        });
    }];
}
-(void)getGroupDetails
{
    NSDictionary*parms = @{@"userId":@"4998256",
                           @"user_token":@"224ac6539f91b642e50c94df881013a9",
                           @"group_id":@"6463"};
    [[NetWork networkManager]getGroupDetails:parms complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"JSON DATA GET GROUP DETAILS %@",jsonDict);
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.groupDetailsArray = jsonDict[@"list"];
                    [self.groupTableView reloadData];
                });
    }];
//    [[NetWork networkManager]getGroupUserList:parms complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
//
//    }];
}
@end
