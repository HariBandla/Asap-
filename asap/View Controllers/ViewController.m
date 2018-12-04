

#import "ViewController.h"
#import "LeftMenuView.h"
#import "MenuView.h"
#define Font [UIFont fontWithName:@"HelveticaNeue-Light" size:10]
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self change];
}
-(void)change
{
    float i=10;
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
                label.text = @"Srihari";
                break;
            case 1:
                label.text = @"Ravi";
                break;
            case 2:
                label.text = @"Raju";
                break;
            case 3:
                label.text = @"Raja";
                break;
            case 4:
                label.text = @"Rani";
                break;
            case 5:
                label.text = @"Amma";
                break;
            case 6:
                label.text = @"Hari";
                break;
            case 7:
                label.text = @"Anil";
                break;
            case 8:
                label.text = @"Gopi";
                break;
            case 9:
                label.text = @"Krish";
                break;
            default:
                break;
        }
        label.backgroundColor = [UIColor redColor];
        [self.view addSubview:label];
        k+=self.view.frame.size.width / 4 + 1;
        count++;
        index++;
        if(count==4)
        {
            j+=35;
            k=0;
            count=0;
        }
    }
    
}
@end
