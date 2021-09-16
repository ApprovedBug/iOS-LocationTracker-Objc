//
//  APBLocationMO+CoreDataClass.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class APBPhotoMO, APBReviewMO, NSObject;

NS_ASSUME_NONNULL_BEGIN

@interface APBLocationMO : NSManagedObject

+ (void)locationsWithLatitude:(double)latitude
                    longitude:(double)longitude
                       succes:(void(^)(NSArray *locations))success
                      failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

#import "APBLocationMO+CoreDataProperties.h"
