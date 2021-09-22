//
//  APBTabViewController.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 17/09/2021
//

#import "APBTabViewController.h"
#import "APBNearbyViewController.h"
#import "APBVisitsViewController.h"

@interface APBTabViewController ()

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) id<APBNSURLSessionProtocol> urlSession;
@property (nonatomic) UINavigationController *nearbyNavigationController;
@property (nonatomic) UINavigationController *visitsNavigationController;

@end

@implementation APBTabViewController

#pragma mark - Properties

- (UINavigationController *)nearbyViewController {
    if (_nearbyNavigationController == nil) {
        APBNearbyViewController *nearbyViewController = [[APBNearbyViewController alloc]
                                                         initWithLocationManager:self.locationManager
                                                         urlSession:self.urlSession];
        UIImage *tabIcon = [UIImage systemImageNamed:@"mappin.and.ellipse"];
        [nearbyViewController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Nearby" image:tabIcon tag:1]];
        _nearbyNavigationController = [[UINavigationController alloc] initWithRootViewController:nearbyViewController];
        _nearbyNavigationController.navigationBar.barStyle = UIBarStyleBlack;
        _nearbyNavigationController.navigationBar.tintColor = [UIColor whiteColor];

    }
    return _nearbyNavigationController;
}

- (UINavigationController *)visitsViewController {
    if (_visitsNavigationController == nil) {
        APBVisitsViewController *visitsViewController = [[APBVisitsViewController alloc] initWithUrlSession:self.urlSession];
        UIImage *tabIcon = [UIImage systemImageNamed:@"paperplane.fill"];
        [visitsViewController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Visits" image:tabIcon tag:1]];
        _visitsNavigationController = [[UINavigationController alloc] initWithRootViewController:visitsViewController];
        _visitsNavigationController.navigationBar.barStyle = UIBarStyleBlack;
        _visitsNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    return _visitsNavigationController;
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

    [self setViewControllers:@[self.nearbyViewController, self.visitsViewController]];
}

@end
