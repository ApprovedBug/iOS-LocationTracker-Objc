//
//  APBLocationMO+CoreDataProperties.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//
//

#import "APBLocationMO+CoreDataProperties.h"

@implementation APBLocationMO (CoreDataProperties)

+ (NSFetchRequest<APBLocationMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Location"];
}

@dynamic id;
@dynamic name;
@dynamic rating;
@dynamic thumbnailUrl;
@dynamic types;
@dynamic vicinity;
@dynamic userRatingsTotal;
@dynamic priceLevel;
@dynamic photos;
@dynamic reviews;

@end
