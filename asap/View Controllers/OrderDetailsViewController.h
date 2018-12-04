//
//  OrderDetailsViewController.h
//  asap
//
//  Created by Hari on 20/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *orderDetailsTableView;

@end

