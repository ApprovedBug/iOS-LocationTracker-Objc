//
//  APBHttpClient.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 22/09/2021
//

#import "APBHttpClient.h"

@interface APBHttpClient()

@property (nonatomic) id<APBNSURLSessionProtocol> session;

@end

@implementation APBHttpClient

- (instancetype)initWithSession:(id<APBNSURLSessionProtocol>)session {
    self = [super init];
    self.session = session;
    return self;
}

- (void)getWithURL:(NSURL *)url
           headers:(NSDictionary *)headers
 completionHandler:(void (^)(NSData * _Nullable,
                             NSURLResponse * _Nullable,
                             NSError * _Nullable))completionHandler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];

    id<APBNSURLSessionDataTaskProtocol> dataTask = [_session dataTaskWithRequest:request
                                                               completionHandler:^(NSData * _Nullable data,
                                                                                   NSURLResponse * _Nullable response,
                                                                                   NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(data, response, error);
        });
    }];

    [dataTask resume];
}

- (void)postWithURL:(NSURL *)url
            headers:(NSDictionary *)headers
            content:(NSString *)content
  completionHandler:(void (^)(NSData * _Nullable,
                              NSURLResponse * _Nullable,
                              NSError * _Nullable))completionHandler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];

    NSData *jsonData = [content dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    [request setHTTPBody:jsonData];

    id<APBNSURLSessionDataTaskProtocol> dataTask = [_session dataTaskWithRequest:request
                                                               completionHandler:^(NSData * _Nullable data,
                                                                                   NSURLResponse * _Nullable response,
                                                                                   NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(data, response, error);
        });
    }];

    [dataTask resume];
}

@end
