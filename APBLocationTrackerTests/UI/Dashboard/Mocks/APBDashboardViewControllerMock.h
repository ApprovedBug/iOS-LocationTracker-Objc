//
//  APBDashboardViewControllerMock.h
//  APBLocationTrackerTests
//
//  Created by ApprovedBug on 13/09/2021
//

#import <Foundation/Foundation.h>
#import "APBDashboardViewController.h"
#import "CoreLocation/CoreLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface APBDashboardViewControllerMock : APBDashboardViewController

- (CLLocationManager *)locationManager;

@end

NS_ASSUME_NONNULL_END
