//
//  ResturentItemsViewController.m
//  asap
//
//  Created by Gopal Gundaram on 22/11/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "ResturentItemsViewController.h"
#import "NetWork.h"
#import "AsyncImageView.h"
#import "ForCoreDataMethods.h"
#import "AddToGroupViewController.h"
#import "MyCartViewController.h"

@implementation recommendationTableViewCell
@end
@implementation favarateViewCell
@end
@implementation normalItemsTableViewCell
@end
@interface ResturentItemsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@end

@implementation ResturentItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer*topper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSlidePlan:)];
    topper.numberOfTapsRequired=1;
    [self.tranView addGestureRecognizer:topper];
    //self.forRecommendationTableView.frame = CGRectMake(0, self.view.frame.size.height + 50, self.view.frame.size.width, self.recomandedItemsResturentArray.count * 100 + 50);
    self.catageryListArray = [[NSMutableArray alloc]init];
    [self toGetDataFromServer];
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.mainScrollView];
    self.forRecommendationTableView.delegate = self;
    self.forRecommendationTableView.dataSource = self;
    self.favarateItemsCollectionView.delegate = self;
    self.favarateItemsCollectionView.dataSource = self;
   // [self setFrameForScrollView];
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake( self.view.frame.size.width / 2 - 50, self.view.frame.size.height / 2 , 100, 100)];
    self.image.image = [UIImage imageNamed:@"food.png 60"];
    [self forSetingAddressView];
 //  [self forAnimatingView];
   // [self toSetVegSwich];
    self.numberForCoreData = 10000;
    NSArray*array = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
    [self toDisPlayCartOrNot];
    //self.addressView.backgroundColor = UIColor.magentaColor;
}
-(void)hideSlidePlan:(UITapGestureRecognizer*)gusture
{
    
    if (gusture.state == UIGestureRecognizerStateEnded)
    {
        [self.tranView setHidden:YES];
        [UIView transitionWithView:self.normalItemTableView duration:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame=self.normalItemTableView.frame;
            frame.origin.y=self.mainScrollView.contentSize.height;
            self.normalItemTableView.frame=frame;
        } completion:nil];
        [self.forRecommendationTableView reloadData];
      //  [self.normalItemTableView reloadData];
        
    }
}
-(void)forSetingAddressView
{
    self.addressView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height / 2, 10, 10)];
    self.resturentMinOrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 80 , 100, 50, 40)];
    self.resturentReatingView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40  , 100, 50, 40)];
    self.resturentDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width /2 + 60 , 100, 50, 40)];
    UIView*forMinOrder = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 150, 100, 50, 50)];
   // self.addressView.backgroundColor = UIColor.blackColor;
    self.resturentNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 60, 20)];
    self.resturentNameLabel.text = @"SriHari";
    [self.resturentNameLabel setTextAlignment:UITextAlignmentCenter];
    self.resturentAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 33, self.view.frame.size.width - 60, 50)];
    self.resturentAddressLabel.numberOfLines = 4;
    self.resturentAddressLabel.font = [UIFont systemFontOfSize:13];
    self.resturentAddressLabel.textColor = UIColor.whiteColor;
    self.resturentNameLabel.textColor = UIColor.whiteColor;
    forMinOrder.backgroundColor = UIColor.redColor;
    //---------------------for min order started-----------------------
    UILabel * minOrderTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, forMinOrder.layer.frame.size.width, 21)];
    minOrderTitleLabel.text = @"Min Order";
    minOrderTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:8];
    minOrderTitleLabel.textColor = UIColor.whiteColor;
    [minOrderTitleLabel setTextAlignment:UITextAlignmentCenter];
    [forMinOrder addSubview:minOrderTitleLabel];
    UILabel * rsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 24, 18)];
    rsLabel.text = @"Rs.";
    rsLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    rsLabel.textColor = UIColor.whiteColor;
    [rsLabel setTextAlignment:UITextAlignmentCenter];
    [forMinOrder addSubview:rsLabel];
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(17, 15,forMinOrder.layer.frame.size.width - 24, 18)];
    priceLabel.text = @"1000";
    priceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    priceLabel.textColor = UIColor.whiteColor;
    [priceLabel setTextAlignment:UITextAlignmentCenter];
    forMinOrder.backgroundColor = UIColor.blackColor;
    [forMinOrder addSubview:priceLabel];
    //---------------------for min order ended-----------------------
    //---------------------for Time order ended-----------------------
    self.resturentDeliveryTimeLabel = [[UILabel alloc]initWithFrame: CGRectMake(self.view.frame.size.width / 2 - 80 , 100, 50, 40)];
    self.resturentDeliveryTimeLabel.backgroundColor = UIColor.redColor;
    //self.resturentDeliveryTimeLabel.frame = CGRectMake(50, 50, 100, 100);
    self.resturentDeliveryTimeLabel.text = @"30 Mins";
    self.resturentDeliveryTimeLabel.textColor = UIColor.blackColor;
    self.resturentDeliveryTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    [self.resturentDeliveryTimeLabel setTextAlignment:UITextAlignmentCenter];
    
    //self.addressView.backgroundColor = UIColor.blueColor;
    //---------------------for Time order ended-----------------------
    //---------------------for reating order start-----------------------
    UIImageView * ReatingImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
    ReatingImageView.backgroundColor = UIColor.grayColor;
    [_resturentReatingView addSubview:ReatingImageView];
    UILabel * reatingLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 30, 20)];
    reatingLabel.backgroundColor = UIColor.redColor;
    reatingLabel.text = @"4.1";
    reatingLabel.textColor = UIColor.whiteColor;
    reatingLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [_resturentReatingView addSubview:reatingLabel];
    
    //---------------------for Time order ended-----------------------
    
    self.resturentMinOrderLabel.frame =CGRectMake(self.view.frame.size.width / 2 - 80 , 100, 50, 40);
    self.resturentReatingView.frame =CGRectMake(self.view.frame.size.width / 2 - 10  , 100, 50, 40);
    self.resturentReatingView.backgroundColor = UIColor.blueColor;
    self.resturentDetailLabel.backgroundColor = UIColor.blackColor;
    [self.resturentAddressLabel setTextAlignment:UITextAlignmentCenter];
    [self.addressView addSubview:self.resturentAddressLabel];
    [self.addressView addSubview:self.resturentNameLabel];
    [self.addressView addSubview:self.resturentDetailLabel];
    [self.addressView addSubview:forMinOrder];
    [self.addressView addSubview:self.resturentReatingView];
    [self.addressView addSubview:self.resturentMinOrderLabel];
    [self.addressView addSubview:self.resturentDeliveryTimeLabel];
    self.addressView.backgroundColor = UIColor.whiteColor;
    [self toSetColorToAllViews];
}
-(void)toSetColorToAllViews
{
    self.addressView.backgroundColor = UIColor.blackColor;
    self.resturentMinOrderLabel.textColor = UIColor.whiteColor;
    self.resturentReatingView.backgroundColor = UIColor.blackColor;
    self.resturentDeliveryTimeLabel.textColor = UIColor.whiteColor;
    self.resturentDeliveryTimeLabel.backgroundColor = UIColor.blackColor;
    self.mainScrollView.backgroundColor = UIColor.whiteColor;
}
-(void)forSetingVegView
{
    self.forSelectingVegView = [[UIView alloc]initWithFrame:CGRectMake(10,self.addressView.frame.origin.y + self.addressView.frame.size.height + 10, self.view.frame.size.width - 20, 34)];
    self.forSelectingVegView.backgroundColor = [UIColor colorWithRed:100.0/255 green:100.0/255 blue:100.0/255 alpha:1];
    [self.mainScrollView addSubview:self.forSelectingVegView];
    self.forSelectingVegLabel = [[UILabel alloc]init];
    self.forSelectingVegSwitch = [[UISwitch alloc]init];
    self.forSelectingVegLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 60, 21)];
    self.forSelectingVegLabel.text = @"Veg Only";
    self.forSelectingVegLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    self.forSelectingVegLabel.textColor = UIColor.blackColor;
    [self.forSelectingVegView addSubview:self.forSelectingVegLabel];
    self.forSelectingVegSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(67, 2, 100, 21)];
    //self.forSelectingVegLabel.text = @"Veg";
    [self.forSelectingVegView addSubview:self.forSelectingVegSwitch];
}
-(void)setFrameForScrollView
{
    self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.recomandedItemsResturentArray.count * 100 + self.favarateItemsCollectionView.frame.origin.y + self.favarateItemsCollectionView.frame.size.height + 90);
}
-(void)toDisPlayCartOrNot
{
     NSArray*array = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
    UIView * cartView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    UILabel * numberOfItems = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,50, 40)];
    
    numberOfItems.text = [NSString stringWithFormat:@"  %li Items",array.count];
    numberOfItems.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    numberOfItems.textColor = UIColor.whiteColor;
    [cartView addSubview:numberOfItems];
    UILabel * dividingLine = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 1, 40)];
    dividingLine.backgroundColor = UIColor.whiteColor;
    [cartView addSubview:dividingLine];
    UILabel * rsLabelForCart = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 60, 40)];
   // rsLabelForCart.text = @"Rs";
    rsLabelForCart.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [cartView addSubview:rsLabelForCart];
    rsLabelForCart.text = @"Rs.";
    rsLabelForCart.textColor = UIColor.whiteColor;
    cartView.backgroundColor = UIColor.redColor;
    NSUInteger priceOfItems = 0;
    for (int i = 0; i < array.count; i++) {
        NSDictionary * item = array[i];
        NSUInteger quantityOfItem = [item[@"product_quantity"] integerValue];
        NSUInteger priceOfAnItem =  [item[@"product_price"] integerValue];
        priceOfItems = priceOfItems + (quantityOfItem * priceOfAnItem);
    }
    UILabel *totalPriceOfItemsLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 80, 40)];
    totalPriceOfItemsLabel.text = [NSString stringWithFormat:@"%li",priceOfItems];
    totalPriceOfItemsLabel.textColor = UIColor.whiteColor;
    totalPriceOfItemsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
   // totalPriceOfItemsLabel.backgroundColor = UIColor.whiteColor;
    totalPriceOfItemsLabel.textAlignment = NSTextAlignmentLeft;//NSTextAlignmentCenter;
   // [totalPriceOfItemsLabel sizeToFit];
    [cartView addSubview:totalPriceOfItemsLabel];
    [self.view addSubview:cartView];
    if (array.count == 0) {
        cartView.hidden = true;
    }else
    {
        cartView.hidden = NO;
    }
    //.font = [UIFont fontWithName:@"Helvetica-Bold" size:8];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40, 0, 40, 40)];
    [cartView addSubview:imageView];
    UIButton * viewCartButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 120, 0, 80, 40)];
    [viewCartButton setTitle:@"View Cart" forState:UIControlStateNormal];
    [viewCartButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [viewCartButton addTarget:self action:@selector(showCart) forControlEvents:UIControlEventTouchUpInside];
    viewCartButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [cartView addSubview:viewCartButton];
}
-(void)showCart
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyCartViewController * view = [storyBoard instantiateViewControllerWithIdentifier:@"MyCartViewController"];
    [self.navigationController pushViewController:view animated:nil];
    
}
-(void)forAnimatingView
{
    [UIView animateWithDuration:1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.image.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
        
        [self.mainScrollView addSubview:self.image];
    } completion:nil];
    [UIView animateWithDuration:1 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
    } completion:nil];
    [UIView animateWithDuration:1 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.addressView.frame = CGRectMake(20, 110 , self.view.frame.size.width - 40, 160);
        //self.addressView.backgroundColor = [UIColor whiteColor];
        self.addressView.layer.cornerRadius = 20;
        [self forSetingVegView];
        [self.mainScrollView addSubview:self.addressView];
    } completion:nil];
    [UIView animateWithDuration:1 delay:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.favarateItemsCollectionView.frame = CGRectMake(0, self.forSelectingVegView.frame.origin.y + self.forSelectingVegView.frame .size.height + 6 , self.view.frame.size.width, 100);
        [self.mainScrollView addSubview:self.favarateItemsCollectionView];
    } completion:nil];
    [UIView animateWithDuration:1 delay:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //========================for collectionView===========
        self.forRecommendationTableView.frame = CGRectMake(0, self.favarateItemsCollectionView.frame.origin.y + self.favarateItemsCollectionView.frame.size.height + 2, self.view.frame.size.width, self.recomandedItemsResturentArray.count * 100 + 50);
        //        self.favarateItemsCollectionView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 100);
        [self.mainScrollView addSubview:self.forRecommendationTableView];
        //==========================================
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collectionView Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataOfResturentArray.count;
      
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        favarateViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"favarateViewCell" forIndexPath:indexPath];
        NSDictionary * item = self.dataOfResturentArray[indexPath.row];
        cell.backgroundColor = UIColor.redColor;
        cell.nameOfTypeLabel.text = item[@"category"];
        return cell;
   
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    return CGSizeMake(90, 90);
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.catageryListArray = [self.dataOfResturentArray[indexPath.row] valueForKey:@"subcatList"];
    [self.normalItemTableView reloadData];
    [UIView animateWithDuration:0.4 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //========================for collectionView===========
        self.tranView.hidden = NO;
        self.tranView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:self.tranView];
        self.normalItemTableView.hidden = NO;
        self.normalItemTableView.frame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2 + 20);
        [self.view addSubview:self.normalItemTableView];
    } completion:nil];
}

