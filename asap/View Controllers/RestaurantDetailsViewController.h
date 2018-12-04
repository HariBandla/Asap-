//
//  RestaurantDetailsViewController.h
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//
//7993544941
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FoldingSectionHeader.h"
#import "FoldingTableView.h"
@interface RestaurantDetailsViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UIView * transv;
    IBOutlet UIView * slidePlanel;
    IBOutlet UIButton *menuBtn;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewScrollBack;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UICollectionView *bannerCollectionView;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)forwordButtonAction:(UIButton *)sender;
- (IBAction)backwordButtonAction:(UIButton *)sender;
@end
@interface RestaurantDetailTableViewCell : UITableViewCell

@end
//RestaurantDetailCell
@interface RestaurantDetailCell1 : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewInCell;
@property (weak, nonatomic) IBOutlet UILabel *nameOfItemLabel;

@end
@interface RestaurantDetailCell2 : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageInCell;

@end
@interface RestaurantDetailCell3 : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageInCell;
@property (weak, nonatomic) IBOutlet UILabel *nameOfItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOfItemLabel;
@property (weak, nonatomic) IBOutlet UIView *addOrSubView;
@property (weak, nonatomic) IBOutlet UIButton *PlusButton;
@property (weak, nonatomic) IBOutlet UIButton *subButton;
@property (weak, nonatomic) IBOutlet UIButton *firstTimeAddButton;

@end
