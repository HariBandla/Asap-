//
//  MenuView.m
//  Servant
//
//  Created by Gopal on 16/6/9.
//  Copyright © 2017 Gopal. All rights reserved.
//


// nothing
#define kSCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define kSCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

//#define MenuView_scale_of_Screen        0.8
#define CoverViewAlpha                  0.7

#define CoverViewBackGround [UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1.0]

#import "MenuView.h"

@interface MenuView ()

@property (nonatomic ,assign)CGRect         menuViewframe;
@property (nonatomic ,assign)CGRect         coverViewframe;
@property (nonatomic ,strong)UIView         *coverView;
@property (nonatomic ,strong)UIView         *leftMenuView; 
@property (nonatomic ,assign)BOOL           isShowCoverView;;

@end


@implementation MenuView



+(instancetype)MenuViewWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover{
    
    MenuView *menu = [[MenuView alloc]initWithDependencyView:dependencyView MenuView:leftmenuView isShowCoverView:isCover];
    
    return menu;
}


-(instancetype)initWithDependencyView:(UIView *)dependencyView MenuView:(UIView *)leftmenuView isShowCoverView:(BOOL)isCover{
    
    if(self = [super init]){
        self.isShowCoverView = isCover;

        [self addPanGestureAtDependencyView:dependencyView];
        self.leftMenuView = leftmenuView;
//      if((CGRectEqualToRect(_coverViewframe, CGRectZero)) == NO){
        self.menuViewframe = leftmenuView.frame;
//      }else{
//      }
        self.coverViewframe = CGRectMake(self.menuViewframe.size.width, self.menuViewframe.origin.y, kSCREEN_WIDTH - self.menuViewframe.size.width, self.menuViewframe.size.height);
    }
    return self;
}

-(void)setIsShowCoverView:(BOOL)isShowCoverView
{
    _isShowCoverView = isShowCoverView;

    if(self.isShowCoverView){
        self.coverView.backgroundColor = CoverViewBackGround;
    }else{
        self.coverView.backgroundColor = [UIColor clearColor];
    }

}

-(void)addPanGestureAtDependencyView:(UIView *)dependencyView{
    
    // pangesture
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture = \
    [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleLeftEdgeGesture:)];
    leftEdgeGesture.edges                             = UIRectEdgeLeft;// direction
    [dependencyView addGestureRecognizer:leftEdgeGesture]; //
}


//-(void)initView{

//    if(self.isShowCoverView){
//        self.coverView.backgroundColor = CoverViewBackGround;
//    }else{
//        self.coverView.backgroundColor = [UIColor clearColor];
//    }
//    
//    [self setBackgroundColor:[UIColor clearColor]];
//    [self.leftMenuView setBackgroundColor:MenuViewBackgroundColor];
//}


-(void)show{
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.coverView];
    [window addSubview:self.leftMenuView];
    
    self.leftMenuView.frame = CGRectMake(-self.menuViewframe.size.width, self.menuViewframe.origin.y, self.menuViewframe.size.width, self.menuViewframe.size.height);
    self.coverView.frame = CGRectMake(0, 0, 200, self.menuViewframe.size.height);
 //kSCREEN_WIDTH
    [UIView animateWithDuration:0.3 animations:^{
        
        self.leftMenuView.frame = self.menuViewframe;
        self.coverView.frame    = self.coverViewframe;
        self.coverView.alpha = CoverViewAlpha;
    }];
}



-(void)hidenWithoutAnimation{
    
    [self removeCoverAndMenuView];
}
-(void)hidenWithAnimation{
    
    [self coverTap];
}


#pragma mark - create left view
-(UIView *)leftMenuView{
    
    if(_leftMenuView == nil){
        
        UIView *LeftView = [[UIView alloc]initWithFrame:self.menuViewframe];
        _leftMenuView    = LeftView;
        
    }
    return _leftMenuView;
}


#pragma mark - Design coverview
-(UIView *)coverView {
    
    if (_coverView == nil) {
        
        UIView *Cover = [[UIView alloc]initWithFrame:self.coverViewframe];
        Cover.backgroundColor                     = CoverViewBackGround;
        Cover.alpha                               = 0;
        UITapGestureRecognizer *Click             = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverTap)];
        [Cover addGestureRecognizer:Click];
        
        UIGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(handleftPan:)];
        
        [Cover addGestureRecognizer:panGestureRecognizer];
        [Click requireGestureRecognizerToFail:panGestureRecognizer];
        
        _coverView = Cover;
    }
    return _coverView;
}


