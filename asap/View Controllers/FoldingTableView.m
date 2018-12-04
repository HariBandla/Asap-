//
//  FoldingTableView.m
//  FoldingTableView
//
//  Created by administrator on 14/12/17.
//  Copyright © 2017 Gop. All rights reserved.
//

#import "FoldingTableView.h"

static NSString *FoldingSectionHeaderID = @"FoldingSectionHeader";

@implementation CartBtn
@end

@interface FoldingTableView () <FoldingSectionHeaderDelegate>

@property (nonatomic, strong) NSMutableArray *statusArray;

@end

@implementation FoldingTableView

#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

#pragma mark -

- (void)setupDelegateAndDataSource
{
    // iOS 11
#ifdef __IPHONE_11_0
    if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
#endif
    self.delegate = self;
    self.dataSource = self;
    if (self.style == UITableViewStylePlain) {
        self.tableFooterView = [[UIView alloc] init];
    }
    
    [self registerClass:[FoldingSectionHeader class] forHeaderFooterViewReuseIdentifier:FoldingSectionHeaderID];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangeStatusBarOrientationNotification:)  name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    
    if (!_foldingState) {
        _foldingState = FoldingSectionStateFlod;
    }
    
    if (_statusArray.count) {
        if (_statusArray.count > self.numberOfSections) {
            [_statusArray removeObjectsInRange:NSMakeRange(self.numberOfSections - 1, _statusArray.count - self.numberOfSections)];
        }else if (_statusArray.count < self.numberOfSections) {
            for (NSInteger i = self.numberOfSections - _statusArray.count; i < self.numberOfSections; i++) {
                [_statusArray addObject:[NSNumber numberWithInteger:_foldingState]];
            }
        }
    }else{
        for (NSInteger i = 0; i < self.numberOfSections; i++) {
            [_statusArray addObject:[NSNumber numberWithInteger:_foldingState]];
        }
    }
    return _statusArray;
}

- (void)onChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

#pragma mark - UI Configration

- (FoldingSectionHeaderArrowPosition )perferedArrowPosition
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(perferedArrowPositionForFoldingTableView:)]) {
        return [_foldingDelegate perferedArrowPositionForFoldingTableView:self];
    }
    return FoldingSectionHeaderArrowPositionRight;
}
- (UIColor *)backgroundColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:backgroundColorForHeaderInSection:)]) {
        return [_foldingDelegate FoldingTableView:self backgroundColorForHeaderInSection:section];
    }
    return  [UIColor whiteColor];// [UIColor colorWithRed:102/255.f green:102/255.f blue:255/255.f alpha:1.f];
}
- (NSString *)titleForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:titleForHeaderInSection:)]) {
        return [_foldingDelegate FoldingTableView:self titleForHeaderInSection:section];
    }
    return [NSString string];
}
- (UIFont *)titleFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:fontForTitleInSection:)]) {
        return [_foldingDelegate FoldingTableView:self fontForTitleInSection:section];
    }
    return [UIFont boldSystemFontOfSize:16];
}
- (UIColor *)titleColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:textColorForTitleInSection:)]) {
        return [_foldingDelegate FoldingTableView:self textColorForTitleInSection:section];
    }
    return [UIColor grayColor];
}
- (NSString *)descriptionForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:descriptionForHeaderInSection:)]) {
        return [_foldingDelegate FoldingTableView:self descriptionForHeaderInSection:section];
    }
    return [NSString string];
}
- (UIFont *)descriptionFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:fontForDescriptionInSection:)]) {
        return [_foldingDelegate FoldingTableView:self fontForDescriptionInSection:section];
    }
    return [UIFont boldSystemFontOfSize:13];
}

- (UIColor *)descriptionColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:textColorForDescriptionInSection:)]) {
        return [_foldingDelegate FoldingTableView:self textColorForDescriptionInSection:section];
    }
    return [UIColor whiteColor];
}

- (UIImage *)arrowImageForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:arrowImageForSection:)]) {
        return [_foldingDelegate FoldingTableView:self arrowImageForSection:section];
    }
    
    return [UIImage imageNamed:@"arrow"];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(numberOfSectionForFoldingTableView:)]) {
        return [_foldingDelegate numberOfSectionForFoldingTableView:self];
    }else{
        return self.numberOfSections;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (((NSNumber *)self.statusArray[section]).integerValue == FoldingSectionStateShow) {
        if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:numberOfRowsInSection:)]) {
            return [_foldingDelegate FoldingTableView:self numberOfRowsInSection:section];
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:heightForHeaderInSection:)]) {
        return [_foldingDelegate FoldingTableView:self heightForHeaderInSection:section];
    }else{
        return self.sectionHeaderHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:heightForRowAtIndexPath:)]) {
        return [_foldingDelegate FoldingTableView:self heightForRowAtIndexPath:indexPath];
    }else{
        return self.rowHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.style == UITableViewStylePlain) {
        return 0;
    }else{
        return 0.001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FoldingSectionHeader *sectionHeaderView = [self dequeueReusableHeaderFooterViewWithIdentifier:FoldingSectionHeaderID];
    [sectionHeaderView configWithBackgroundColor:[self backgroundColorForSection:section]
                                     titleString:[self titleForSection:section]
                                      titleColor:[self titleColorForSection:section]
                                       titleFont:[self titleFontForSection:section]
                               descriptionString:[self descriptionForSection:section]
                                descriptionColor:[self descriptionColorForSection:section]
                                 descriptionFont:[self descriptionFontForSection:section]
                                      arrowImage:[self arrowImageForSection:section]
                                   arrowPosition:[self perferedArrowPosition]
                                    sectionState:((NSNumber *)self.statusArray[section]).integerValue
                                    sectionIndex:section];
    sectionHeaderView.tapDelegate = self;
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:cellForRowAtIndexPath:)]) {
        return [_foldingDelegate FoldingTableView:self cellForRowAtIndexPath:indexPath];
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellIndentifier"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(FoldingTableView:didSelectRowAtIndexPath:)]) {
        [_foldingDelegate FoldingTableView:self didSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark - FoldingSectionHeaderDelegate

- (void)FoldingSectionHeaderTappedAtIndex:(NSInteger)index
{
    BOOL currentIsOpen = ((NSNumber *)self.statusArray[index]).boolValue;
    
    [self.statusArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:!currentIsOpen]];
    
    NSInteger numberOfRow = [_foldingDelegate FoldingTableView:self numberOfRowsInSection:index];
    NSMutableArray *rowArray = [NSMutableArray array];
    if (numberOfRow) {
        for (NSInteger i = 0; i < numberOfRow; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:index]];
        }
    }
    if (rowArray.count) {
        if (currentIsOpen) {
            [self deleteRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }else{
            [self insertRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}



@end
