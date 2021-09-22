//
//  APBTabViewController.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 17/09/2021
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "APBHttpClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface APBTabViewController : UITabBarController

- (id)initWithLocationManager:(CLLocationManager *)locationManager
                   urlSession:(id<APBNSURLSessionProtocol>)urlSession;

@end

NS_ASSUME_NONNULL_END
