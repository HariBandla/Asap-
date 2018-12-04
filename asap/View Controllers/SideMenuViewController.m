
//
//  SideMenuViewController.m
//  asap
//
//  Created by Hari on 30/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "SideMenuViewController.h"
#import "LeftMenuView.h"
#import "MenuView.h"
@interface SideMenuViewController ()<MenuViewDelegate>
- (IBAction)menuAction:(UIButton *)sender;
@property (nonatomic ,strong)MenuView   * menu;
//@property (weak, nonatomic) IBOutlet UIButton *menu;
@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LeftMenuView *leftMenuView = [LeftMenuView leftMenuView];
    leftMenuView.delegate = self;
   self.menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:leftMenuView isShowCoverView:YES];
    // Do any additional setup after loading the view.
}
-(NSArray *)loadMenuItems
{
    NSMutableArray *subMenuItems = [[NSMutableArray alloc] init];
    {
        MenuItem *item = [[MenuItem alloc] init];
        item.title = @"Import";
        item.imageName = @"";
        
        MenuItem *item2 = [[MenuItem alloc] init];
        item2.title = @"Gallery";
        item2.imageName = @"";
        
        MenuItem *item3 = [[MenuItem alloc] init];
        item3.title = @"Slideshow";
        item3.imageName = @"";
        
        MenuItem *item4 = [[MenuItem alloc] init];
        item4.title = @"Tools";
        item4.imageName = @"";
        
        [subMenuItems addObject:item];
        [subMenuItems addObject:item2];
        [subMenuItems addObject:item3];
        [subMenuItems addObject:item4];
    }
    
    NSMutableArray *subMenuItems2 = [[NSMutableArray alloc] init];
    {
        MenuItem *item = [[MenuItem alloc] init];
        item.title = @"Share";
        item.imageName = @"";
        
        MenuItem *item2 = [[MenuItem alloc] init];
        item2.title = @"Send";
        item2.imageName = @"";
        
        [subMenuItems2 addObject:item];
        [subMenuItems2 addObject:item2];
    }
    
    
    NSMutableArray *menuItems = [[NSMutableArray alloc] init];
    {
        SubMenuItemHeader *subMenu = [[SubMenuItemHeader alloc] init];
        subMenu.title = @"";
        subMenu.imageName = @"";
        subMenu.subMenuItems = subMenuItems;
        
        SubMenuItemHeader *subMenu2 = [[SubMenuItemHeader alloc] init];
        subMenu2.title = @"Communicate";
        subMenu2.imageName = @"";
        subMenu2.subMenuItems = subMenuItems2;
        
        [menuItems addObject:subMenu];
        [menuItems addObject:subMenu2];
    }
    
    return menuItems;
}
-(CGRect)getMenuViewFrame
{
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 0.8, [[UIScreen mainScreen] bounds].size.height);
}

- (IBAction)menuAction:(UIButton *)sender {
     [self.menu show];
}
-(void)menuDidSelected:(MenuItem *)menuItem
{
    [self.menu hidenWithAnimation];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@ Identifier",menuItem.title]];
//    NSLog(@" %@ Identifier",menuItem.title);
//    [self.navigationController pushViewController:viewController animated:YES];
}
@end
