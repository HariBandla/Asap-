
//
//  MyCartCell1.m
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "MyCartCell1.h"

@implementation MyCartCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)plusAction:(UIButton *)sender {
    if ([self.numberOfItemsLabel.text intValue] >=1) {
        long int priceOfItem = 300*([self.numberOfItemsLabel.text intValue]+ 1);
        self.totalAmoutOfItem.text = [NSString stringWithFormat:@"%ld",priceOfItem];
        self.numberOfItemsLabel.text = [NSString stringWithFormat:@"%d",([self.numberOfItemsLabel.text intValue]+ 1)];
        //([self.numberOfItemsLabel.text intValue]+ 1);
    }
    
}

- (IBAction)subAction:(UIButton *)sender {
    if ([self.numberOfItemsLabel.text intValue] >1) {
        long int priceOfItem = 300*([self.numberOfItemsLabel.text intValue]- 1);
        self.totalAmoutOfItem.text = [NSString stringWithFormat:@"%ld",priceOfItem];
         self.numberOfItemsLabel.text = [NSString stringWithFormat:@"%d",([self.numberOfItemsLabel.text intValue]- 1)];
    }
}
@end
