//
//  APBNSURLSessionDataTaskStub.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 22/09/2021
//

#import "APBNSURLSessionDataTaskStub.h"

@interface APBNSURLSessionDataTaskStub() {
    NSURLRequest *_request;
    APBNSURLSessionDataTaskStubBlock _completionHandler;
}

@end

@implementation APBNSURLSessionDataTaskStub

- (instancetype)initWithRequest:(NSURLRequest *)request
              completionHandler:(APBNSURLSessionDataTaskStubBlock)completionHandler {
    _request = request;
    _completionHandler = completionHandler;
    self = [super init];
    return self;
}

- (void)resume {

    NSString *unparsedName = _request.URL.path;
    unparsedName = [unparsedName substringWithRange:NSMakeRange(1, unparsedName.length - 6)];
    NSString *fileName = [unparsedName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];

    _completionHandler(data, nil, nil);
}

@end
