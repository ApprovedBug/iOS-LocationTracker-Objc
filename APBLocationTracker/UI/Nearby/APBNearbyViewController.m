//
//  APBDashboardViewController.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 09/09/2021
//

#import "APBNearbyViewController.h"
#import "APBLocationMO+CoreDataClass.h"
#import "APBNearbyCollectionViewDelegate.h"
#import "APBNearbyLocationCollectionViewCell.h"
#import "Constants.h"
#import "APBCoordinateMO+CoreDataClass.h"

@interface APBNearbyViewController ()

@property (nonatomic) APBNearbyCollectionViewDelegate *locationsCollectionViewDelegate;

@end

@implementation APBNearbyViewController

@dynamic rootView;

#pragma mark - Properties

- (APBNearbyCollectionViewDelegate *)locationsCollectionViewDelegate {
    if (_locationsCollectionViewDelegate == nil) {
        _locationsCollectionViewDelegate = [[APBNearbyCollectionViewDelegate alloc]
                                            initWithClass:[APBNearbyLocationCollectionViewCell class]
                                            resuseIdentifier:@"locationCell"];
    }
    return _locationsCollectionViewDelegate;
}

- (APBNearbyRootView *)rootView {
    if (_rootView == nil) {
        _rootView = [[APBNearbyRootView alloc] init];
        _rootView.locationsCollectionView.dataSource = self.locationsCollectionViewDelegate;
        _rootView.locationsCollectionView.delegate = self.locationsCollectionViewDelegate;
        [_rootView.locationsCollectionView registerClass:self.locationsCollectionViewDelegate.cellClass
                              forCellWithReuseIdentifier:self.locationsCollectionViewDelegate.reuseIdentifier];
    }
    return _rootView;
}

#pragma mark - View load methods

- (id)initWithLocationManager:(CLLocationManager *)locationManager
                   urlSession:(nonnull id<APBNSURLSessionProtocol>)urlSession {

    _locationManager = locationManager;
    _urlSession = urlSession;
    
    self = [super init];

    return self;
}

- (void)loadView {
    [super loadView];

    [self configureNavBar];

    [self setupNotifications];
}

- (void)loadData {
    [self checkLocationPermission:_locationManager.authorizationStatus];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private methods

- (void)configureNavBar {

    self.navigationItem.title = @"Nearby Bars";
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findNearbyRestaurants:)
                                                 name:kAPBLocationDetected
                                               object:nil];
}

- (void)checkLocationPermission:(CLAuthorizationStatus)locationPermissionStatus {
    [self.rootView.activityIndicatorView startAnimating];

    if (locationPermissionStatus == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestAlwaysAuthorization];
    } else if (locationPermissionStatus == kCLAuthorizationStatusAuthorizedAlways) {
        [_locationManager startMonitoringVisits];
        [_locationManager requestLocation];
    }
}

- (void)findNearbyRestaurants:(NSNotification *)notification  {

    [_locationManager stopUpdatingLocation];

    NSDictionary *locationInfo = [notification userInfo];

    double latitude = [[locationInfo objectForKey:@"latitude"] doubleValue];
    double longitude = [[locationInfo objectForKey:@"longitude"] doubleValue];

    __weak typeof(self) weakSelf = self;

    [APBLocationMO nearbyLocationsWithLatitude:latitude
                                     longitude:longitude
                                    urlSession:_urlSession
                                       success:^(NSArray * _Nonnull mapLocations) {

        [weakSelf displayNearbyLocations:mapLocations];
    } failure:^(NSError * _Nonnull error) {
        [weakSelf displayError];
    }];
}

- (void)displayNearbyLocations:(NSArray *)locations {
    [self.rootView.activityIndicatorView stopAnimating];

    for (APBLocationMO *location in locations) {
        NSLog(@"Location - %@", location.name);
    }

    self.locationsCollectionViewDelegate.data = locations;

    [self.rootView.locationsCollectionView reloadData];
}

- (void)displayError {

}

@end
