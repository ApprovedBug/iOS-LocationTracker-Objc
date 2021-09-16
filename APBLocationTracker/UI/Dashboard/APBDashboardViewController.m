//
//  APBDashboardViewController.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 09/09/2021
//

#import "APBDashboardViewController.h"
#import "APBLocationMO+CoreDataClass.h"
#import "APBLocationsCollectionViewDelegate.h"
#import "APBDashboardLocationCollectionViewCell.h"

@interface APBDashboardViewController () <CLLocationManagerDelegate>

@property (nonatomic) APBLocationsCollectionViewDelegate *locationsCollectionViewDelegate;

@end

@implementation APBDashboardViewController

@dynamic rootView;

#pragma mark - Properties

- (APBLocationsCollectionViewDelegate *)locationsCollectionViewDelegate {
    if (_locationsCollectionViewDelegate == nil) {
        _locationsCollectionViewDelegate = [[APBLocationsCollectionViewDelegate alloc]
                                            initWithClass:[APBDashboardLocationCollectionViewCell class]
                                            resuseIdentifier:@"locationCell"];
    }
    return _locationsCollectionViewDelegate;
}

- (APBDashboardRootView *)rootView {
    if (_rootView == nil) {
        _rootView = [[APBDashboardRootView alloc] init];
        _rootView.locationsCollectionView.dataSource = self.locationsCollectionViewDelegate;
        _rootView.locationsCollectionView.delegate = self.locationsCollectionViewDelegate;
        [_rootView.locationsCollectionView registerClass:self.locationsCollectionViewDelegate.cellClass
                              forCellWithReuseIdentifier:self.locationsCollectionViewDelegate.reuseIdentifier];
    }
    return _rootView;
}

#pragma mark - View load methods

- (id)initWithLocationManager:(CLLocationManager *)locationManager {
    self = [super init];

    _locationManager = locationManager;
    _locationManager.delegate = self;

    return self;
}

- (void)loadView {
    [super loadView];

    [self configureNavBar];

    [self checkLocationPermission:_locationManager.authorizationStatus];
}

#pragma mark - Private methods

- (void)configureNavBar {

    self.navigationItem.title = @"Nearby Bars";
}

- (void)checkLocationPermission:(CLAuthorizationStatus)locationPermissionStatus {

    if (locationPermissionStatus == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestAlwaysAuthorization];
    } else if (locationPermissionStatus == kCLAuthorizationStatusAuthorizedAlways) {
        [_locationManager startMonitoringSignificantLocationChanges];
    }
}

#pragma mark CLLocationManagerDelegate

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    if (manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways) {
        [_locationManager startMonitoringSignificantLocationChanges];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocation *location = locations.firstObject;

    if (location != nil) {
        NSLog(@"Latitude - %f, Longitude - %f", location.coordinate.latitude, location.coordinate.longitude);
        [self findNearbyRestaurants:location];
    }
}

- (void)findNearbyRestaurants:(CLLocation *)location {

    [APBLocationMO locationsWithLatitude:location.coordinate.latitude
                               longitude:location.coordinate.longitude
                                  succes:^(NSArray * _Nonnull mapLocations) {

        [self displayNearbyLocations:mapLocations];
    } failure:^(NSError * _Nonnull error) {
        [self displayError];
    }];
}

- (void)displayNearbyLocations:(NSArray *)locations {
    for (APBLocationMO *location in locations) {
        NSLog(@"Location - %@", location.name);
    }

    self.locationsCollectionViewDelegate.data = locations;

    [self.rootView.locationsCollectionView reloadData];
}

- (void)displayError {

}

@end
