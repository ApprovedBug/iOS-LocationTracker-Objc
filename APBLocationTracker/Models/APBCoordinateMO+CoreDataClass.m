//
//  APBCoordinateMO+CoreDataClass.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 16/09/2021
//
//

#import "APBCoordinateMO+CoreDataClass.h"
#import "AppDelegate.h"
#import "NSManagedObject+Helpers.h"

@implementation APBCoordinateMO

+ (instancetype)createWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;

    APBCoordinateMO *coordinate = [APBCoordinateMO createNewInContext:context];
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;

    [delegate saveContext];
    return coordinate;
}

@end
