//
//  MenuView.h
//  Servant
//
//  Created by Gopal on 16/6/9.
//  Copyright © 2017 Gopal. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MenuView : UIView

 
+(instancetype)MenuViewWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover;

/**
 *
 *
 *  @param dependencyView nothing
 *  @param leftmenuView nothing
 *  @param isCover nothing
 *
 *  @return self
 */
-(instancetype)initWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover;
    
/**
 *
 */
-(void)show;
/**
 *  nothing
 */
-(void)hidenWithoutAnimation;
/**
 *  nothing
 */
-(void)hidenWithAnimation;

@end
