//
//  NetWork.h
//  asap
//
//  Created by Hari on 31/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <Foundation/Foundation.h>
#define USERID [[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"]
typedef void(^CompletionBlockWithData)(NSDictionary *jsonDict, NSURLResponse *response, NSError *error); 
@interface NetWork : NSObject
+(NetWork *)networkManager;
#pragma mark - unimportant
//-(void)loadRequestForUrl:(NSString *)urlString dic:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;
-(void)loadRequestForUrl:(NSString *)urlString methodType:(NSString*)methodType dic:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete;

-(void)logIn:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete;
-(void)Register:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete;
-(void)otpVerification:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete;
-(void)toSendOTP:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete;
-(void)getEditAddress:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete;
-(void)getGroupUserList:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete;
-(void)AddAddressData:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete;
-(void)getMakeDefaultAddress:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete;
-(void)getGroupListData:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete;
#pragma mark - get url
-(void)ForLoginUrl:(NSString *) url  withParam:(NSDictionary*)params complete:(CompletionBlockWithData)complete;
-(void)ForRestaurestListUrl:(NSString *)url getRestaurestList:(NSDictionary *)location completa:(CompletionBlockWithData )complete;
-(void)getProfileUrl:(NSString *)url profile:(NSDictionary *)userDetails completa:(CompletionBlockWithData )complete;
-(void)getCategoryData:(NSString *)url completa:(CompletionBlockWithData)complete;
-(void)getBannersData:(NSString *)url completa:(CompletionBlockWithData)complete;
-(void)getAddressList:(NSString *)url Address:(NSDictionary *)userDetails completa:(CompletionBlockWithData )complete;

#pragma mark - Put method With Parameters
-(void)updateProfileUrl:(NSString*) url parameters:(NSDictionary*)userDetails complete:(CompletionBlockWithData)complete;

#pragma resturentDetails
-(void)resturentDetails:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete;

#pragma mark - groupScreen
-(void)delectUserFromGroup:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete;
-(void)createAGroup:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete;
-(void)addUserToGroup:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete;
-(void)getGroupDetails:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete;
@end
