//
//  NSManagedObject+Helpers.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//

#import "NSManagedObject+Helpers.h"

@implementation NSManagedObject (Helpers)

#pragma mark - Public methods

+ (instancetype)createNewInContext:(NSManagedObjectContext *)context {

    NSEntityDescription *entity = [NSEntityDescription entityForName:[self className]
                                              inManagedObjectContext:context];

    id object = [[self alloc] initWithEntity:entity
              insertIntoManagedObjectContext:context];

    return object;
}

+ (instancetype)findFirstInContext:(NSManagedObjectContext *)context {
    NSArray *results = [self findAllInContext:context];

    return results != nil && results.count > 0 ? results[0] : nil;
}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context {

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self className]];
    [request setReturnsObjectsAsFaults:NO];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }

    return results != nil && results.count > 0 ? results : nil;
}

+ (instancetype)findFirstWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSArray *results = [self findAllWithPredicate:predicate inContext:context];

    return results.count > 0 ? results[0] : nil;
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self className]];
    [request setReturnsObjectsAsFaults:NO];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }

    return results != nil && results.count > 0 ? results : nil;
}

+ (void)deleteAllInContext:(NSManagedObjectContext *)context {

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self className]];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];

    NSError *deleteError = nil;
    [context executeRequest:delete error:&deleteError];
}

#pragma mark - Private methods

+ (NSString *)className {
    return [[self entity] name];
}

@end