#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{if (tableView.tag == 1)
{
    return self.catageryListArray.count;
}else
{
    return 1;
}
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1)
      {
    return [[self.catageryListArray[section] valueForKey:@"productList"] count];
      }
    else
    {
        return self.recomandedItemsResturentArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        normalItemsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normalItemsTableViewCell"];
        NSDictionary * item = [[self.catageryListArray[indexPath.section] valueForKey:@"productList"] objectAtIndex:indexPath.row];
        /*:@"product_id"];
         [object setValue:product_weight forKey:@"product_weight"];
         [object setValue:product_price forKey:@"product_price"];
         [object setValue:vendor_id forKey:@"vendor_id"];
         [object setValue:product_quantity forKey:@"product_quantity"];
         [object setValue:branch_id forKey:@"branch_id"];*/
        NSDictionary*requestItemDic = @{@"product_id":item[@"product_id"],@"product_weight":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_weight"],@"vendor_id":self.vendorId,@"branch_id":self.branchId,@"product_quantity":@"0",@"product_price":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_price"]};
        self.dataForTableViewCellDic = [self isInCart:requestItemDic];
        if ([self.dataForTableViewCellDic[@"product_quantity"] integerValue] == 0) {
            [cell.firstTimeAddingItemButton setHidden:NO];
            [cell.plusInNormalTableView setHidden:YES];
            [cell.subInNormalTableViewCell setHidden:YES];
            [cell.addAndSubView setHidden:YES];
        }
        else
        {
            [cell.addAndSubView setHidden:NO];
            [cell.firstTimeAddingItemButton setHidden:YES];
            [cell.plusInNormalTableView setHidden:NO];
            [cell.subInNormalTableViewCell setHidden:NO];
            [cell.plusInNormalTableView setTitle:[NSString stringWithFormat:@"%@+",self.dataForTableViewCellDic[@"product_quantity"]] forState:UIControlStateNormal];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.plusInNormalTableView.layer.cornerRadius = 15;
        cell.subInNormalTableViewCell.layer.cornerRadius = 15;
        cell.firstTimeAddingItemButton.indexPath = indexPath;
        cell.plusInNormalTableView.indexPath = indexPath;
        cell.subInNormalTableViewCell.indexPath = indexPath;
        cell.maneOfItemLabel.text = item[@"product_name"];
        cell.priceOfItemLabel.text = [self.dataForTableViewCellDic valueForKey:@"product_price"];
        return cell;
    }
    else
    {
    recommendationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"recommendationTableViewCell"];
         NSDictionary * item = self.recomandedItemsResturentArray[indexPath.row];
        cell.firstTimeAddButtonRecommendat.indexPath = indexPath;
        cell.addButtonInRecommendation.indexPath = indexPath;
        cell.subButtonRecommendat.indexPath = indexPath;
        NSDictionary*requestItemDic = @{@"product_id":item[@"product_id"],@"product_weight":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_weight"],@"vendor_id":self.vendorId,@"branch_id":self.branchId,@"product_quantity":@"0",@"product_price":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_price"]};
        cell.addButtonInRecommendation.layer.cornerRadius = 15;
        cell.subButtonRecommendat.layer.cornerRadius = 15;
        self.dataForTableViewCellDic = [self isInCart:requestItemDic];
        if ([self.dataForTableViewCellDic[@"product_quantity"] integerValue] == 0) {
            [cell.firstTimeAddButtonRecommendat setHidden:NO];
            [cell.addButtonInRecommendation setHidden:YES];
            [cell.subButtonRecommendat setHidden:YES];
            [cell.addAndSubView setHidden:YES];
        }
        else
        {
            [cell.addAndSubView setHidden:NO];
            [cell.firstTimeAddButtonRecommendat setHidden:YES];
            [cell.addButtonInRecommendation setHidden:NO];
            [cell.subButtonRecommendat setHidden:NO];
            [cell.addButtonInRecommendation setTitle:[NSString stringWithFormat:@"%@+",self.dataForTableViewCellDic[@"product_quantity"]] forState:UIControlStateNormal];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameOfItemLabel.text = item[@"product_name"];
        cell.itemPriceLabel.text = item[@"product_price"];
       cell.firstTimeAddButtonRecommendat.indexPath = indexPath;
        cell.itemImageView.imageURLString = item[@"image"];
    return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        return 70;
    }
    else
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (tableView.tag == 1) {
//    }
//    UILabel * label = [[UILabel alloc]init];
//
//    return label;
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        
        UILabel * label = [[UILabel alloc]init];
        label.backgroundColor = UIColor.blackColor;
        label.textColor = UIColor.whiteColor;
        // NSDictionary * item = self.recomandedItemsResturentArray[section];
        label.text = [self.catageryListArray[section] valueForKey:@"subcategory"];
        return label;
            }
    else
    {
            UILabel * label = [[UILabel alloc]init];
       // NSDictionary * item = self.recomandedItemsResturentArray[section];
        label.text = @"Recomanded List";
            return label;
    }
}
-(void)toGetDataFromServer
{
    NSDictionary * parms = @{@"vendorId":self.vendorId,@"branchId":self.branchId};
    [[NetWork networkManager]resturentDetails:parms complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"resturentData %@",jsonDict);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.jsonDataFromServer = jsonDict[@"branchDetail"];
            self.dataOfResturentArray = jsonDict[@"list"];
            self.recomandedItemsResturentArray = jsonDict[@"recomandedList"];
            self.resturentAddressLabel.text = self.jsonDataFromServer[@"branch_adress"];
            self.resturentNameLabel.text = self.jsonDataFromServer[@"restaurant_name"];
            self.image.imageURLString = self.jsonDataFromServer[@"app_logo"];
            [self forAnimatingView];
             [self setFrameForScrollView];
            [self.favarateItemsCollectionView reloadData];
            [self.forRecommendationTableView reloadData];
            
        });
    }];
}


