//
//  LeftMenuView.m
//  Servant
//
//  Created by Gopal on 16/6/12.
//  Copyright © 2017 Gopal. All rights reserved.
//
#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200
#define Font [UIFont fontWithName:@"HelveticaNeue-Light" size:12]
#define TableBackGroundColor [UIColor colorWithRed:249/255.0 green:161/255.0 blue:31/255.0 alpha:0.6]

#import "LeftMenuView.h"

@implementation MenuItem @end
@implementation SubMenuItemHeader @end


@interface LeftMenuView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView    *contentTableView;
@property (nonatomic ,strong)NSArray    *menuData;

@end

@implementation LeftMenuView

static LeftMenuView *_sharedMySingleton = nil;

+(LeftMenuView *)leftMenuView {
    @synchronized([LeftMenuView class]) {
        if (!_sharedMySingleton)
            _sharedMySingleton = [[self alloc] init];
        return _sharedMySingleton;
    }
    return nil;
}

+(NSArray *)loadMenuItems
{
    NSMutableArray *subMenuItems = [[NSMutableArray alloc] init];
    {
        
        NSArray *titles = @[@"My Account",@"My Orders",@"About Us",@"Services",@"Testimonals",@"Partners",@"Brands",@"Feedback",@"Notifications",@"FAQS",@"Return Policy",@"Help Center",@"Contact Us"];
        NSArray *images = @[@"account",@"myOrders",@"about",@"settings",@"testimonals",@"partners",@"brands",@"feedback",@"notifications",@"faqs",@"returnPolicy",@"helpCenter",@"contact"];
        
        for (int i=0; i<titles.count; i++)
        {
            MenuItem *item = [[MenuItem alloc] init];
            item.title = titles[i];
            item.imageName = images[i];
            [subMenuItems addObject:item];
        }
    }
    
    //    NSMutableArray *subMenuItems2 = [[NSMutableArray alloc] init];
    //    {
    //        MenuItem *item = [[MenuItem alloc] init];
    //        item.title = @"Share";
    //        item.imageName = @"";
    //
    //        MenuItem *item2 = [[MenuItem alloc] init];
    //        item2.title = @"Send";
    //        item2.imageName = @"";
    //
    //        [subMenuItems2 addObject:item];
    //        [subMenuItems2 addObject:item2];
    //    }
    
    
    NSMutableArray *menuItems = [[NSMutableArray alloc] init];
    {
        SubMenuItemHeader *subMenu = [[SubMenuItemHeader alloc] init];
        subMenu.title = @"";
        subMenu.imageName = @"";
        subMenu.subMenuItems = subMenuItems;
        
        //        SubMenuItemHeader *subMenu2 = [[SubMenuItemHeader alloc] init];
        //        subMenu2.title = @"Communicate";
        //        subMenu2.imageName = @"";
        //        subMenu2.subMenuItems = subMenuItems2;
        
        [menuItems addObject:subMenu];
        //        [menuItems addObject:subMenu2];
    }
    
    return menuItems;
}

+(CGRect)getMenuViewFrame
{
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 0.7, [[UIScreen mainScreen] bounds].size.height);
}

-(instancetype)init
{
    if(self = [super init])
    {
    }
    return  self;
}

 
-(void)initWithFrame:(CGRect)frame withMenuData:(NSArray *)menu
{
    if(self){
        self.frame = frame;
        self.menuData = menu;
        [self initView];
        }
}

-(void)initView{

    self.backgroundColor = [UIColor whiteColor];
    CGFloat height = 130;
    
    UIView *headerView     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Frame_Width, height)];
    [headerView setBackgroundColor:TableBackGroundColor];//[UIColor colorWithRed:21/255.0 green:139/255.0 blue:149/255.0 alpha:1]];
    CGFloat width          = height/2;
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(12, (height - width) / 2, width, width)];
//    [imageview setBackgroundColor:[UIColor redColor]];
    imageview.layer.cornerRadius = imageview.frame.size.width / 2;
    imageview.layer.masksToBounds = YES;
    [imageview setImage:[UIImage imageNamed:@"HeadIcon"]];
    [headerView addSubview:imageview];
    
    
    width                  = 15;
    UIImageView *arrow     = [[UIImageView alloc]initWithFrame:CGRectMake(Frame_Width - width - 10, (height - width)/2, width, width)];
    arrow.contentMode      = UIViewContentModeScaleAspectFit;
    [arrow setImage:[UIImage imageNamed:@"person-icon0"]];
    [headerView addSubview:arrow];
    
    UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.size.width + imageview.frame.origin.x * 2, imageview.frame.origin.y, height, imageview.frame.size.height)];
    [NameLabel setText:@""];
    [headerView addSubview:NameLabel];
    
    [self addSubview:headerView];
    
    
    
    UITableView *contentTableView        = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, Frame_Width, self.frame.size.height - headerView.frame.size.height)
                                                                       style:UITableViewStylePlain];
    [contentTableView setBackgroundColor:TableBackGroundColor];
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    contentTableView.tableFooterView = [UIView new];
    self.contentTableView = contentTableView;
    [self addSubview:contentTableView];
    
    
    contentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    
    
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50, Frame_Width, 50)];
//    [footerView setBackgroundColor:[UIColor lightGrayColor]];
//
//    [self addSubview:footerView];
}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.menuData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SubMenuItemHeader *subMenuHeader = self.menuData[section];
    NSArray *subMenus = subMenuHeader.subMenuItems;
    return subMenus.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"LeftView%li",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    cell.hidden = NO;
    
    SubMenuItemHeader *subMenuHeader = self.menuData[indexPath.section];
    NSArray *subMenus = subMenuHeader.subMenuItems;
    MenuItem *item = subMenus[indexPath.row];
    
//    //[cell.imageView setImage:[UIImage imageNamed:item.imageName]];
//    [cell.textLabel setText:item.title];
//    [cell.textLabel setFont:Font];
//    [cell.textLabel setTextColor:[UIColor blackColor]];
//
//    [cell.imageView setFrame:CGRectMake(20, 20, 30, 30)];
//    [cell.imageView setBackgroundColor:[UIColor redColor]];
    
    
    
    
    UIImageView *icon     = [[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 30, 30)];
    icon.contentMode      = UIViewContentModeScaleAspectFit;
    [icon setImage:[UIImage imageNamed:item.imageName]];
    [icon setBackgroundColor:[UIColor clearColor]];
    
    [cell.contentView addSubview:icon];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 13, cell.frame.size.width, 20)];
    [titleLabel setText:item.title];
    [titleLabel setFont:Font];
    [cell.contentView addSubview:titleLabel];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self.delegate respondsToSelector:@selector(menuDidSelected:)]){
        SubMenuItemHeader *subMenuHeader = self.menuData[indexPath.section];
        NSLog(@"MENUDATA      --      %@",self.menuData[indexPath.section]);
        NSArray *subMenus = subMenuHeader.subMenuItems;
    NSLog(@"MENUDATA      --      %@",subMenus[indexPath.row]);
        MenuItem *item = subMenus[indexPath.row];
        //MenuItem*item2 = indexPath.row;
        [self.delegate menuDidSelected:item];
        NSLog(@"index path row          %ld",(long)indexPath.row);
    }
}



@end
