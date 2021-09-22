//
//  APBNSURLSessionDataTaskStub.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 22/09/2021
//

#import <Foundation/Foundation.h>
#import "APBHttpClient.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^APBNSURLSessionDataTaskStubBlock)(NSData * _Nullable,
                                                 NSURLResponse * _Nullable,
                                                 NSError * _Nullable);

@interface APBNSURLSessionDataTaskStub : NSObject<APBNSURLSessionDataTaskProtocol>

- (instancetype)initWithRequest:(NSURLRequest *)request
              completionHandler:(APBNSURLSessionDataTaskStubBlock)completionHandler;

@end

NS_ASSUME_NONNULL_END
