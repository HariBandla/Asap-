
#import "DetailsOfResturentViewController.h"
//#import "DetailsOfResturentTableViewCell.h"
#import "DetailsOfResturentCell.h"
#import "MyCartViewController.h"
#import "NetWork.h"
#import "AsyncImageView.h"
@interface DetailsOfResturentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;

@property  UIView*addView;
@property UIButton*addButton;
@property UILabel*cellNumberOfItems;
@property NSArray*CatgeryName;
@property NSArray * SectionTitleArray;
@property NSArray * cellNameArray1;
@property NSArray * cellNameArray2;
@property NSArray * cellNameArray3;
@property NSMutableArray*isExpandable;

@end

@implementation DetailsOfResturentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self restarentDetailsData];
    self.CatgeryName = @[@"Veg",@"Non-Veg",@"Other",@"Sweets"];
    self.detailTableView.bounces = NO;
    [self.detailsOfResturentScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 2 * self.view.frame.size.height + 200)];
    self.itemsTableView.delegate = self;
    self.itemsTableView.dataSource = self;
    self.SectionTitleArray = @[@"Section1",@"Section2",@"Section3"];
    self.cellNameArray1 = @[@"cell1",@"cell2",@"cell3"];
    self.cellNameArray2 = @[@"cell1",@"cell2",@"cell3"];
    self.cellNameArray3 = @[@"cell1",@"cell2",@"cell3"];
    self.isExpandable =[[NSMutableArray alloc]init];
    for (int i = 0; i<self.SectionTitleArray.count; i++) {
        [self.isExpandable addObject:@"false"];
    }
    
    NSLog(@"is expandable is %@",self.isExpandable);
   // [self setupFoldingTableView];
    //[self.foldingTableView registerClass:[DetailsOfResturentTableViewCell self] forCellReuseIdentifier:@"detailsOfResturentTableViewCell1"];