-(NSDictionary*)isInCart:(NSDictionary *) dataToAddToCart
{
      NSArray * coreDataArray = [[ForCoreDataMethods networkManager] getDateFromCoreDate];
    if ([coreDataArray count] != 0)
    {
    for (int i = 0; i < coreDataArray.count ; i++ )
    {
        NSDictionary * item = [coreDataArray objectAtIndex:i];
        //[[self.fetchedResultsController objectAtIndexPath:indexPath] valueForKey:@"menuPunkt"]
        NSLog(@"product_id data from Core Data Is %@",[[coreDataArray objectAtIndex:i] valueForKey:@"product_id"]);
        if ([[[coreDataArray objectAtIndex:i] valueForKey:@"product_id"] isEqualToString:dataToAddToCart[@"product_id"]]) {
             NSLog(@"sorry ");
            self.numberForCoreData = i;
            return item;
        }
    }
        
    }
    return dataToAddToCart;
}
- (IBAction)normalSubAction:(CartBtn *)sender {
    NSDictionary * item = [[self.catageryListArray[sender.indexPath.section] valueForKey:@"productList"] objectAtIndex:sender.indexPath.row];
    NSDictionary*requestItemDic = @{@"product_id":item[@"product_id"],@"product_weight":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_weight"],@"vendor_id":self.vendorId,@"branch_id":self.branchId,@"product_quantity":@"1",@"product_price":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_price"]};
    NSDictionary * reterningDic = [self isInCart:requestItemDic];
    NSUInteger quantity = [reterningDic[@"product_quantity"] integerValue];
    [self toDisPlayCartOrNot];
    if (quantity == 1) {
        NSDictionary* item1 = [self isInCart:item];
        [[ForCoreDataMethods networkManager]delectItemFromCoreData:[NSString stringWithFormat:@"%li",self.numberForCoreData]];
        [self.normalItemTableView reloadData];
    }
    else
    {
    quantity = quantity - 1;
        [[ForCoreDataMethods networkManager]upDataInCoreData:self.numberForCoreData product_id:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:[NSString stringWithFormat:@"%li",quantity] vendor_id:_vendorId branch_id:_branchId imageOfResturentURL:@"" addressOfResturent:@"" nameOfResturent:@""];
       // [[ForCoreDataMethods networkManager]upDataInCoreData:self.numberForCoreData product_id:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:[NSString stringWithFormat:@"%li",quantity] vendor_id:self.vendorId branch_id:self.branchId imageOfResturentURL:@"" ];
    [self.normalItemTableView reloadData];
    }
    
}
- (IBAction)normalPlusAction:(CartBtn *)sender {
    NSDictionary * item = [[self.catageryListArray[sender.indexPath.section] valueForKey:@"productList"] objectAtIndex:sender.indexPath.row];
     NSDictionary*requestItemDic = @{@"product_id":item[@"product_id"],@"product_weight":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_weight"],@"vendor_id":self.vendorId,@"branch_id":self.branchId,@"product_quantity":@"1",@"product_price":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_price"]};
    NSDictionary * reterningDic = [self isInCart:requestItemDic];
     NSUInteger quantity = [reterningDic[@"product_quantity"] integerValue];
    quantity = quantity + 1;
     [[ForCoreDataMethods networkManager]upDataInCoreData:self.numberForCoreData product_id:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:[NSString stringWithFormat:@"%li",quantity] vendor_id:_vendorId branch_id:_branchId imageOfResturentURL:@"" addressOfResturent:@"" nameOfResturent:@""];
   // [[ForCoreDataMethods networkManager]upDataInCoreData:self.numberForCoreData product_id:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:[NSString stringWithFormat:@"%li",quantity] vendor_id:self.vendorId branch_id:self.branchId imageOfResturentURL:@""];
    [self.normalItemTableView reloadData];
    [self toDisPlayCartOrNot];
}
- (IBAction)normalFirstTimeAddAction:(CartBtn *)sender {
    NSLog(@"normalFirstTimeAddAction button is press");
    NSDictionary * item = [[self.catageryListArray[sender.indexPath.section] valueForKey:@"productList"] objectAtIndex:sender.indexPath.row];
   // [self.dataOfResturentArray[sender.indexPath.row] valueForKey:@"product_sub_cat_id"];
     //NSDictionary * item = [[self.catageryListArray[indexPath.section] valueForKey:@"productList"] objectAtIndex:indexPath.row];
     NSDictionary*requestItemDic = @{@"product_id":item[@"product_id"],@"product_weight":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_weight"],@"vendor_id":self.vendorId,@"branch_id":self.branchId,@"product_quantity":@"1",@"product_price":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_price"]};
