//
//  MyCartViewController.m
//  asap
//
//  Created by Hari on 21/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "MyCartViewController.h"
#import "CheckOutViewController.h"
#import "MyCartCell1.h"
#import "MyCartCell2.h"
#import "ForCoreDataMethods.h"
@interface MyCartViewController ()

@end

@implementation MyCartViewController
{
    NSMutableArray * finalArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataInCoreDataArray = [[NSMutableArray alloc]init];
    [self getDataFromCoreData];
    [self dividedInToArray];
    // Do any additional setup after loading the view.
}
-(void)getDataFromCoreData
{
    self.dataInCoreDataArray = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
}
-(void)dividedInToArray
{
    //NSLog(@"data in core data is %@",self.dataInCoreDataArray);
    finalArray =[[NSMutableArray alloc]init];
    NSInteger numberOfItemsInCoreData = self.dataInCoreDataArray.count;
    
    for (int j = 0; j < numberOfItemsInCoreData ; j++) {
        if (self.dataInCoreDataArray.count != 0) {
             for (int k = 0; k < self.dataInCoreDataArray.count ; k = 0) {
                 NSMutableArray* sameResturentItems = [[NSMutableArray alloc]init];
                    NSDictionary*firstItem = self.dataInCoreDataArray[k];
                 [self.dataInCoreDataArray removeObjectAtIndex:k];
                 [sameResturentItems addObject:firstItem];
            for (int i = 0 ; i < self.dataInCoreDataArray.count; i++) {
                NSDictionary* secondItems = self.dataInCoreDataArray[i];
                        if ([firstItem[@"branch_id"] isEqualToString:secondItems[@"branch_id"]])
                        {
                            [sameResturentItems addObject:secondItems];
                             [self.dataInCoreDataArray removeObjectAtIndex:i];
                            i = i - 1;
                        }
                        NSLog(@"-------------->,%i<-------",i);
                       }
            
                        [finalArray addObject:sameResturentItems];
                  NSLog(@"-------------->,%@<-------",finalArray);
            }
        }
        }
    }
//        NSMutableArray* sameResturentItems = [[NSMutableArray alloc]init];
//        NSDictionary*firstItem = self.dataInCoreDataArray[j];
//        [self.dataInCoreDataArray removeObjectAtIndex:j];
//        [sameResturentItems addObject:firstItem];
//    for (int i = 1; i < self.dataInCoreDataArray.count; i++)
//    {
//        NSDictionary* secondItems = self.dataInCoreDataArray[i];
//        if ([firstItem[@"branch_id"] isEqualToString:secondItems[@"branch_id"]])
//        {
//            [sameResturentItems addObject:secondItems];
//             [self.dataInCoreDataArray removeObjectAtIndex:i];
//        }
//        NSLog(@"-------------->,%i<-------",i);
//       }
//
//        [finalArray addObject:sameResturentItems];
//       // j = 0;
//    }
//    NSLog(@"data in final array %@",finalArray);
//    NSLog(@"data in core data is %@",self.dataInCoreDataArray);

/* for (char i=0; i<100; i++) {
 
 UISwitch* s1 = [[UISwitch alloc]initWithFrame:CGRectMake(x, y, 100, 100)];
 [self.forRedSwitch addObject:s1];
 s1.tintColor=[UIColor redColor];
 s1.thumbTintColor=[UIColor redColor];
 x=x+50;count++;
 if (count == 8) {
 x = 10;
 y=y+ 30;
 count=0;
 }
 }*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return finalArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [[finalArray objectAtIndex:section]count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString * firstCellIdentifier = @"cartCell";
//    NSString * secondCellIdentifier = @"cartCell1";

    if (indexPath.row == 1) {
        MyCartCell2*cell=[tableView dequeueReusableCellWithIdentifier:@"cartCell1" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        MyCartCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"cartCell" forIndexPath:indexPath];
        cell.plusCartButton.indexPath = indexPath;
        cell.subCartButton.indexPath = indexPath;
        
        cell.addOrSubView.layer.borderWidth = 1;
        cell.addOrSubView.layer.borderColor = (UIColor.blackColor).CGColor;
        cell.addOrSubView.layer.cornerRadius = 8;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
    UIImageView*image = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, 30, 30)];
    image.image = [UIImage imageNamed:@"Image1"];
    [view addSubview:image];
     UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(38, 4, tableView.frame.size.width - 22, 15)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(38, 22, tableView.frame.size.width - 22, 12)];
    label1.text = @"Sorry i can not get it";
    label2.text = @"Sorry i can not get it";
    label1.textColor = UIColor.redColor;
    [label1 setFont:[UIFont boldSystemFontOfSize:12]];
     [label2 setFont:[UIFont boldSystemFontOfSize:8]];
    [view addSubview:label1];
    [view addSubview:label2];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}
-(NSDictionary*)isItemInCart:(NSDictionary*)cartData
{
    NSDictionary * a1;
    return a1;
    
}
- (IBAction)plusAction:(CartBtn *)sender {
}

- (IBAction)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)subAction:(CartBtn *)sender
{
    
}
- (IBAction)applyCoupenAction:(UIButton *)sender
{
    
}
- (IBAction)checkOutBtn:(UIButton *)sender
{
    UIStoryboard*storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CheckOutViewController*checkOutVc = [storyBoard instantiateViewControllerWithIdentifier:@"CheckOutViewController"];
    [self.navigationController pushViewController:checkOutVc animated:YES];
}
@end
