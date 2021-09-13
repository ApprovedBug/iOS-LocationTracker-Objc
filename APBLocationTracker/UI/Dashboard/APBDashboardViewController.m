//
//  APBDashboardViewController.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 09/09/2021
//

#import "APBDashboardViewController.h"

@interface APBDashboardViewController () <CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
}

@end

@implementation APBDashboardViewController

- (id)initWithLocationManager:(CLLocationManager *)locationManager {
    self = [super init];

    _locationManager = locationManager;
    _locationManager.delegate = self;

    return self;
}

- (void)loadView {
    [super loadView];

    [self requestLocationPermission:_locationManager.authorizationStatus];
}

- (void)requestLocationPermission:(CLAuthorizationStatus)locationPermissionStatus {
    [_locationManager requestAlwaysAuthorization];
}

#pragma mark CLLocationManagerDelegate

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    if (manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways) {
        [manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    for (CLLocation *location in locations) {
        NSLog(@"Latitude - %f, Longitude - %f", location.coordinate.latitude, location.coordinate.longitude);
    }
}

@end
