//
//  HomeViewController.h
//  asap
//
//  Created by Gopal Gundaram on 30/07/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UIView * transv;
    IBOutlet UIView * slidePlanel;
    IBOutlet UIButton *menuBtn;
}




@property (weak, nonatomic) IBOutlet UICollectionView *bannersCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *recommendationCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *popularCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *topRatedCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *outletsTableview;
- (IBAction)OutletsButton:(UIButton *)sender;
- (IBAction)secondOutletBtn:(UIButton *)sender;
- (IBAction)thirdOutletBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *outletResturentImageView;
@property (weak, nonatomic) IBOutlet UILabel *outletRestuerentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *outletsNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *outletsView;

@end
