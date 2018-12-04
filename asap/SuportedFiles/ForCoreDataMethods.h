//
//  ForCoreDataMethods.h
//  asap
//
//  Created by Gopal Gundaram on 21/11/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForCoreDataMethods : NSObject
+(ForCoreDataMethods *)networkManager;

-(void)storeDataInCoreData: (NSString*)product_id product_weight:(NSString*)product_weight product_price:(NSString*)product_price product_quantity:(NSString*)product_quantity vendor_id:(NSString*)vendor_id branch_id:(NSString*)branch_id imageOfResturentURL:(NSString*)imageOfResturentURL addressOfResturent:(NSString*)addressOfResturent nameOfResturent:(NSString*)nameOfResturent;
-(NSArray*)getDateFromCoreDate;
-(void)delectItemFromCoreData:(NSString*)position;
-(void)upDataInCoreData: (NSUInteger)postion product_id:(NSString*)product_id product_weight:(NSString*)product_weight product_price:(NSString*)product_price  product_quantity:(NSString*)product_quantity vendor_id:(NSString*)vendor_id branch_id:(NSString*)branch_id imageOfResturentURL:(NSString*)imageOfResturentURL addressOfResturent:(NSString*)addressOfResturent nameOfResturent:(NSString*)nameOfResturent;
@end
