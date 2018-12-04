//
//  DetailOfResturentCollectionViewCell.m
//  asap
//
//  Created by Hari on 23/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "DetailOfResturentCollectionViewCell.h"

@implementation DetailOfResturentCollectionViewCell

- (IBAction)plusAction:(UIButton *)sender {
   
    //float basicPrice = 300;
       long int i = [self.numberOfItemsLabel.text intValue];
        self.numberOfItemsLabel.text = [NSString stringWithFormat:@"%ld",i + 1];
        long int price = [self.priceLabel.text intValue] + 300;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld",price];
   
}

- (IBAction)subAction:(UIButton *)sender {
    if ([self.numberOfItemsLabel.text isEqualToString:@"1"]) {
        //float basicPrice = 300;
        self.forAddingCount.hidden = YES;
        self.addButton.hidden = NO;
       // float price = [self.priceLabel.text floatValue] + basicPrice;
        self.priceLabel.text = [NSString stringWithFormat:@"300"];
    }
    else
    {
        //float basicPrice = 300;
        int i = [self.numberOfItemsLabel.text intValue];
        self.numberOfItemsLabel.text = [NSString stringWithFormat:@"%i",i - 1];
       long int price = [self.priceLabel.text intValue] - 300;
        self.priceLabel.text = [NSString stringWithFormat:@"%ld",price];
    }
}
- (IBAction)addAction:(UIButton *)sender {
    self.addButton.hidden = YES;
    self.forAddingCount.hidden = NO;
    self.numberOfItemsLabel.text = @"1";
}
@end
