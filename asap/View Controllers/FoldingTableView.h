//
//  FoldingTableView.h
//  FoldingTableView
//
//  Created by administrator on 14/12/17.
//  Copyright © 2017 Gop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldingSectionHeader.h"

@class FoldingTableView;

@protocol FoldingTableViewDelegate <NSObject>

@required

- (FoldingSectionHeaderArrowPosition)perferedArrowPositionForFoldingTableView:(FoldingTableView *)TableView;
- (NSInteger )numberOfSectionForFoldingTableView:(FoldingTableView *)TableView;
- (NSInteger )FoldingTableView:(FoldingTableView *)TableView numberOfRowsInSection:(NSInteger )section;
- (CGFloat )FoldingTableView:(FoldingTableView *)TableView heightForHeaderInSection:(NSInteger )section;
- (CGFloat )FoldingTableView:(FoldingTableView *)TableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)FoldingTableView:(FoldingTableView *)TableView titleForHeaderInSection:(NSInteger )section;
- (UITableViewCell *)FoldingTableView:(FoldingTableView *)TableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void )FoldingTableView:(FoldingTableView *)TableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (UIImage *)FoldingTableView:(FoldingTableView *)TableView arrowImageForSection:(NSInteger )section;

- (NSString *)FoldingTableView:(FoldingTableView *)TableView descriptionForHeaderInSection:(NSInteger )section;

- (UIColor *)FoldingTableView:(FoldingTableView *)TableView backgroundColorForHeaderInSection:(NSInteger )section;

- (UIFont *)FoldingTableView:(FoldingTableView *)TableView fontForTitleInSection:(NSInteger )section;

- (UIFont *)FoldingTableView:(FoldingTableView *)TableView fontForDescriptionInSection:(NSInteger )section;

- (UIColor *)FoldingTableView:(FoldingTableView *)TableView textColorForTitleInSection:(NSInteger )section;

- (UIColor *)FoldingTableView:(FoldingTableView *)TableView textColorForDescriptionInSection:(NSInteger )section;

@end

@interface FoldingTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<FoldingTableViewDelegate> foldingDelegate;

@property (nonatomic, assign) FoldingSectionState foldingState;

@end

@interface CartBtn : UIButton
@property(nonatomic, strong)NSIndexPath *indexPath;
@end
