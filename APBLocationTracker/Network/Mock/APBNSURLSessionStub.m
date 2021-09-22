//
//  APBNSURLSessionStub.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 22/09/2021
//

#import "APBNSURLSessionStub.h"
#import "APBNSURLSessionDataTaskStub.h"

@implementation APBNSURLSessionStub

- (id<APBNSURLSessionDataTaskProtocol>)dataTaskWithRequest:(NSURLRequest *)request
                                         completionHandler:(void (^)(NSData * _Nullable,
                                                                     NSURLResponse * _Nullable,
                                                                     NSError * _Nullable))completionHandler {
    return [[APBNSURLSessionDataTaskStub alloc] initWithRequest:request
                                              completionHandler:completionHandler];
}

@end
