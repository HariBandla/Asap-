//
//  DetailsOfResturentViewController.h
//  asap
//
//  Created by Hari on 22/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldingSectionHeader.h"
#import "FoldingTableView.h"
@interface DetailsOfResturentViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) FoldingSectionHeaderArrowPosition arrowPosition;
//@property (nonatomic, strong) FoldingTableView *foldingTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailsOfResturentScrollView;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
- (IBAction)backAction:(UIButton *)sender;
- (IBAction)viewCartBtn:(UIButton *)sender;
@property NSString * branchId;
@property NSString * vendorId;

@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *branchAdressLabel;
@property (weak, nonatomic) IBOutlet UILabel *minOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *deliveryTimeLabel;


@end
