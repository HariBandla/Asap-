//
//  BveveragesViewController.h
//  asap
//
//  Created by Kardas Veeresham on 11/19/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BveveragesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *bannerCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *itenListOneCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *itemListTwoCollectionView;

@end
