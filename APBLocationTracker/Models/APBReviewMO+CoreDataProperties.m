//
//  APBReviewMO+CoreDataProperties.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//
//

#import "APBReviewMO+CoreDataProperties.h"

@implementation APBReviewMO (CoreDataProperties)

+ (NSFetchRequest<APBReviewMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Review"];
}

@dynamic author;
@dynamic id;
@dynamic rating;
@dynamic relativeTimeDescription;
@dynamic text;
@dynamic location;

@end
