//
//  APBCoordinateMO+CoreDataClass.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 16/09/2021
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface APBCoordinateMO : NSManagedObject

+ (instancetype)createWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

@end

NS_ASSUME_NONNULL_END

#import "APBCoordinateMO+CoreDataProperties.h"
