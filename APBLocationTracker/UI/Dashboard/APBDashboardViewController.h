//
//  APBDashboardViewController.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 09/09/2021
//

#import <APBFoundation/APBFoundation.h>
#import "CoreLocation/CoreLocation.h"
#import "APBDashboardRootView.h"

NS_ASSUME_NONNULL_BEGIN

@interface APBDashboardViewController : APBBaseViewController {
    CLLocationManager *_locationManager;
    APBDashboardRootView *_rootView;
}

@property (nonatomic) APBDashboardRootView *rootView;

- (id)initWithLocationManager:(CLLocationManager *)locationManager;

@end

NS_ASSUME_NONNULL_END