//    [self.foldingTableView registerClass:self.detailsOfResturentScrollView forCellReuseIdentifier:@"cellid"];
    //tableView.register(NavigationNodeCell.self, forCellReuseIdentifier: "NavigationNodeCell")
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailsOfCellId" forIndexPath:indexPath];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width /2 - 1, 130);
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 10;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"detailsOfResturentTableViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = UIColor.cyanColor;
//    return cell;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}
//- (void)setupFoldingTableView
//{
////    self.automaticallyAdjustsScrollViewInsets = NO;
////    self.foldingTableView =[[FoldingTableView alloc]initWithFrame:CGRectMake(0, 0, self.footerView.frame.size.width, self.footerView.frame.size.height)];
////    _foldingTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
////    _foldingTableView.separatorInset = UIEdgeInsetsZero;
////    [self.footerView addSubview:self.foldingTableView];
////    _foldingTableView.foldingDelegate = self;
////
////    if (self.arrowPosition) {
////        _foldingTableView.foldingState = FoldingSectionStateShow;
////    }
//}
#pragma mark - TableViewDelegate / required
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.SectionTitleArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.isExpandable[section] isEqualToString:@"false"]) {
        return 0;
    }
    else
    {
        if (section == 0) {
            return self.cellNameArray1.count;
        }
        else if (section == 1) {
            return self.cellNameArray2.count;
        }
        else
        {
            return self.cellNameArray1.count;
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*viewForHeader = [[UIView alloc]init];
    viewForHeader.backgroundColor = UIColor.greenColor;
    UILabel*headerName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 40)];
    [viewForHeader addSubview:headerName];
    headerName.text = @"NameOfHeader";
    headerName.textColor = UIColor.redColor;
    UIButton*button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    //headerName.textAlignment  = NSTextAlignmentCenter;
    button.alpha = 0.1;
    button.tag = section;
    [viewForHeader addSubview:button];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [button setTitle:@"close" forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.yellowColor];
   // button.tintColor = UIColor.blackColor;
    [button addTarget:self action:@selector(forCloseOrOpen:) forControlEvents:UIControlEventTouchUpInside];
    return viewForHeader;
}
-(void)forCloseOrOpen:(UIButton*)button
{
    NSLog(@"hence the button tag is %li",button.tag);
    if ([self.isExpandable[button.tag] isEqualToString:@"false"]) {
        [self.isExpandable replaceObjectAtIndex:button.tag withObject:@"true"];
        NSLog(@"is expandable is %@",self.isExpandable);
        [self.itemsTableView reloadData];
    }
    else
    {
        [self.isExpandable replaceObjectAtIndex:button.tag withObject:@"false"];
        NSLog(@"is expandable is %@",self.isExpandable);
        [self.itemsTableView reloadData];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsOfResturentCell*cell = [tableView dequeueReusableCellWithIdentifier:@"DetailsOfResturentTableViewCell1" forIndexPath:indexPath];
    cell.nameOfItemLabel.text = self.cellNameArray1[indexPath.row];
   // cell.nameOfItemLabel.textAlignment  = NSTextAlignmentCenter;
    cell.priceOfItemLabel.text = self.cellNameArray1[indexPath.row];
    cell.AddButton.layer.borderWidth = 1;
    cell.AddButton.layer.borderColor = (UIColor.lightGrayColor).CGColor;
    [cell.AddButton addTarget:self action:@selector(forAddingOneItem) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    return view;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * view = [[UIView alloc]init];
//    return view;
//}
/*- (FoldingSectionHeaderArrowPosition)perferedArrowPositionForFoldingTableView:(FoldingTableView *)TableView
{
    return self.arrowPosition ? :FoldingSectionHeaderArrowPositionLeft;
}
- (NSInteger )numberOfSectionForFoldingTableView:(FoldingTableView *)TableView
{
    return self.CatgeryName.count;
}
- (NSInteger )FoldingTableView:(FoldingTableView *)TableView numberOfRowsInSection:(NSInteger )section
{
    return 4;
}
- (CGFloat )FoldingTableView:(FoldingTableView *)TableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )FoldingTableView:(FoldingTableView *)TableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSString *)FoldingTableView:(FoldingTableView *)TableView titleForHeaderInSection:(NSInteger)section
{
    return self.CatgeryName[section];
}
- (UITableViewCell *)FoldingTableView:(FoldingTableView *)TableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    DetailsOfResturentTableViewCell*cell = [TableView dequeueReusableCellWithIdentifier:@"detailsOfResturentTableViewCell1" forIndexPath:indexPath];
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, 100, 100)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"Label";
    [cell addSubview:label];
    cell.backgroundColor = UIColor.blueColor;
    //cell.button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
   // [cell.button setTitle:@"SriHari" forState:UIControlStateNormal];
    //cell.button.backgroundColor = [UIColor redColor];
//    UITableViewCell *cell = [TableView dequeueReusableCellWithIdentifier:cellID];
//    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    UILabel*priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, 100, 40)];
//
//    self.addView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 120, 10, 110, 50)];
    if (cell == nil) {
        cell = [[DetailsOfResturentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailsOfResturentTableViewCell1"];
    }
    else
    {
    }
//    self.cellNumberOfItems = [[UILabel alloc]initWithFrame:CGRectMake(self.addView.frame.size.width / 2 -10, self.addView.frame.size.height/2-10, 20, 20)];
//    UIButton*plusButton = [[UIButton alloc]initWithFrame:CGRectMake( 10, self.addView.frame.size.height/2-10, 20, 20)];
//    UIButton*subButton = [[UIButton alloc]initWithFrame:CGRectMake(self.addView.frame.size.width-30, self.addView.frame.size.height/2-10, 20, 20)];
//    [plusButton addTarget:self action:@selector(forAddingOneItem) forControlEvents:UIControlEventTouchUpInside];
//    [subButton addTarget:self action:@selector(forAddingOneItem) forControlEvents:UIControlEventTouchUpInside];
//    [self.addView addSubview:_cellNumberOfItems];
//    self.cellNumberOfItems.text = @"33";
//    plusButton.backgroundColor = UIColor.greenColor;
//    subButton.backgroundColor = UIColor.yellowColor;
//    [self.addView addSubview:plusButton];
//    [self.addView addSubview:subButton];
//    [self.cellNumberOfItems setFont:[UIFont systemFontOfSize:10]];
//    priceLabel.text = @"300";
//    label.text = @"Name of item";
//    self.addView.backgroundColor = UIColor.redColor;
//    [cell addSubview:self.addView];
//    [cell addSubview:priceLabel];
//    [cell addSubview:label];
//    return cell;
    return cell;
}*/
-(void)forAddingOneItem
{
    NSLog(@"Hence one Item is added");
}
//- (void )FoldingTableView:(FoldingTableView *)TableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [TableView deselectRowAtIndexPath:indexPath animated:YES];
//}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)viewCartBtn:(UIButton *)sender {
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyCartViewController*cartVc = [storyBoard instantiateViewControllerWithIdentifier:@"MyCartViewController"];
    [self.navigationController pushViewController:cartVc animated:YES];
}

-(void)restarentDetailsData
{
    NSDictionary * parms = @{@"vendorId":self.vendorId,@"branchId":self.branchId};
    [[NetWork networkManager]resturentDetails:parms complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        NSLog(@"resturentData %@",jsonDict);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
}

@end
