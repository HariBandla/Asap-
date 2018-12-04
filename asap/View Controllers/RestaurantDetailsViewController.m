//
//  RestaurantDetailsViewController.m
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "RestaurantDetailsViewController.h"
#import "RestaurantDetailCell.h"
#import "TabBarViewController.h"
#import "BavarageCategoresCollectionViewCell.h"
//#import "RestaurantDetailsTableViewCell.h"RestaurantDetailCell3
@implementation RestaurantDetailTableViewCell

@end
@implementation RestaurantDetailCell1

@end
@implementation RestaurantDetailCell2

@end
@implementation RestaurantDetailCell3

@end
@interface RestaurantDetailsViewController ()

@property NSArray*slideMenuArray;
@property NSArray*imageArray;
@property NSArray*CatgeryName;
@property NSArray*headerNameArray;
@property float heightForCatagoryView;
@property float heightForTableView;
@property NSMutableArray*isExpandable;
@end

@implementation RestaurantDetailsViewController
#pragma mark Methods For View
- (void)viewDidLoad {
    [super viewDidLoad];
    [self toGetHeightFromData];
    [self autoLayouts];
    UITapGestureRecognizer*topper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSlidePlan:)];
    topper.numberOfTapsRequired=1;
    [transv addGestureRecognizer:topper];
    
    
    self.slideMenuArray = @[@"Contact Us",@"Location",@"Restaurants",@"Deals",@"Profile",@"Address Book",@"Reviews",@"About Us",@"FAQ",@"Sign Out"];
    self.imageArray = @[@"Image1",@"Image2",@"Image3",@"Image4",@"Image5",@"Image6",@"Image7",@"Image8"];
     self.CatgeryName = @[@"Cool Sumer Drinks",@"Milkshake",@"Juice",@"Cool Sumer Drinks",@"Milkshake",@"Juice",@"Cool Sumer Drinks",@"Milkshake"];
    self.headerNameArray = @[@"Cool Sumer Drinks",@"Milkshake",@"Juice"];
    for (int i = 0; i<self.headerNameArray.count; i++) {
        [self.isExpandable addObject:@"false"];
   
}
    
}
-(void)toGetHeightFromData
{
    self.heightForCatagoryView = 450;
    self.heightForTableView = 300;
}

-(void)autoLayouts
{
  //  self.mainScrollView.frame = CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height - 160 );
    self.bannerView.backgroundColor = UIColor.redColor;
    self.categoryView.backgroundColor = UIColor.yellowColor;
    self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.heightForTableView + 120 + self.heightForCatagoryView);
    self.bannerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
    self.categoryView.frame = CGRectMake(0, self.bannerView.frame.size.height, self.view.frame.size.width, self.heightForCatagoryView);
    self.tableView.frame = CGRectMake(0, self.bannerView.frame.size.height + self.categoryView.frame.size.height, self.view.frame.size.width, self.heightForTableView);
    self.categoryCollectionView.frame = CGRectMake(0, 0, self.categoryView.frame.size.width,  self.heightForCatagoryView);
    self.bannerCollectionView.frame = CGRectMake(10, 0, self.bannerView.frame.size.width - 20, self.bannerView.frame.size.height);
}


-(void)viewWillAppear:(BOOL)animated
{
     self.tabBarController.tabBar.hidden = NO;
    [transv setHidden:YES];
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    CGRect frame=slidePlanel.frame;
    frame.origin.x=-slidePlanel.frame.size.width;
    slidePlanel.frame=frame;
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    //[self.tabBarController.navigationController setNavigationBarHidden:NO];
}
#pragma mark Methods For Slide Menu
-(void)hideSlidePlan:(UITapGestureRecognizer*)gusture
{
     self.tabBarController.tabBar.hidden = NO;
    if (gusture.state == UIGestureRecognizerStateEnded)
    {
        [transv setHidden:YES];
        [UIView transitionWithView:slidePlanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame=slidePlanel.frame;
            frame.origin.x=-slidePlanel.frame.size.width;
            slidePlanel.frame=frame;
        } completion:nil];
        
    }
}

