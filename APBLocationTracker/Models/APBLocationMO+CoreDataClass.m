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
#import "APBHttpClient.h"
#import "NSURLSession+Extension.h"

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
    location.vicinity = [dictionary valueForKey:@"vicinity" ifKindOf:[NSString class]];
    location.types = [dictionary valueForKey:@"types" ifKindOf:[NSArray class]];

    NSArray *photos = [dictionary valueForKey:@"photos" ifKindOf:[NSArray class]];
    if ([photos firstObject] != nil) {
        NSDictionary *thumbnailDict = [photos firstObject];
        NSString *photoRef = [thumbnailDict valueForKey:@"photo_reference" ifKindOf:[NSString class]];
        location.thumbnailUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=300&photo_reference=%@&key=%@", photoRef, @"AIzaSyAKf7aYgDnXsPiyB9N5Ta5WiptoeFiiwZQ"];
    }

    NSNumber *rating = [dictionary valueForKey:@"rating" ifKindOf:[NSNumber class]];
    if (rating != nil) {
        location.rating = [rating doubleValue];
    }

    NSNumber *userRatingsTotal = [dictionary valueForKey:@"user_ratings_total" ifKindOf:[NSNumber class]];
    if (userRatingsTotal != nil) {
        location.userRatingsTotal = [userRatingsTotal intValue];
    }

    NSNumber *priceLevel = [dictionary valueForKey:@"price_level" ifKindOf:[NSNumber class]];
    if (priceLevel != nil) {
        location.priceLevel = [priceLevel doubleValue];
    }

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

+ (void)nearbyLocationsWithLatitude:(double)latitude
                          longitude:(double)longitude
                         urlSession:(id<APBNSURLSessionProtocol>)urlSession
                            success:(void (^)(NSArray * _Nonnull))success
                            failure:(void (^)(NSError * _Nonnull))failure {
    NSURL *url = [self locationURLWithRadius:500 latitude:latitude longitude:longitude];

    APBHttpClient *client = [[APBHttpClient alloc] initWithSession:urlSession];

    [client getWithURL:url headers:nil completionHandler:^(NSData * _Nullable data,
                                                           NSURLResponse * _Nullable response,
                                                           NSError * _Nullable error) {
        [self handleNetworkResponse:data succes:success failure:failure];
    }];
}

+ (void)specificLocationWith:(double)latitude
                   longitude:(double)longitude
                  urlSession:(id<APBNSURLSessionProtocol>)urlSession
                     success:(void (^)(NSArray * _Nonnull))success
                     failure:(void (^)(NSError * _Nonnull))failure {

    NSURL *url = [self locationURLWithRadius:15 latitude:latitude longitude:longitude];

    APBHttpClient *client = [[APBHttpClient alloc] initWithSession:urlSession];

    [client getWithURL:url headers:nil completionHandler:^(NSData * _Nullable data,
                                                           NSURLResponse * _Nullable response,
                                                           NSError * _Nullable error) {
        [self handleNetworkResponse:data succes:success failure:failure];
    }];
}

+ (NSURL *)locationURLWithRadius:(int)radius
                        latitude:(double)latitude
                        longitude:(double)longitude {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json"];

    NSString *formattedLatLong = [NSString stringWithFormat:@"%f %f", latitude, longitude];

    NSArray *queryItems = @[[[NSURLQueryItem alloc] initWithName:@"radius" value:[@(radius) stringValue]],
                            [[NSURLQueryItem alloc] initWithName:@"type" value:@"bar"],
                            [[NSURLQueryItem alloc] initWithName:@"key" value:@"AIzaSyAKf7aYgDnXsPiyB9N5Ta5WiptoeFiiwZQ"],
                            [[NSURLQueryItem alloc] initWithName:@"location" value:formattedLatLong]];

    [urlComponents setQueryItems:queryItems];

    return [urlComponents URL];
}

@end
