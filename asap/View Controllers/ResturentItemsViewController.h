//
//  ResturentItemsViewController.h
//  asap
//
//  Created by Gopal Gundaram on 22/11/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldingTableView.h"
@interface ResturentItemsViewController : UIViewController

@property  UILabel * resturentNameLabel;
@property  UILabel * resturentMinOrderLabel;
@property  UILabel * resturentAddressLabel;
@property  UILabel * resturentDeliveryTimeLabel;
@property  UIView * resturentReatingView;
@property  UILabel * resturentDetailLabel;
@property UIScrollView * mainScrollView;
@property NSString * branchId;
@property NSString * vendorId;
@property UIView * forSelectingVegView;
@property UISwitch * forSelectingVegSwitch;
@property UILabel * forSelectingVegLabel;
@property  UIImageView * image;
@property  UIView * addressView;
@property NSArray * dataOfResturentArray;
@property NSArray * recomandedItemsResturentArray;
@property NSMutableArray * catageryListArray;
@property NSDictionary*jsonDataFromServer;
@property (weak, nonatomic) IBOutlet UIView *tranView;
@property (weak, nonatomic) IBOutlet UITableView *normalItemTableView;
@property (weak, nonatomic) IBOutlet UITableView *forRecommendationTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *favarateItemsCollectionView;
@property NSDictionary * dataForTableViewCellDic;
@property NSUInteger numberForCoreData;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *subButton;


@end
@interface recommendationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *addAndSubView;
//@property (weak, nonatomic) IBOutlet UIButton *addbutton;
//@property (weak, nonatomic) IBOutlet UIButton *subButtonRecommendat;
//@property (weak, nonatomic) IBOutlet UIButton *firstTimeAddButtonRecommendat;
@property (weak, nonatomic) IBOutlet CartBtn *addButtonInRecommendation;
@property (weak, nonatomic) IBOutlet CartBtn *subButtonRecommendat;
@property (weak, nonatomic) IBOutlet CartBtn *firstTimeAddButtonRecommendat;


@end
@interface favarateViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameOfTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeOfImageView;
@end
@interface normalItemsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CartBtn *subInNormalTableViewCell;
@property (weak, nonatomic) IBOutlet CartBtn *plusInNormalTableView;
@property (strong, nonatomic) IBOutlet CartBtn *firstTimeAddingItemButton;
//@property (weak, nonatomic) IBOutlet UIButton *firstTimeAddingItemButton;
//@property (weak, nonatomic) IBOutlet UIButton *plusInNormalTableView;
//@property (weak, nonatomic) IBOutlet UIButton *subInNormalTableViewCell;
@property (weak, nonatomic) IBOutlet UIImageView *typeOfImageView;
@property (weak, nonatomic) IBOutlet UILabel *maneOfItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOfItemLabel;
@property (weak, nonatomic) IBOutlet UIView *addAndSubView;

@property (weak, nonatomic) IBOutlet UIButton *addbutton;
@property (weak, nonatomic) IBOutlet UIButton *subButton;


@end
