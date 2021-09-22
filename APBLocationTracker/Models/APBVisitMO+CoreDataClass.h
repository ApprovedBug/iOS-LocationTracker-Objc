//
//  APBVisitMO+CoreDataClass.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "APBCoordinateMO+CoreDataClass.h"
#import "APBHttpClient.h"

@class APBCoordinateMO, APBLocationMO;

NS_ASSUME_NONNULL_BEGIN

@interface APBVisitMO : NSManagedObject

+ (instancetype)createWithCoordinate:(APBCoordinateMO *)coordinate;
+ (NSArray *)unsearched;
+ (NSArray *)all;


- (void)searchForLocationWithURLSession:(id<APBNSURLSessionProtocol>)urlSession
                             completion:(void (^)(BOOL))completion;

@end

NS_ASSUME_NONNULL_END

#import "APBVisitMO+CoreDataProperties.h"
