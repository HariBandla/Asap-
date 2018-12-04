//
//  AddToGroupViewController.h
//  asap
//
//  Created by Hari on 28/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddToGroupViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *groupNameTextField;
- (IBAction)crossAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITextField *idNumberTextField;

@property (weak, nonatomic) IBOutlet UIView *addUserToGroupView;
@property (weak, nonatomic) IBOutlet UITableView *groupTableView;
@property NSArray * groupDetailsArray;
@property NSDictionary * GroupUserListDict;
@end
