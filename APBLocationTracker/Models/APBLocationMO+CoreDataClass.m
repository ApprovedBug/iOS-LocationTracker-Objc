//
//  APBLocationMO+CoreDataClass.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//
//

#import "APBLocationMO+CoreDataClass.h"
#import "NSDictionary+SafeGuard.h"
#import "NSManagedObject+Helpers.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@implementation APBLocationMO

#pragma mark Private methods

- (instancetype)initWithJSON:(NSDictionary *)dictionary {

    NSString *locationId = [dictionary valueForKey:@"place_id" ifKindOf:[NSString class]];

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;

    APBLocationMO *location = [APBLocationMO findLocationWithId:locationId inContext:context];
    if (location == nil) {
        location = [APBLocationMO createNewInContext:context];
    }

    location.id = [dictionary valueForKey:@"place_id" ifKindOf:[NSString class]];
    location.name = [dictionary valueForKey:@"name" ifKindOf:[NSString class]];

    [delegate saveContext];

    return location;
}

+ (instancetype)findLocationWithId:(NSString *)locationId inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@", locationId];
    return [APBLocationMO findFirstWithPredicate:predicate inContext:context];
}

+ (void)handleNetworkResponse:(NSData *)data
                       succes:(void (^)(NSArray * _Nonnull))success
                      failure:(void (^)(NSError * _Nonnull))failure {
    NSError *e = nil;
    NSDictionary *mainDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];

    if (e == nil) {
        NSMutableArray *locationsArray = [[NSMutableArray alloc] init];

        NSArray *locationDictionaries = [mainDictionary valueForKey:@"results" ifKindOf:[NSArray class]];

        for (NSDictionary *locationDictionary in locationDictionaries) {
            APBLocationMO *location = [[APBLocationMO alloc] initWithJSON:locationDictionary];

            [locationsArray addObject:location];
        }

        success(locationsArray);
    } else {
        failure(e);
    }
}

#pragma mark Public methods

+ (void)locationsWithLatitude:(double)latitude
                    longitude:(double)longitude
                       succes:(void (^)(NSArray * _Nonnull))success
                      failure:(void (^)(NSError * _Nonnull))failure {

    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json"];

    NSString *formattedLatLong = [NSString stringWithFormat:@"%f %f", latitude, longitude];

    NSArray *queryItems = @[[[NSURLQueryItem alloc] initWithName:@"radius" value:@"200"],
                            [[NSURLQueryItem alloc] initWithName:@"type" value:@"bar"],
                            [[NSURLQueryItem alloc] initWithName:@"key" value:@"AIzaSyAKf7aYgDnXsPiyB9N5Ta5WiptoeFiiwZQ"],
                            [[NSURLQueryItem alloc] initWithName:@"location" value:formattedLatLong]];

    [urlComponents setQueryItems:queryItems];

    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[urlComponents URL]];

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        dispatch_async(dispatch_get_main_queue(), ^{

            if (error == nil) {
                [self handleNetworkResponse:data
                                     succes:success
                                    failure:failure];
            } else {
                failure(error);
            }
        });
    }];

    [task resume];
}

@end
