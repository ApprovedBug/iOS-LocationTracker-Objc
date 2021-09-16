//
//  APBPhotoMO+CoreDataProperties.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//
//

#import "APBPhotoMO+CoreDataProperties.h"

@implementation APBPhotoMO (CoreDataProperties)

+ (NSFetchRequest<APBPhotoMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
}

@dynamic height;
@dynamic id;
@dynamic width;
@dynamic location;

@end
