//
//  BveveragesViewController.m
//  asap
//
//  Created by Kardas Veeresham on 11/19/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "BveveragesViewController.h"

@interface BveveragesViewController ()<UITableViewDataSource,UITableViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation BveveragesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}


#pragma mark Methods For CollectionView Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        
        cell.layer.borderWidth = 2;
        cell.layer.borderColor = (__bridge CGColorRef _Nullable)(UIColor.blackColor);
        
        return cell;
    }
    else if (collectionView.tag == 2)
    {
        UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.layer.borderWidth = 2;
        cell.layer.borderColor = (__bridge CGColorRef _Nullable)(UIColor.blackColor);
        return cell;
    }
    else{
        UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell3" forIndexPath:indexPath];
        cell.layer.borderWidth = 2;
        cell.layer.borderColor = (__bridge CGColorRef _Nullable)(UIColor.blackColor);
        return cell;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1)
    {
        return  CGSizeMake(self.bannerCollectionView.frame.size.width, self.bannerCollectionView.frame.size.height);
    }
    else
    {
        return  CGSizeMake(self.itenListOneCollectionView.frame.size.width/3-6, 170);
    }
    
}


@end
