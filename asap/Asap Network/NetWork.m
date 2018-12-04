//
//  NetWork.m
//  asap
//
//  Created by Hari on 31/08/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork
static NetWork *_sharedMySingleton = nil;
+(NetWork *)networkManager {
    @synchronized([NetWork class]) {
        if (!_sharedMySingleton)
            _sharedMySingleton = [[self alloc] init];
        return _sharedMySingleton;
    }
    return nil;
}
+ (NSData *)synConnectionForUrl:(NSString *)urlString bodyAttachment:(NSDictionary *)bodyAttachment response:(NSURLResponse **)response error:(NSError **)error
{
    NSError *attachmentError = nil;;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyAttachment
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&attachmentError];
    if(attachmentError)
        return nil;
    NSString *jsonString = nil;
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", attachmentError);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSData *postData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    if(url == nil)
        return nil;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if(request == nil)
        return nil;
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/application-json" forHTTPHeaderField:@"Content-Type"];//x-www-form-urlencoded
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/application-json" forHTTPHeaderField:@"Accept"];
    //[request setHTTPBody:postData];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return data;
}
-(void)loadRequestForUrl:(NSString *)urlString methodType:(NSString*)methodType dic:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    NSError * error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
    [request setHTTPMethod:methodType];
    //[request setAllHTTPHeaderFields:parameters];
    [request setHTTPBody:jsonData];
    [request setValue:@"1234" forHTTPHeaderField:@"Authorization"];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSError *parseError;
                                                    if(data == nil || data.length == 0)
                                                    {
                                                        complete(nil, response, error);
                                                    }
                                                    else
                                                    {
                                                        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                        complete(json, response, error);
                                                    }
                                                    
                                                    
                                                }];
    [dataTask resume];
}
//-(void)loadRequestForUrl:(NSString *)urlString dic:(NSDictionary *)parameters complete:(CompletionBlockWithData )complete
//{
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
//    NSError * error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
//    [request setHTTPMethod:@"POST"];
//    //[request setAllHTTPHeaderFields:parameters];
//    [request setHTTPBody:jsonData];
//    [request setValue:@"1234" forHTTPHeaderField:@"Authorization"];
//    NSURLSession * session = [NSURLSession sharedSession];
//    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error]; // you need to convert to dictionary object
//       // NSLog(@"requestReply: %@", jsonDict);
//    }] resume];
//}
-(void)loadGetRequestForUrl:(NSString *)urlString complete:(CompletionBlockWithData )complete
{
    NSDictionary *headers = @{ @"Authorization": @"1234"};
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSError *parseError;
                                                    if(data == nil || data.length == 0)
                                                    {
                                                        complete(nil, response, error);
                                                    }
                                                    else
                                                    {
                                                        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                        complete(json, response, error);
                                                    }
                                                    
                                                    
                                                }];
    [dataTask resume];
}
-(NSString *)urlStringFromDictionary:(NSDictionary *)dictionary
{
    NSString *string = @"";
    NSArray *keys = dictionary.allKeys;
    NSInteger count = keys.count;
    for (int i=0; i<count; i++)
    {
        NSString *key = keys[i];
        NSString *value = dictionary[key];
        string = [string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
        if(i+1 != count)
        {
            string = [string stringByAppendingString:@"&"];
        }
    }
    
    return string;
}





#pragma mark - put url
-(void)forProfileUpdateUrl:(NSString*)url methodType:(NSString*)methodType withParams:(NSDictionary*)userDetails complete:(CompletionBlockWithData)complete
{
    
}



#pragma mark - Login

-(void)ForLoginUrl:(NSString *) url  withParam:(NSDictionary*)params complete:(CompletionBlockWithData)complete
{
    //?ORDER_ID=MYSER-FOODlec650
    NSString *parametersString = [self urlStringFromDictionary:params];
    //NSString *urlString = url;
    NSString *completeUrlString = [NSString stringWithFormat:@"%@?%@",url,parametersString];
    completeUrlString = [completeUrlString stringByAddingPercentEscapesUsingEncoding:
                         NSUTF8StringEncoding];
    [self loadGetRequestForUrl:completeUrlString complete:complete];
    //[self loadRequestForUrl:completeUrlString complete:complete];
}


#pragma mark - registration

-(void)Register:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/signup";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}


#pragma mark - sendOtp & verfiyOtp


-(void)otpVerification:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/otpcheck";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}
-(void)toSendOTP:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/otpsend";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}


#pragma mark - restarentDetails

-(void)getBannersData:(NSString *)url completa:(CompletionBlockWithData)complete
{
    NSString * completeUrlString = [url stringByAddingPercentEscapesUsingEncoding:
                                    NSUTF8StringEncoding];
    [self loadGetRequestForUrl:completeUrlString complete:complete];
}

-(void)getCategoryData:(NSString *)url completa:(CompletionBlockWithData)complete
{
    NSString * completeUrlString = [url stringByAddingPercentEscapesUsingEncoding:
                                    NSUTF8StringEncoding];
    [self loadGetRequestForUrl:completeUrlString complete:complete];
}

-(void)ForRestaurestListUrl:(NSString *)url getRestaurestList:(NSDictionary *)location completa:(CompletionBlockWithData )complete
{
    NSString *parametersString = [self urlStringFromDictionary:location];
    NSString *urlString = url;
    NSString *completeUrlString = [NSString stringWithFormat:@"%@?%@",urlString,parametersString];
    completeUrlString = [completeUrlString stringByAddingPercentEscapesUsingEncoding:
                         NSUTF8StringEncoding];
    [self loadGetRequestForUrl:completeUrlString complete:complete];
}



#pragma mark - restarentItemList


-(void)resturentDetails:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/itemList";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}


#pragma mark - profileScreen

-(void)getProfileUrl:(NSString *)url profile:(NSDictionary *)userDetails completa:(CompletionBlockWithData )complete
{
    NSString *parametersString = [self urlStringFromDictionary:userDetails];
    NSString *completeUrlString = [NSString stringWithFormat:@"%@?%@",url,parametersString];
    completeUrlString = [completeUrlString stringByAddingPercentEscapesUsingEncoding:
                         NSUTF8StringEncoding];
    //http://asapfood.in/dev/api/profile?userId=1023863&user_token=83bca3c384f2b1e1d0aa7390e7997f77
    [self loadGetRequestForUrl:completeUrlString complete:complete];
}

-(void)updateProfileUrl:(NSString*) url parameters:(NSDictionary*)userDetails complete:(CompletionBlockWithData)complete
{
    [self loadRequestForUrl:url methodType:@"PUT" dic:userDetails complete:complete];
}
-(void)getEditAddress:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/editAddress";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}

-(void)getMakeDefaultAddress:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/makedefault";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}
#pragma mark - AddAddressScreen

-(void)AddAddressData:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/addAddress";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}

#pragma mark - groupScreen

//-(void)getGroupUserList:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete
//{
//    NSString *urlString = @"http://asapfood.in/dev/api/userList";
//    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
//}
-(void)createAGroup:(NSDictionary *)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/addgroup";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}
//-(void)createAGroup:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete
//{
//    NSString *urlString = @"http://asapfood.in/dev/api/addgroup";
//    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
//}
-(void)addUserToGroup:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/addgrouplist";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}
-(void)getGroupDetails:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/groupDetail";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}
-(void)delectUserFromGroup:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/deleteUserFromGroup";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}

#pragma mark - checkOutScreen

-(void)getAddressList:(NSString *)url Address:(NSDictionary *)userDetails completa:(CompletionBlockWithData )complete
{
    NSString *parametersString = [self urlStringFromDictionary:userDetails];
    NSString *completeUrlString = [NSString stringWithFormat:@"%@?%@",url,parametersString];
    completeUrlString = [completeUrlString stringByAddingPercentEscapesUsingEncoding:
                         NSUTF8StringEncoding];
    [self loadGetRequestForUrl:completeUrlString complete:complete];
}

-(void)getGroupListData:(NSDictionary*)userDetails complete:(CompletionBlockWithData )complete
{
    NSString *urlString = @"http://asapfood.in/dev/api/groupList";
    [self loadRequestForUrl:urlString methodType:@"POST" dic:userDetails complete:complete];
}

@end
