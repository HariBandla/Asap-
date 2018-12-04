//
//  ExampleTableViewController.m
//  asap
//
//  Created by Hari on 22/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "ExampleTableViewController.h"

@interface ExampleTableViewController ()
@property float height;
@end

@implementation ExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.height)];
    view.backgroundColor = UIColor.lightGrayColor;
    int numberOfRow = 0;
    for (int i = 0; i<=indexPath.row * 2; i++) {
        for (int j = 0; j<=indexPath.row * 2;j++) {
            UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(j * self.view.frame.size.width/3, i * 50, self.view.frame.size.width/3, 50)];
            label.text = @"U had got 90000000000/-";
            [label setFont:[UIFont fontWithName:@"Helvetica" size:8]];
            //[NSString stringWithFormat:@"%i%li",numberOfRow,indexPath.row];
            //@"Sorry i can not stay with u because i have office today";
            [view addSubview:label];
        }
        
    }
    
    [cell addSubview:view];
    if (indexPath.row == 0) {
        cell.backgroundColor = UIColor.redColor;
    }
    else if (indexPath.row == 1) {
        cell.backgroundColor = UIColor.magentaColor;
    }
    else if (indexPath.row == 2) {
        cell.backgroundColor = UIColor.yellowColor;
    }
    else if (indexPath.row == 3) {
        cell.backgroundColor = UIColor.blueColor;
    }
    else if (indexPath.row == 4) {
        cell.backgroundColor = UIColor.brownColor;
    }
    else if (indexPath.row == 5) {
        cell.backgroundColor = UIColor.greenColor;
    }
    else
    {
        cell.backgroundColor = UIColor.whiteColor;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.height = indexPath.row * 100;
    if (indexPath.row == 0) {
        return 100;
    }
    else
    return self.height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
