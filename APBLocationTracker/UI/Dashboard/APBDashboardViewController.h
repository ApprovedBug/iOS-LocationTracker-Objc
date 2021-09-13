//
//  APBDashboardViewController.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 09/09/2021
//

#import <APBFoundation/APBFoundation.h>
#import "CoreLocation/CoreLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface APBDashboardViewController : APBBaseViewController

- (id)initWithLocationManager:(CLLocationManager *)locationManager;

@end

NS_ASSUME_NONNULL_END
