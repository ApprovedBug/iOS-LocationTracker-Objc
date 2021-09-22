//
//  APBVisitMO+CoreDataProperties.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//
//

#import "APBVisitMO+CoreDataProperties.h"

@implementation APBVisitMO (CoreDataProperties)

+ (NSFetchRequest<APBVisitMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Visit"];
}

@dynamic id;
@dynamic dateTime;
@dynamic searched;
@dynamic coordinate;
@dynamic location;

@end
