//
//  AppDelegate.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 08/09/2021
//

#import "AppDelegate.h"
#import "APBTabViewController.h"
#import "Constants.h"
#import "APBCoordinateMO+CoreDataClass.h"
#import "NSManagedObject+Helpers.h"
#import <UserNotifications/UserNotifications.h>
#import "CoreLocation/CoreLocation.h"
#import "APBVisitMO+CoreDataClass.h"
#import "APBHttpClient.h"
#import "NSURLSession+Extension.h"
#import "APBNSURLSessionStub.h"

@interface AppDelegate () <CLLocationManagerDelegate> {
    APBTabViewController *_tabController;
    CLLocationManager *_locationManager;
    id<APBNSURLSessionProtocol> _urlSession;
}

@end

@implementation AppDelegate

- (id<APBNSURLSessionProtocol>)urlSession {
    if (_urlSession == nil) {
//        _urlSession = [NSURLSession sharedSession];
        _urlSession = [[APBNSURLSessionStub alloc] init];
    }
    return _urlSession;
}

- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.allowsBackgroundLocationUpdates = YES;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (APBTabViewController *)tabController {
    if (!_tabController) {
        _tabController = [[APBTabViewController alloc] initWithLocationManager:self.locationManager
                                                                    urlSession:self.urlSession];
    }

    return _tabController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self.locationManager startMonitoringVisits];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:self.tabController];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - Private methods

- (void)saveCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"Visit detected: Latitude - %f, Longitude - %f", coordinate.latitude, coordinate.longitude);

    NSDictionary *locationInfo = @{ @"latitude": [NSNumber numberWithDouble:coordinate.latitude],
                                    @"longitude": [NSNumber numberWithDouble:coordinate.longitude] };

    [[NSNotificationCenter defaultCenter] postNotificationName:kAPBVisitDetected
                                                        object:nil
                                                      userInfo:locationInfo];

    APBCoordinateMO *createdCoordinate = [APBCoordinateMO createWithLatitude:coordinate.latitude longitude:coordinate.longitude];


    [APBVisitMO createWithCoordinate:createdCoordinate];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"APBLocationTracker"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark CLLocationManagerDelegate

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    if (manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways) {
        [manager startMonitoringVisits];
        [manager requestLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocation *location = locations.lastObject;

    if (location != nil) {
        NSLog(@"Location detected: Latitude - %f, Longitude - %f", location.coordinate.latitude, location.coordinate.longitude);

        NSDictionary *locationInfo = @{ @"latitude": [NSNumber numberWithDouble:location.coordinate.latitude],
                                        @"longitude": [NSNumber numberWithDouble:location.coordinate.longitude] };

        [[NSNotificationCenter defaultCenter] postNotificationName:kAPBLocationDetected
                                                            object:nil
                                                          userInfo:locationInfo];
    }
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit {

    [self saveCoordinate:visit.coordinate];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
