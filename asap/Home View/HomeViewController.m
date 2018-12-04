
#import "HomeViewController.h"
#import "BannersCollectionViewCell.h"
#import "CategoryCollectionViewCell.h"
#import "RecommendationCollectionViewCell.h"
#import "PopularCollectionViewCell.h"
#import "TopRatedCollectionViewCell.h"
#import "DetailsOfResturentViewController.h"
#import "TabBarViewController.h"
#import "OutletsTableViewCell.h"
#import "NetWork.h"
#import "AsyncImageView.h"
#import "ResturentItemsViewController.h"

typedef NS_ENUM(NSInteger, ContentType) {
    ContentTypeBanners = 0,
    ContentTypeCategory,
    ContentTypeRecommendations,
    ContentTypePopular,
    ContentTypeTopRated
};

@interface HomeViewController ()

@property NSArray*slideMenuArray;
@property NSDictionary * restrentDetailsDict;
@property NSDictionary * popularDetailsDict;
@property NSDictionary * topRatedDetailsDict;
@property NSArray * restrentDetailsArray;
@property NSArray * popularDetailsArray;
@property NSArray * topRatedDetailsArray;
@property NSArray * forOutletsArray;
@property NSArray * categoryArray;
@property NSArray * bannersArray;
@property int numberInBaner;

@end
@implementation HomeViewController
NSTimer * scrollingTimer;

#pragma mark Methods For View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.outletsView.hidden = YES;
    self.restrentDetailsDict = [[NSDictionary alloc]init];
    
    [self loadRestarentDetails];
    [self CatagoryData];
    [self BannersData];
    
     self.numberInBaner = 0;
     scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(strtTimer) userInfo:nil repeats:YES];
    
    self.slideMenuArray = @[@"Contact Us",@"Location",@"Restaurants",@"Deals",@"Profile",@"Address Book",@"Reviews",@"About Us",@"FAQ",@"Sign Out"];
    //[tabBar setSelectedItem: [tabBar.items objectAtIndex:0]];
  
    UITapGestureRecognizer*topper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSlidePlan:)];
    topper.numberOfTapsRequired=1;
    [transv addGestureRecognizer:topper];
    
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [transv setHidden:YES];
    [self.outletsView setHidden:YES];
//    [self.navigationController setNavigationBarHidden:YES];
//    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    CGFloat  hight1 = [[UIScreen mainScreen] bounds].size.height;
    CGRect frame=CGRectMake(0, 0, slidePlanel.layer.frame.size.width, hight1);
    frame.origin.x=-slidePlanel.frame.size.width;
    slidePlanel.frame=frame;
}
-(void)viewDidDisappear:(BOOL)animated
{
     self.tabBarController.tabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES];
//[self.tabBarController.navigationController setNavigationBarHidden:NO];
}
#pragma mark Methods For slide menu
-(void)hideSlidePlan:(UITapGestureRecognizer*)gusture
{
    self.outletsView.hidden = YES;
     self.tabBarController.tabBar.hidden = NO;
    if (gusture.state == UIGestureRecognizerStateEnded)
    {
        [transv setHidden:YES];
        [UIView transitionWithView:slidePlanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGFloat  hight1 = [[UIScreen mainScreen] bounds].size.height;
            CGRect frame=CGRectMake(0, 0, slidePlanel.layer.frame.size.width, hight1);
            frame.origin.x=-slidePlanel.frame.size.width;
            slidePlanel.frame=frame;
            
            //self->slidePlanel.layer.frame.size.height = hight1;
        } completion:nil];
        
    }
}

-(IBAction)buttonPassed:(id)sender
{
    [transv setHidden:NO];
    [slidePlanel setHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
    if (sender == menuBtn)
    {
        CGFloat  hight1 = [[UIScreen mainScreen] bounds].size.height;
        [UIView transitionWithView:slidePlanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame=slidePlanel.frame;
            frame.origin.x=0;
            slidePlanel.frame=frame;
        } completion:nil];
    }
    
}
#pragma mark Methods For Button Action



