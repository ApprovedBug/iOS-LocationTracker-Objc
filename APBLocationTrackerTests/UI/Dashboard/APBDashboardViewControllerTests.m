//
//  APBDashboardViewControllerTests.m
//  APBLocationTrackerTests
//
//  Created by ApprovedBug on 13/09/2021
//

#import <XCTest/XCTest.h>
#import "APBDashboardViewControllerMock.h"
#import "CoreLocation/CoreLocation.h"

@interface APBDashboardViewControllerTests : XCTestCase

@end

@implementation APBDashboardViewControllerTests

- (void)setup {

}

- (void)test_initLocationManager_managerNotNil {

    CLLocationManager *locationManager = [[CLLocationManager alloc] init];

    APBDashboardViewControllerMock *viewController = [[APBDashboardViewControllerMock alloc] initWithLocationManager:locationManager];

    XCTAssertNotNil(viewController.locationManager);
}

@end