#pragma mark - gesture delegate methods
- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture{
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.coverView];
    [window addSubview:self.leftMenuView];

    // calculating points
    CGPoint translation = [gesture translationInView:gesture.view];
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state){
        
        if(translation.x <= self.menuViewframe.size.width){// && self.leftMenuView.frame.origin.x != 0
            
            if(translation.x <= 10){
                self.coverView.frame = CGRectMake(0, self.menuViewframe.origin.y, kSCREEN_WIDTH, self.menuViewframe.size.height);
            }
            
            CGFloat x           = translation.x  - self.menuViewframe.size.width;
            CGFloat y           = self.menuViewframe.origin.y;
            CGFloat w           = self.menuViewframe.size.width;
            CGFloat h           = self.menuViewframe.size.height;
            self.leftMenuView.frame = CGRectMake(x, y, w, h);
            
            self.coverView.frame    = CGRectMake(self.leftMenuView.frame.size.width+x, 0,kSCREEN_WIDTH-self.leftMenuView.frame.size.width-x, h);
            self.coverView.alpha    = CoverViewAlpha*(translation.x / w);
        }else{
            
            self.leftMenuView.frame = self.menuViewframe;
            self.coverView.frame = self.coverViewframe;
        }
    }
    else{
        //direction
        if(translation.x > self.menuViewframe.size.width/2){
            // openview of menu
            [self openMenuView];
        }else{
            // close menu
            [self closeMenuView];
        }
        
    }
}


#pragma mark - coverView gesture methods
-(void)handleftPan:(UIPanGestureRecognizer*)recognizer{
    
    CGPoint translation = [recognizer translationInView:recognizer.view];
    static CGFloat BeganX;
    
    if(UIGestureRecognizerStateBegan == recognizer.state){
        BeganX = translation.x;
    }
    
    CGFloat Place = (-translation.x) - (-BeganX);
    
    if(UIGestureRecognizerStateBegan == recognizer.state ||
       UIGestureRecognizerStateChanged == recognizer.state){

        CGFloat x           = 0 ;
        CGFloat y           = self.menuViewframe.origin.y;
        CGFloat w           = self.menuViewframe.size.width;
        CGFloat h           = self.menuViewframe.size.height;

        if(Place <= self.leftMenuView.frame.size.width &&  Place >0){
            
            x  = 0 - Place;

//            self.leftMenuView.frame = CGRectMake(x, y, w, h);

            self.coverView.frame    = CGRectMake(self.leftMenuView.frame.size.width-Place, 0,kSCREEN_WIDTH-self.leftMenuView.frame.size.width+Place, h);
            self.coverView.alpha    = CoverViewAlpha*((w - Place) / w);

        }else if(Place >0){
            
             x  = - self.menuViewframe.size.width;
//            CGFloat y           = self.menuViewframe.origin.y;
//            CGFloat w           = self.menuViewframe.size.width;
//            CGFloat h           = self.menuViewframe.size.height;
//            self.leftMenuView.frame = CGRectMake(x, y, w, h);//self.LeftViewFrame;
            self.coverView.frame    = CGRectMake(0, 0,kSCREEN_WIDTH,h);
            
        }else{
            
            x = 0;
//            CGFloat y           = self.menuViewframe.origin.y;
//            CGFloat w           = self.menuViewframe.size.width;
//            CGFloat h           = self.menuViewframe.size.height;

            self.coverView.frame    = CGRectMake(self.leftMenuView.frame.size.width, 0,kSCREEN_WIDTH-self.leftMenuView.frame.size.width, h);
            self.coverView.alpha    = CoverViewAlpha;
        }

         self.leftMenuView.frame = CGRectMake(x, y, w, h);

        
    }else{
        //proper action
        if(Place > self.menuViewframe.size.width/2){
            // close menu
            [self closeMenuView];
            
        }else{
            // //open menu
            [self openMenuView];
        }
    }
    
}


-(void)openMenuView{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat x           = 0;
        CGFloat y           = self.menuViewframe.origin.y;
        CGFloat w           = self.menuViewframe.size.width;
        CGFloat h           = self.menuViewframe.size.height;
        self.leftMenuView.frame = CGRectMake(x, y, w, h);
        
        self.coverView.frame    = self.coverViewframe;
        self.coverView.alpha    = CoverViewAlpha;
    }];
}

-(void)closeMenuView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGFloat x           = -self.menuViewframe.size.width;
        CGFloat y           = self.menuViewframe.origin.y;
        CGFloat w           = self.menuViewframe.size.width;
        CGFloat h           = self.menuViewframe.size.height;
        self.leftMenuView.frame = CGRectMake(x, y, w, h);//self.LeftViewFrame;
        self.coverView.frame    = CGRectMake(0, 0,kSCREEN_WIDTH, self.menuViewframe.size.height);
        
    } completion:^(BOOL finished) {
        [self removeCoverAndMenuView];
    }];
}



#pragma mark - cover view
-(void)coverTap{

    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        self.leftMenuView.frame = CGRectMake(-self.menuViewframe.size.width, 0, self.menuViewframe.size.width, self.menuViewframe.size.height);
        self.coverView.frame    = CGRectMake(0, 0,kSCREEN_WIDTH, kSCREEN_HEIGHT);
        self.coverView.alpha    = 0.0;
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.leftMenuView removeFromSuperview];
    }];
    
}





#pragma mark - remove cover view
-(void)removeCoverAndMenuView{
    
    self.leftMenuView.frame = CGRectMake(-self.leftMenuView.frame.size.width, 0, self.leftMenuView.frame.size.width, kSCREEN_HEIGHT);
    self.coverView.frame    = CGRectMake(0, 0,kSCREEN_WIDTH, kSCREEN_HEIGHT);
    self.coverView.alpha    = 0.0;
    
    [self.coverView removeFromSuperview];
    [self.leftMenuView removeFromSuperview];
}







@end
