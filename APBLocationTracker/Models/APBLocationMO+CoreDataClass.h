//
//  APBLocationMO+CoreDataClass.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "APBHttpClient.h"

@class APBPhotoMO, APBReviewMO, NSObject;

NS_ASSUME_NONNULL_BEGIN

@interface APBLocationMO : NSManagedObject

+ (void)nearbyLocationsWithLatitude:(double)latitude
                          longitude:(double)longitude
                         urlSession:(id<APBNSURLSessionProtocol>)urlSession
                            success:(void(^)(NSArray *locations))success
                            failure:(void(^)(NSError *error))failure;

+ (void)specificLocationWith:(double)latitude
                   longitude:(double)longitude
                  urlSession:(id<APBNSURLSessionProtocol>)urlSession
                     success:(void(^)(NSArray *locations))success
                     failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

#import "APBLocationMO+CoreDataProperties.h"
