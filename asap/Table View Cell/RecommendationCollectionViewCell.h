//
//  RecommendationCollectionViewCell.h
//  asap
//
//  Created by Gopal Gundaram on 31/07/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendationCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *recommendRestarentImage;
@property (weak, nonatomic) IBOutlet UILabel *outLetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *minOrderPrice;
@property (weak, nonatomic) IBOutlet UILabel *restarentName;
@property (weak, nonatomic) IBOutlet UIButton *forOutLetsButton;
@end
