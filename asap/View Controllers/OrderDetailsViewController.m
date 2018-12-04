//
//  OrderDetailsViewController.m
//  asap
//
//  Created by Hari on 20/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "OrderDetailTableViewCell.h"
#import "HMSegmentedControl.h"
@interface OrderDetailsViewController ()
@property NSArray*segmentArray;
@property HMSegmentedControl*segmentedControl;
@property NSArray*numberInArray;
@property NSMutableArray * forLabelArray;
@property  long int valueFromArray;
@end

@implementation OrderDetailsViewController
#pragma mark Methods For View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberInArray = @[@"1",@"4",@"9",@"2",@"6",@"9",@"3",@"4",@"5",@"7"];
    self.segmentArray = @[@"1xPaneerPulao",@"2x Chettinadu",@"3x Chicken Curry",@"4xchelli Chicken",@"5xChicken65",@"6xChicken77",@"7xPaneerPulao",@"8xPaneerPulao",@"9xPaneerPulao",@"10xPaneerPulao",@"1xPaneerPulao",@"1xPaneerPulao",@"1xPaneerPulao",@"1xPaneerPulao",@"1xPaneerPulao"];
   
  //  [self.segmentView addSubview:self.segmentedControl];
    
   // [self.segmentedControl addTarget:self action:@selector(selectrdSegment) forControlEvents:UIControlEventValueChanged];
    self.orderDetailsTableView.delegate = self;
    self.orderDetailsTableView.dataSource = self;
}
-(void)selectrdSegment
{
    NSLog(@"sorry you had got nutting     ehrjhsmbdfkn,ewadms,.");
}
#pragma mark Methods For Table View Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberInArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self forDelectingLabel];
   // OrderDetailTableViewCell*cell = [self.orderDetailsTableView dequeueReusableCellWithIdentifier:@"orderDetailsCell"];
    NSString*name=@"";
    for (int i = 0; i<[self.numberInArray[indexPath.row] intValue]; i++) {
        if (i == 0) {
            name = self.segmentArray[i];
        }
        else
        {
        name =[name stringByAppendingString:@" , "];
        name =[name stringByAppendingString:self.segmentArray[i]];
        }
    }
    static NSString *cellID = @"orderDetailsCell";
    //UILabel *priceLabel = nil;
    //CartBtn *btn = nil;
    OrderDetailTableViewCell *cell = [self.orderDetailsTableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[OrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
//    OrderDetailTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
//    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
//        cell = [[OrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//
//        //        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 10, 100, 30)];
//        //        [cell.contentView addSubview:priceLabel];
//        //        priceLabel.font = Font;
//        //        priceLabel.tag = 111;
//    }
//    else
//    {
//        //priceLabel = [cell.contentView viewWithTag:111];
//        //btn = [cell.contentView viewWithTag:222];
//
//    }
    cell.clipsToBounds = NO;
    cell.orderSegmentView.layer.borderWidth = 1;
    cell.orderSegmentView.layer.borderColor = (UIColor.blackColor).CGColor;
    cell.orderTextView.text = name;
    
    
    cell.layer.borderColor=(UIColor.blueColor).CGColor;
        return cell;
}
-(void)forDelectingLabel
{
    for (NSUInteger index=0; index< 100; index++) {
        [[self.forLabelArray objectAtIndex:index] removeFromSuperview];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     self.valueFromArray = [self.numberInArray[indexPath.row] intValue];
   long int widht = self.valueFromArray / 3;
    long int reminder = self.valueFromArray % 3 ;
    if (reminder == 0) {
        return (154 + widht * 20);
    }
    else
    {
        return (154 + (widht + 1) * 20);
    }
}
@end
/*
 self.forLabelArray=[[NSMutableArray alloc]init];
 unsigned int b11=10, b12=10, b13=0;
 for (char i=0; i<100; i++) {
 UILabel* l1 = [[UILabel alloc]initWithFrame:CGRectMake(b11, b12, 100, 50)];
 [self.forLabelArray addObject:l1];
 l1.textColor=[UIColor greenColor];
 l1.text=[NSString stringWithFormat:@"%d",i+1];
 b11=b11+100;b13++;
 if (b13 == 3) {
 b11= 10;
 b12=b12+ 50;
 b13=0;
 }
 }
 //===============================================================================================
 float i=[self.numberInArray[indexPath.row] floatValue];
 NSLog(@"%f",i);
 int k=2;
 int j=5;
 int index=0;
 int count=0;
 for (int x=0; x<i; x++)
 {
 UILabel*label = [self.forLabelArray objectAtIndex:index];
 label.textColor = UIColor.blueColor;
 label.backgroundColor = UIColor.redColor;
 // [cell.orderSegmentView addSubview:label];
 switch (x) {
 case 0:
 label.text = self.segmentArray[0];
 break;
 case 1:
 label.text = self.segmentArray[1];
 break;
 case 2:
 label.text = self.segmentArray[2];
 break;
 case 3:
 label.text = self.segmentArray[3];
 break;
 case 4:
 label.text = self.segmentArray[4];
 break;
 case 5:
 label.text = self.segmentArray[5];
 break;
 case 6:
 label.text = self.segmentArray[6];
 break;
 case 7:
 label.text = self.segmentArray[7];
 break;
 case 8:
 label.text = self.segmentArray[8];
 break;
 case 9:
 label.text = self.segmentArray[9];
 break;
 default:
 break;
 }
 label.backgroundColor = [UIColor redColor];
 //[self.view addSubview:label];
 k+=self.view.frame.size.width / 3 + 1;
 count++;
 index++;
 if(count==3)
 {
 j+=50;
 k=2;
 count=0;
 }
 }
 -(void)change
 {
 float i=self.valueFromArray;
 NSLog(@"%f",i);
 int k=0;
 int j=0;
 int index=0;
 int count=0;
 for (int x=0; x<i; x++)
 {
 UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(k, j, self.view.frame.size.width / 4 - 4 , 50)];
 //label.text = @"Hari";
 switch (x) {
 case 0:
 label.text = self.segmentArray[0];
 break;
 case 1:
 label.text = self.segmentArray[1];
 break;
 case 2:
 label.text = self.segmentArray[2];
 break;
 case 3:
 label.text = self.segmentArray[3];
 break;
 case 4:
 label.text = self.segmentArray[4];
 break;
 case 5:
 label.text = self.segmentArray[5];
 break;
 case 6:
 label.text = self.segmentArray[6];
 break;
 case 7:
 label.text = self.segmentArray[7];
 break;
 case 8:
 label.text = self.segmentArray[8];
 break;
 case 9:
 label.text = self.segmentArray[9];
 break;
 default:
 break;
 }
 label.backgroundColor = [UIColor redColor];
 k+=self.view.frame.size.width / 3 + 1;
 count++;
 index++;
 if(count==3)
 {
 j+=35;
 k=0;
 count=0;
 }
 }
 
 }
 */
