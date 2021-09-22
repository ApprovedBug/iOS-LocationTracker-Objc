//
//  APBCoordinateMO+CoreDataProperties.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 16/09/2021
//
//

#import "APBCoordinateMO+CoreDataProperties.h"

@implementation APBCoordinateMO (CoreDataProperties)

+ (NSFetchRequest<APBCoordinateMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Coordinate"];
}

@dynamic longitude;
@dynamic latitude;
@dynamic dateTime;
@dynamic searched;

@end
