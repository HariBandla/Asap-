//
//  ForCoreDataMethods.m
//  asap
//
//  Created by Gopal Gundaram on 21/11/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "ForCoreDataMethods.h"
#import "AppDelegate.h"

@implementation ForCoreDataMethods
{
    AppDelegate *appDelegate;
    NSManagedObjectContext*context;
}
static ForCoreDataMethods *_sharedMySingleton = nil;
+(ForCoreDataMethods *)networkManager {
    @synchronized([ForCoreDataMethods class]) {
        if (!_sharedMySingleton)
            _sharedMySingleton = [[self alloc] init];
        return _sharedMySingleton;
    }
    return nil;
}

-(void)storeDataInCoreData: (NSString*)product_id product_weight:(NSString*)product_weight product_price:(NSString*)product_price product_quantity:(NSString*)product_quantity vendor_id:(NSString*)vendor_id branch_id:(NSString*)branch_id imageOfResturentURL:(NSString*)imageOfResturentURL addressOfResturent:(NSString*)addressOfResturent nameOfResturent:(NSString*)nameOfResturent
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSManagedObject*object = [NSEntityDescription insertNewObjectForEntityForName:@"Order_List" inManagedObjectContext:context];
    [object setValue:product_id forKey:@"product_id"];
    [object setValue:product_weight forKey:@"product_weight"];
    [object setValue:product_price forKey:@"product_price"];
    [object setValue:vendor_id forKey:@"vendor_id"];
    [object setValue:product_quantity forKey:@"product_quantity"];
    [object setValue:branch_id forKey:@"branch_id"];
    [object setValue:imageOfResturentURL forKey:@"imageOfResturentURL"];
     [appDelegate saveContext];
    
}
-(NSArray*)getDateFromCoreDate
{
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    context=appDelegate.persistentContainer.viewContext;
    NSFetchRequest*fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Order_List"];
    /*NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", ..., nil]; // These are the keys for the properties of your managed object that you want in the JSON
     NSString *json = [[managedObject dictionaryWithValuesForKeys:keys] JSONRepresentation];*/
    [fetchRequest setReturnsObjectsAsFaults:NO];
    fetchRequest.returnsObjectsAsFaults = NO;
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"branch_id = branch_id"];
//    [fetchRequest setPredicate: predicate];
    NSArray *itemsdata=[[NSArray alloc]init];
    NSMutableArray * returningArray = [[NSMutableArray alloc]init];
    itemsdata = [context executeFetchRequest:fetchRequest error:nil];
    for (int i =0; i < itemsdata.count; i++) {
        NSDictionary*dataDictionary=@{@"product_id":[[itemsdata objectAtIndex:i] valueForKey:@"product_id"],@"product_weight":[[itemsdata objectAtIndex:i] valueForKey:@"product_weight"],@"product_price":[[itemsdata objectAtIndex:i] valueForKey:@"product_price"],@"vendor_id":[[itemsdata objectAtIndex:i] valueForKey:@"vendor_id"],@"product_quantity":[[itemsdata objectAtIndex:i] valueForKey:@"product_quantity"],@"branch_id":[[itemsdata objectAtIndex:i] valueForKey:@"branch_id"],@"imageOfResturentURL":@""};
        
        
        [returningArray addObject:dataDictionary];
    }
    //NSLog(@"product_id %@",[itemsdata[0] valueForKey:@"product_id"]);
    return returningArray;
   // NSLog(@"%@",[[itemsdata objectAtIndex:1] valueForKey:@"name"]);
}
-(void)upDataInCoreData: (NSUInteger)postion product_id:(NSString*)product_id product_weight:(NSString*)product_weight product_price:(NSString*)product_price product_quantity:(NSString*)product_quantity vendor_id:(NSString*)vendor_id branch_id:(NSString*)branch_id imageOfResturentURL:(NSString*)imageOfResturentURL addressOfResturent:(NSString*)addressOfResturent nameOfResturent:(NSString*)nameOfResturent
{
    NSFetchRequest*fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Order_List"];
    NSArray*Array=[context executeFetchRequest:fetchRequest error:nil];
    NSManagedObject* object = [Array objectAtIndex:postion];
    //NSString*pkg = [[Array valueForKey:@"packing_charges"]objectAtIndex:sender.tag];
    [object setValue:product_id forKey:@"product_id"];
    [object setValue:product_weight forKey:@"product_weight"];
    [object setValue:product_price forKey:@"product_price"];
    [object setValue:vendor_id forKey:@"vendor_id"];
    [object setValue:product_quantity forKey:@"product_quantity"];
    [object setValue:branch_id forKey:@"branch_id"];
    [object setValue:imageOfResturentURL forKey:@"imageOfResturentURL"];
    [appDelegate saveContext];
}
-(void)delectItemFromCoreData:(NSString*)position
{
//    NSFetchRequest*fetchRequest1=[NSFetchRequest fetchRequestWithEntityName:@"Order_List"];
//    NSArray*Array1=[context executeFetchRequest:fetchRequest1 error:nil];
//    [context deleteObject:[Array1 objectAtIndex:[position integerValue]]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"Order_List" inManagedObjectContext:context];
     //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID like %@",userID];
     [fetchRequest setEntity:entity];
    // [fetchRequest setPredicate:predicate];
     
     NSError *error;
     NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    NSManagedObject * managedObject = [items objectAtIndex:[position intValue]];
//     for (NSManagedObject *managedObject in items)
//     {
     [context deleteObject:managedObject];
    // }
}
@end
