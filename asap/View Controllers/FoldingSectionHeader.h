//
//  FoldingSectionHeader.h
//  FoldingTableView
//
//  Created by administrator on 14/12/17.
//  Copyright © 2017 Gop. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FoldingSectionState) {
    
    FoldingSectionStateFlod,
    FoldingSectionStateShow,
};


typedef NS_ENUM(NSUInteger, FoldingSectionHeaderArrowPosition) {
    
    FoldingSectionHeaderArrowPositionLeft,
    FoldingSectionHeaderArrowPositionRight,
};

@protocol FoldingSectionHeaderDelegate <NSObject>

- (void)FoldingSectionHeaderTappedAtIndex:(NSInteger)index;

@end


@interface FoldingSectionHeader : UITableViewHeaderFooterView

@property (nonatomic, weak) id <FoldingSectionHeaderDelegate> tapDelegate;

@property (nonatomic, assign) BOOL autoHiddenSeperatorLine;

@property (nonatomic, strong) UIColor *separatorLineColor;

- (void)configWithBackgroundColor:(UIColor *)backgroundColor
                      titleString:(NSString *)titleString
                       titleColor:(UIColor *)titleColor
                        titleFont:(UIFont *)titleFont
                descriptionString:(NSString *)descriptionString
                 descriptionColor:(UIColor *)descriptionColor
                  descriptionFont:(UIFont *)descriptionFont
                       arrowImage:(UIImage *)arrowImage
                    arrowPosition:(FoldingSectionHeaderArrowPosition)arrowPosition
                     sectionState:(FoldingSectionState)sectionState
                     sectionIndex:(NSInteger)sectionIndex;



@end