#pragma mark Methods For CollectionView Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView.tag == 0) {
        if (self.imageArray.count == 0 ) {
            return 0;
        }
        else
        {
            return self.imageArray.count;
        }
    }
    else if (collectionView.tag == 1)
    {
        return 10;
    }
    else{
        return self.CatgeryName.count;
    }
    
    
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 0)
    {
    RestaurantDetailCell2*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RestaurantDetailCell1" forIndexPath:indexPath];
//    cell.itemImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
//    cell.itemName.text = self.imageArray[indexPath.row];
    return cell;
    }
    else if (collectionView.tag == 1)
    {
        RestaurantDetailCell2*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"RestaurantDetailCell2" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        RestaurantDetailCell3*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"RestaurantDetailCell3" forIndexPath:indexPath];
        cell.nameOfItemLabel.text = self.CatgeryName[indexPath.row];
        
        return cell;
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 0) {
         return  CGSizeMake(self.collectionViewScrollBack.frame.size.width/4, 55);
    }
      else if (collectionView.tag == 1)
    {
        return  CGSizeMake(self.bannerCollectionView.frame.size.width, self.bannerCollectionView.frame.size.height);
    }
   else
    {
        return  CGSizeMake(self.categoryCollectionView.frame.size.width/3-2, 150);
    }
    
}

#pragma mark Methods For TableView Delegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 0) {
        return 1;
    }
    else{
        return self.headerNameArray.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return _slideMenuArray.count;
    }
    else{

        if ([self.isExpandable[section] isEqualToString:@"false"]) {
            return 0;
        }
        else
        {
            if (section == 0) {
                return 3;
            }
            else if (section == 1) {
                return 6;
            }
            else
            {
                return 10;
            }
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return nil;
    }
    else{
        UIButton*button = [[UIButton alloc]init];
        button.tag = section;
        [button setTitle:@"close" forState:UIControlStateNormal];
        [button setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
        [button setBackgroundColor:UIColor.yellowColor];
        button.tintColor = UIColor.blackColor;
        [button addTarget:self action:@selector(forCloseOrOpen:) forControlEvents:UIControlEventTouchUpInside];
        return button;
    }

}
-(void)forCloseOrOpen:(UIButton*)button
{
    NSLog(@"hence the button tag is %li",button.tag);
    if ([self.isExpandable[button.tag] isEqualToString:@"false"]) {
        [self.isExpandable replaceObjectAtIndex:button.tag withObject:@"true"];

        [self.tableView reloadData];
    }
    else
    {
        [self.isExpandable replaceObjectAtIndex:button.tag withObject:@"false"];

        [self.tableView reloadData];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (tableView.tag == 1) {
        UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"slideTableCell" forIndexPath:indexPath];
        cell.textLabel.text = self.slideMenuArray[indexPath.row];

        return cell;
//    }
//    else{
//        RestaurantDetailTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantDetailCell" forIndexPath:indexPath];
//       // cell.textLabel.text = self.CatgeryName[indexPath.row];
//    cell.backgroundColor= UIColor.redColor;
//        return cell;
//    }
    
}

-(IBAction)buttonPassed:(id)sender
{
    [transv setHidden:NO];
    [slidePlanel setHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
    if (sender == menuBtn)
    {
        [UIView transitionWithView:slidePlanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame=slidePlanel.frame;
            frame.origin.x=0;
            slidePlanel.frame=frame;
        } completion:nil];
    }
    
}


- (IBAction)forwordButtonAction:(UIButton *)sender {
    NSInteger section = [self numberOfSectionsInCollectionView:self.collectionViewScrollBack] - 1;
    NSInteger item = [self collectionView:self.collectionViewScrollBack numberOfItemsInSection:section] - 1;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    [self.collectionViewScrollBack scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
  /*  NSArray *visibleItems = [self.collectionViewScrollBack indexPathsForVisibleItems];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    NSInteger item = [self.collectionViewScrollBack numberOfItemsInSection:0] - 1 ;
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:5 inSection:currentItem.section];
    [self.collectionViewScrollBack scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];*/
}
- (IBAction)backwordButtonAction:(UIButton *)sender {
    NSArray *visibleItems = [self.collectionViewScrollBack indexPathsForVisibleItems];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    NSInteger item = [self.collectionViewScrollBack numberOfItemsInSection:0] - 1 ;
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:1 inSection:currentItem.section];
    [self.collectionViewScrollBack scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
   
    //9415
}
@end
