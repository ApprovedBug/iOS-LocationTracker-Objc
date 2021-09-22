//
//  APBVisitMO+CoreDataClass.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//
//

#import "APBVisitMO+CoreDataClass.h"
#import "AppDelegate.h"
#import "NSManagedObject+Helpers.h"
#import "APBLocationMO+CoreDataClass.h"

@implementation APBVisitMO

+ (instancetype)createWithCoordinate:(APBCoordinateMO *)coordinate {

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;

    APBVisitMO *visit = [APBVisitMO createNewInContext:context];
    visit.coordinate = coordinate;
    visit.dateTime = [[NSDate date] timeIntervalSince1970];
    visit.searched = NO;

    return visit;
}

+ (NSArray *)unsearched {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"searched == NO"];

    NSArray *results = [APBVisitMO findAllWithPredicate:predicate inContext:context];

    return results;
}

+ (NSArray *)all {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"searched == YES && location != nil"];

    NSArray *results = [APBVisitMO findAllWithPredicate:predicate inContext:context];

    return results;
}

- (void)searchForLocationWithURLSession:(id<APBNSURLSessionProtocol>)urlSession
                             completion:(void (^)(BOOL))completion {
    [APBLocationMO specificLocationWith:self.coordinate.latitude
                              longitude:self.coordinate.longitude
                             urlSession:urlSession
                                success:^(NSArray * _Nonnull locations) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

        if (locations != nil && locations.count == 1) {
            [self setLocation:locations.firstObject];
            [self setSearched:YES];
            [delegate saveContext];
        } else if (locations != nil && locations.count == 0) {
            [self setSearched:YES];
            [delegate saveContext];
            completion(YES);
        }
    } failure:^(NSError * _Nonnull error) {
        completion(NO);
    }];
}

@end
