//
//  LeftMenuView.h
//  Servant
//
//  Created by Gopal on 16/6/12.
//  Copyright © 2017 Gopal. All rights reserved.
//
 
#import <UIKit/UIKit.h>

@interface SubMenuItemHeader : NSObject

@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *imageName;
@property(nonatomic, strong)NSArray *subMenuItems;

@end


@interface MenuItem : NSObject

@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *imageName;

@end



@protocol MenuViewDelegate <NSObject>
-(void)menuDidSelected:(MenuItem *)menuItem;
@end





@interface LeftMenuView : UIView

@property (nonatomic ,weak)id <MenuViewDelegate> delegate;

+(LeftMenuView *)leftMenuView;

-(void)initWithFrame:(CGRect)frame withMenuData:(NSArray *)menu;

+(NSArray *)loadMenuItems;
+(CGRect)getMenuViewFrame;


@end
