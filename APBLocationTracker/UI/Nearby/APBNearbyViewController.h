//
//  APBDashboardViewController.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 09/09/2021
//

#import <APBFoundation/APBFoundation.h>
#import "CoreLocation/CoreLocation.h"
#import "APBNearbyRootView.h"
#import "APBHttpClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface APBNearbyViewController : APBBaseViewController {
    CLLocationManager *_locationManager;
    APBNearbyRootView *_rootView;
    id<APBNSURLSessionProtocol> _urlSession;
}

@property (nonatomic) APBNearbyRootView *rootView;

- (id)initWithLocationManager:(CLLocationManager *)locationManager
                   urlSession:(nonnull id<APBNSURLSessionProtocol>)urlSession;

@end

NS_ASSUME_NONNULL_END