#pragma mark Methods For CollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == ContentTypeBanners) {
        
        if (self.bannersArray.count == 0 ) {
            return 0;
        }
        else
        {
            return self.bannersArray.count;
        }
    }
    else if (collectionView.tag == ContentTypeCategory){
        return 10;
    }
    else if (collectionView.tag == ContentTypeRecommendations){
        return self.restrentDetailsArray.count;
    }
    else if (collectionView.tag == ContentTypePopular){
        return self.popularDetailsArray.count;

    }
    else  // contentTypeTopRated
    {
       return self.topRatedDetailsArray.count;

    }
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (collectionView.tag == ContentTypeBanners) {
        BannersCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannersCollectionViewCell" forIndexPath:indexPath];
         NSDictionary* bannersDict = self.bannersArray[indexPath.row];
        NSString *imageUrl  =  [bannersDict[@"image"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        cell.bannerImage.imageURL = [NSURL URLWithString:imageUrl];
        return cell;
    }
    else if (collectionView.tag == ContentTypeCategory){
        CategoryCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
//        if (indexPath.row == 7) {
//            cell.categoryItemLabel.text = @"ViewAll";
//           // cell.catagoryItemImage.image = @"";
//        }
//        else{
            NSDictionary* catagoryItenDict = self.categoryArray[indexPath.row];
            cell.categoryItemLabel.text = catagoryItenDict[@"category_name"];
            NSString *imageUrl  =  [catagoryItenDict[@"category_appimage"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            cell.catagoryItemImage.imageURL = [NSURL URLWithString:imageUrl];
       // }
        return cell;
    }
    else if (collectionView.tag == ContentTypeRecommendations){
        RecommendationCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendationCollectionViewCell" forIndexPath:indexPath];
        
        self.restrentDetailsDict = self.restrentDetailsArray[indexPath.row];
        cell.restarentName.text = self.restrentDetailsDict[@"restaurant_name"];
        cell.outLetsLabel.text = [NSString stringWithFormat:@"%@ Outlets Near You",self.restrentDetailsDict[@"outlet"]];
        cell.timeLabel.text =  [NSString stringWithFormat:@"%@ mins",self.restrentDetailsDict[@"delivery_time"]];
        cell.minOrderPrice.text = [NSString stringWithFormat:@"Rs.%@ min Order",self.restrentDetailsDict[@"min_order"]];
        NSString *imageUrl  =  [self.restrentDetailsDict[@"app_logo"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        cell.recommendRestarentImage.imageURL = [NSURL URLWithString:imageUrl];
        cell.forOutLetsButton.tag = indexPath.row;
        cell.layer.cornerRadius = 10;
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [UIColor blackColor].CGColor;
        cell.clipsToBounds = YES;
        return cell;
    }
    else if (collectionView.tag == ContentTypePopular){
        PopularCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PopularCollectionViewCell" forIndexPath:indexPath];
        self.popularDetailsDict = self.popularDetailsArray[indexPath.row];
        cell.restarentName.text = self.popularDetailsDict[@"restaurant_name"];
        cell.layoutsLable.text = [NSString stringWithFormat:@"%@ Outlets Near You",self.popularDetailsDict[@"outlet"]];
        cell.timeLabel.text =  [NSString stringWithFormat:@"%@ mins",self.popularDetailsDict[@"delivery_time"]];
        cell.minOrderLabel.text = [NSString stringWithFormat:@"Rs.%@ min Order",self.popularDetailsDict[@"min_order"]];
        NSString *imageUrl  =  [self.popularDetailsDict[@"app_logo"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        cell.restarentItemImage.imageURL = [NSURL URLWithString:imageUrl];
        
        cell.layer.cornerRadius = 10;
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [UIColor blackColor].CGColor;
        cell.clipsToBounds = YES;
        return cell;
        
    }
    else  // contentTypeTopRated
    {
        TopRatedCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopRatedCollectionViewCell" forIndexPath:indexPath];
        self.topRatedDetailsDict = self.topRatedDetailsArray[indexPath.row];
        cell.restarentName.text = self.topRatedDetailsDict[@"restaurant_name"];
        cell.layoutsLabel.text = [NSString stringWithFormat:@"%@ Outlets Near You",self.topRatedDetailsDict[@"outlet"]];
        cell.timeLabel.text =  [NSString stringWithFormat:@"%@ mins",self.topRatedDetailsDict[@"delivery_time"]];
        cell.minOrderLabel.text = [NSString stringWithFormat:@"Rs.%@ min Order",self.topRatedDetailsDict[@"min_order"]];
        NSString *imageUrl  =  [self.topRatedDetailsDict[@"app_logo"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        cell.restarentItemImage.imageURL = [NSURL URLWithString:imageUrl];
        
        cell.layer.cornerRadius = 10;
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [UIColor blackColor].CGColor;
        cell.clipsToBounds = YES;
        return cell;
        
    }
   
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == ContentTypeBanners) {
//        UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        DetailsOfResturentViewController*viewController = [storyBoard instantiateViewControllerWithIdentifier:@"DetailsOfResturentViewControllerID"];
//        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (collectionView.tag == ContentTypeCategory){
        
//        UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        DetailsOfResturentViewController*viewController = [storyBoard instantiateViewControllerWithIdentifier:@"DetailsOfResturentViewControllerID"];
//        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (collectionView.tag == ContentTypeRecommendations){
        
        UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ResturentItemsViewController*viewController = [storyBoard instantiateViewControllerWithIdentifier:@"ResturentItemsViewController"];
      //  NSDictionary * recommendationsDic = [self.restrentDetailsArray objectAtIndex:indexPath.row];
        NSDictionary * recommendationsDic = self.restrentDetailsArray [indexPath.row];
        viewController.branchId = recommendationsDic[@"branch_code"];
        viewController.vendorId = recommendationsDic[@"vendor_code"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (collectionView.tag == ContentTypePopular){
        
        UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ResturentItemsViewController*viewController = [storyBoard instantiateViewControllerWithIdentifier:@"ResturentItemsViewController"];
        NSDictionary * recommendationsDic = self.popularDetailsArray[indexPath.row];
        viewController.branchId = recommendationsDic[@"branch_code"];
        viewController.vendorId = recommendationsDic[@"vendor_code"];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    else  // contentTypeTopRated
    {
        UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ResturentItemsViewController*viewController = [storyBoard instantiateViewControllerWithIdentifier:@"ResturentItemsViewController"];
        NSDictionary * recommendationsDic = self.topRatedDetailsArray[indexPath.row];
        viewController.branchId = recommendationsDic[@"branch_code"];
        viewController.vendorId = recommendationsDic[@"vendor_code"];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    if (collectionView.tag == ContentTypeBanners) {
        
        return CGSizeMake( self.bannersCollectionView.frame.size.width, self.bannersCollectionView.frame.size.height);
    }
    else if (collectionView.tag == ContentTypeCategory){
        return CGSizeMake(self.categoryCollectionView.frame.size.width/4-2, 80);
    }
    
    else
    {
        return CGSizeMake(160, 200);
    }
}
#pragma mark Methods For Tableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // return self.slideMenuArray.count;
    
    if (tableView.tag == 0) {
       
        return self.slideMenuArray.count;
    }
    else{
        return self.forOutletsArray.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 0) {
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"homeTableCellID" forIndexPath:indexPath];
        cell.textLabel.text = self.slideMenuArray[indexPath.row];
        return cell;
        
    }
    else{
        NSDictionary * items = [self.forOutletsArray objectAtIndex:indexPath.row];
        OutletsTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.addressLabel.text = items[@"branch_adress"];
        cell.reatingLabel.text = [NSString stringWithFormat:@"%@",items[@"rating"]];
        cell.deliverTimeLabel.text = [NSString stringWithFormat:@"%@Mins",items[@"delivery_time"]];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 0) {
        
        if (indexPath.row == 2) {
            UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TabBarViewController*homeView = [storyBoard instantiateViewControllerWithIdentifier:@"TabbarId"];
            homeView.selectedViewController = homeView.viewControllers[1];
            [self.navigationController pushViewController:homeView animated:YES];
        }
        else if (indexPath.row == 3) {
            UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TabBarViewController*homeView = [storyBoard instantiateViewControllerWithIdentifier:@"TabbarId"];
            homeView.selectedViewController = homeView.viewControllers[4];
            [self.navigationController pushViewController:homeView animated:YES];
        }
        else
        {
            UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController*view = [storyBoard instantiateViewControllerWithIdentifier:@"ShowAddressViewController"];
            [self.tabBarController.navigationController pushViewController:view animated:YES];
        }
        
    }
    else{
        
        UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailsOfResturentViewController*view = [storyBoard instantiateViewControllerWithIdentifier:@"DetailsOfResturentViewControllerID"];
          NSDictionary * recommendationsDic = [self.restrentDetailsArray objectAtIndex:indexPath.row];
        view.branchId = recommendationsDic[@"branch_code"];
        view.vendorId = recommendationsDic[@"vendor_code"];
        [self.tabBarController.navigationController pushViewController:view animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        return 40;
    }
    else{
        return 65;
    }
}

-(void)strtTimer
{

    NSInteger section = [self numberOfSectionsInCollectionView:self.bannersCollectionView] - 1;
    NSInteger item = [self collectionView:self.bannersCollectionView numberOfItemsInSection:section] - 1;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:self.numberInBaner inSection:section];

    [self.bannersCollectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

    if (self.numberInBaner < self.bannersArray.count-1) {
        self.numberInBaner = self.numberInBaner + 1;
    }
    else
    {
        self.numberInBaner = 0;
    }
}

-(void)Outlets{
    self.outletsView.hidden = NO;
    transv.hidden = NO;
}
- (IBAction)OutletsButton:(UIButton *)sender {
    self.outletResturentImageView.imageURLString = [[self.restrentDetailsArray objectAtIndex:sender.tag] valueForKey:@"app_logo"];
    self.outletsNumberLabel.text =[NSString stringWithFormat:@"%@ Outlets near you",[[self.restrentDetailsArray objectAtIndex:sender.tag] valueForKey:@"outlet"]];
    self.outletRestuerentNameLabel.text = [[self.restrentDetailsArray objectAtIndex:sender.tag] valueForKey:@"restaurant_name"];
    self.forOutletsArray = [[self.restrentDetailsArray objectAtIndex:sender.tag] valueForKey:@"outletList"];
    [self.outletsTableview reloadData];
    [self Outlets];
}

- (IBAction)secondOutletBtn:(UIButton *)sender {
    self.outletResturentImageView.imageURLString = [[self.popularDetailsArray objectAtIndex:sender.tag] valueForKey:@"app_logo"];
    self.outletsNumberLabel.text =[NSString stringWithFormat:@"%@ Outlets near you",[[self.popularDetailsArray objectAtIndex:sender.tag] valueForKey:@"outlet"]];
    self.outletRestuerentNameLabel.text = [[self.popularDetailsArray objectAtIndex:sender.tag] valueForKey:@"restaurant_name"];
    self.forOutletsArray = [[self.popularDetailsArray objectAtIndex:sender.tag] valueForKey:@"outletList"];
    [self.outletsTableview reloadData];
    [self Outlets];
}

- (IBAction)thirdOutletBtn:(UIButton *)sender {
    self.outletResturentImageView.imageURLString = [[self.topRatedDetailsArray objectAtIndex:sender.tag] valueForKey:@"app_logo"];
    self.outletsNumberLabel.text =[NSString stringWithFormat:@"%@ Outlets near you",[[self.topRatedDetailsArray objectAtIndex:sender.tag] valueForKey:@"outlet"]];
    self.outletRestuerentNameLabel.text = [[self.topRatedDetailsArray objectAtIndex:sender.tag] valueForKey:@"restaurant_name"];
    self.forOutletsArray = [[self.topRatedDetailsArray objectAtIndex:sender.tag] valueForKey:@"outletList"];
    [self.outletsTableview reloadData];
    [self Outlets];
}


-(void)loadRestarentDetails
{
    NSString * url = @"http://asapfood.in/dev/api/restaurant";
    NSDictionary * params = @{@"lat":@"17.10",@"long":@"101010.4785"};
    [[NetWork networkManager]ForRestaurestListUrl:url getRestaurestList:params completa:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
       // NSLog(@"hence RestarentDetailsdata is %@",jsonDict);
        if (jsonDict != nil) {
            self.restrentDetailsArray = jsonDict[@"recomandedList"];
            self.popularDetailsArray = jsonDict[@"papularList"];
            self.topRatedDetailsArray = jsonDict[@"topRatedList"];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.recommendationCollectionView reloadData];
            [self.popularCollectionView reloadData];
            [self.topRatedCollectionView reloadData];

        });
        }
    }];
}

-(void)CatagoryData
{
     NSString * url = @"http://asapfood.in/dev/api/category";
    [[NetWork networkManager]getCategoryData:url completa:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        
        if (jsonDict != nil) {
            self.categoryArray = jsonDict[@"list"];
          //  NSLog(@"hence RestarentDetailsdata is %@",self.categoryArray);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.categoryCollectionView reloadData];
            });
        }
    }];
}
-(void)BannersData
{
    NSString * url = @"http://asapfood.in/dev/api/banner";
    [[NetWork networkManager]getBannersData:url completa:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"hence RestarentDetailsdata is %@",jsonDict);
        if (jsonDict != nil) {
            self.bannersArray = jsonDict[@"list"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.bannersCollectionView reloadData];
            });
        }
    }];
}
@end
