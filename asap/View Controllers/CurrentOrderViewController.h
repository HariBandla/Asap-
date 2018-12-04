//
//  CurrentOrderViewController.h
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *cToDLabel;
@property (weak, nonatomic) IBOutlet UILabel *dToHLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cookingImage;
@property (weak, nonatomic) IBOutlet UIImageView *deliveryImage;
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
@property (weak, nonatomic) IBOutlet UITableView *currentOrderTableView;
@property (weak, nonatomic) IBOutlet UIButton *contactUsBT;
@property (weak, nonatomic) IBOutlet UIView *cookingView;
@property (weak, nonatomic) IBOutlet UIView *deliveryView;
@property (weak, nonatomic) IBOutlet UIView *homeView;

@end
