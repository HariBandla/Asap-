//
//  FoldingSectionHeader.m
//  FoldingTableView
//
//  Created by administrator on 14/12/17.
//  Copyright © 2017 Gop. All rights reserved.
//

#import "FoldingSectionHeader.h"

static CGFloat const FoldingSeperatorLineWidth = 0.3f;
static CGFloat const FoldingMargin             = 8.0f;
static CGFloat const FoldingIconWidth           = 24.0f;

@interface FoldingSectionHeader ()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *descriptionLabel;
@property (nonatomic, strong) UIImageView  *arrowImageView;
@property (nonatomic, strong) CAShapeLayer  *separatorLine;
@property (nonatomic, assign) FoldingSectionHeaderArrowPosition  arrowPosition;
@property (nonatomic, assign) FoldingSectionState  sectionState;
@property (nonatomic, strong) UITapGestureRecognizer  *tapGesture;

@property (nonatomic, assign) NSInteger sectionIndex;

@property (nonatomic, strong) UIView  *separatorView;
@end

@implementation FoldingSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];

    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupSubviews];
}


- (void)setupSubviews
{
    _autoHiddenSeperatorLine = NO;
    _separatorLineColor = [UIColor darkGrayColor];
    _arrowPosition = FoldingSectionHeaderArrowPositionRight;
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addGestureRecognizer:self.tapGesture];
    [self.contentView.layer addSublayer:self.separatorLine];
}

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
                    sectionIndex:(NSInteger)sectionIndex
{
    _sectionIndex = sectionIndex;
    [self.contentView setBackgroundColor:backgroundColor];
    
    self.titleLabel.text = titleString;
    self.titleLabel.textColor = titleColor;
    self.titleLabel.font = titleFont;
    
    self.descriptionLabel.text = descriptionString;
    self.descriptionLabel.textColor = descriptionColor;
    self.descriptionLabel.font = descriptionFont;
    
    self.arrowImageView.image = arrowImage;
    self.arrowPosition = arrowPosition;
    self.sectionState = sectionState;
    
    if (sectionState == FoldingSectionStateShow) {
        if (self.arrowPosition == FoldingSectionHeaderArrowPositionRight) {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }else{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
    } else {
        if (self.arrowPosition == FoldingSectionHeaderArrowPositionRight) {
            _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }else{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat labelWidth = (self.frame.size.width - FoldingMargin * 2 - FoldingIconWidth)/2;
    CGFloat labelHeight = self.frame.size.height;
    CGRect arrowRect = CGRectMake(FoldingMargin + FoldingIconWidth + labelWidth, (self.frame.size.height - FoldingIconWidth)/2, FoldingIconWidth, FoldingIconWidth);
    CGRect titleRect = CGRectMake(FoldingMargin + FoldingIconWidth, 0, labelWidth, labelHeight);
    CGRect descriptionRect = CGRectMake(FoldingMargin + FoldingIconWidth + labelWidth,  0, labelWidth, labelHeight);
    if (_arrowPosition == FoldingSectionHeaderArrowPositionRight) {
        arrowRect.origin.x = FoldingMargin * 2 + labelWidth * 2;
        titleRect.origin.x = FoldingMargin;
        descriptionRect.origin.x = FoldingMargin + labelWidth;
    }
    arrowRect.origin.x = self.bounds.size.width - 50;
    titleRect.origin.x = 20;
    [self.titleLabel setFrame:titleRect];
    //[self.descriptionLabel setFrame:descriptionRect];
    [self.arrowImageView setFrame:arrowRect];
    [self.separatorLine setPath:[self getSepertorPath].CGPath];
}

- (void)shouldExpand:(BOOL)shouldExpand
{
    
    [UIView animateWithDuration:0.2  animations:^{
        if (shouldExpand) {
            if (self.arrowPosition == FoldingSectionHeaderArrowPositionRight) {
                self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
            }else{
                self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
            }
        } else {
            if (self.arrowPosition == FoldingSectionHeaderArrowPositionRight) {
                _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
            }else{
                self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
            }
        }
    } completion:^(BOOL finished) {
        if (_autoHiddenSeperatorLine) {
            if (finished == YES) {
                self.separatorLine.hidden = shouldExpand;
            }
        }
    }];
}


- (void)onTapped:(UITapGestureRecognizer *)gesture
{
    [self shouldExpand:![NSNumber numberWithInteger:self.sectionState].boolValue];
    if (_tapDelegate && [_tapDelegate respondsToSelector:@selector(FoldingSectionHeaderTappedAtIndex:)]) {
        self.sectionState = [NSNumber numberWithBool:(![NSNumber numberWithInteger:self.sectionState].boolValue)].integerValue;
        [_tapDelegate FoldingSectionHeaderTappedAtIndex:_sectionIndex];
    }
}

-(UIView *)separatorView
{
//    if(!_separatorView)
    return nil;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.textAlignment = NSTextAlignmentRight;
    }
    return _descriptionLabel;
}
- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _arrowImageView.backgroundColor = [UIColor clearColor];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}
- (CAShapeLayer *)separatorLine
{
    if (!_separatorLine) {
        _separatorLine = [CAShapeLayer layer];
        _separatorLine.strokeColor = _separatorLineColor.CGColor;
        _separatorLine.lineWidth = FoldingSeperatorLineWidth;
    }
    return _separatorLine;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapped:)];
    }
    return _tapGesture;
}

- (UIBezierPath *)getSepertorPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.frame.size.height - FoldingSeperatorLineWidth)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - FoldingSeperatorLineWidth)];
    return path;
}

@end