[[ForCoreDataMethods networkManager]storeDataInCoreData:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:@"1" vendor_id:self.vendorId branch_id:self.branchId imageOfResturentURL:@"" addressOfResturent:@"" nameOfResturent:@""];
    //[[ForCoreDataMethods networkManager]storeDataInCoreData:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:@"1" vendor_id:self.vendorId branch_id:self.branchId imageOfResturentURL:@""];
    [self.normalItemTableView reloadData];
    [self toDisPlayCartOrNot];
}

- (IBAction)recommendationAddAction:(CartBtn *)sender {
    NSDictionary * item = self.recomandedItemsResturentArray[sender.indexPath.row];
     NSDictionary*requestItemDic = @{@"product_id":item[@"product_id"],@"product_weight":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_weight"],@"vendor_id":self.vendorId,@"branch_id":self.branchId,@"product_quantity":@"1",@"product_price":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_price"]};
    [[ForCoreDataMethods networkManager]storeDataInCoreData:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:@"1" vendor_id:self.vendorId branch_id:self.branchId imageOfResturentURL:@"" addressOfResturent:@"" nameOfResturent:@""];
    //[[ForCoreDataMethods networkManager]storeDataInCoreData:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:@"1" vendor_id:self.vendorId branch_id:self.branchId imageOfResturentURL:@""];
    [self.forRecommendationTableView reloadData];
    [self toDisPlayCartOrNot];
}
- (IBAction)recommendatedSubAction:(CartBtn *)sender {
    NSDictionary * item = self.recomandedItemsResturentArray[sender.indexPath.row];
    NSDictionary*requestItemDic = @{@"product_id":item[@"product_id"],@"product_weight":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_weight"],@"vendor_id":self.vendorId,@"branch_id":self.branchId,@"product_quantity":@"1",@"product_price":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_price"]};
    NSDictionary * reterningDic = [self isInCart:requestItemDic];
    NSUInteger quantity = [reterningDic[@"product_quantity"] integerValue];
    if (quantity == 1) {
        NSDictionary* item1 = [self isInCart:item];
        [[ForCoreDataMethods networkManager]delectItemFromCoreData:[NSString stringWithFormat:@"%li",self.numberForCoreData]];
        NSArray*array = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
        [self.forRecommendationTableView reloadData];
    }
    else
    {
        quantity = quantity - 1;
        [[ForCoreDataMethods networkManager]upDataInCoreData:self.numberForCoreData product_id:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:[NSString stringWithFormat:@"%li",quantity] vendor_id:_vendorId branch_id:_branchId imageOfResturentURL:@"" addressOfResturent:@"" nameOfResturent:@""];
        [self.forRecommendationTableView reloadData];
    }
    [self toDisPlayCartOrNot];
}
- (IBAction)recommendatedPlusAction:(CartBtn *)sender {
    NSDictionary * item = self.recomandedItemsResturentArray[sender.indexPath.row];
    NSDictionary*requestItemDic = @{@"product_id":item[@"product_id"],@"product_weight":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_weight"],@"vendor_id":self.vendorId,@"branch_id":self.branchId,@"product_quantity":@"1",@"product_price":[[[item objectForKey:@"priceList"] objectAtIndex:0] valueForKey:@"product_price"]};
    NSDictionary * reterningDic = [self isInCart:requestItemDic];
    NSUInteger quantity = [reterningDic[@"product_quantity"] integerValue];
    quantity = quantity + 1;
     [[ForCoreDataMethods networkManager]upDataInCoreData:self.numberForCoreData product_id:requestItemDic[@"product_id"] product_weight:requestItemDic[@"product_weight"] product_price:requestItemDic[@"product_price"] product_quantity:[NSString stringWithFormat:@"%li",quantity] vendor_id:_vendorId branch_id:_branchId imageOfResturentURL:@"" addressOfResturent:@"" nameOfResturent:@""];
    [self.forRecommendationTableView reloadData];
    
}
@end
