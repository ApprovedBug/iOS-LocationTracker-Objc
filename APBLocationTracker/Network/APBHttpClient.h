//
//  APBHttpClient.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 22/09/2021
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol APBNSURLSessionDataTaskProtocol <NSObject>

- (void)resume;

@end

@protocol APBNSURLSessionProtocol <NSObject>

- (id<APBNSURLSessionDataTaskProtocol>)dataTaskWithRequest:(NSURLRequest *)request
                                         completionHandler:(nonnull void (^)(NSData * _Nullable,
                                                                             NSURLResponse * _Nullable,
                                                                             NSError * _Nullable))completionHandler;

@end

@interface APBHttpClient : NSObject

- (instancetype)initWithSession:(id <APBNSURLSessionProtocol>)session;
- (void)getWithURL:(NSURL *)url
           headers:(NSDictionary * _Nullable)headers
 completionHandler:(nonnull void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler;

- (void)postWithURL:(NSURL *)url
            headers:(NSDictionary *)headers
            content:(NSString *)content
  completionHandler:(nonnull void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler;

@end

NS_ASSUME_NONNULL_END
