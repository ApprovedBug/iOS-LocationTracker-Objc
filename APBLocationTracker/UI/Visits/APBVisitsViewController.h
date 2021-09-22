//
//  APBVisitsViewController.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 17/09/2021
//

#import <UIKit/UIKit.h>
#import <APBFoundation/APBFoundation.h>
#import "APBVisitsRootView.h"
#import "APBHttpClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface APBVisitsViewController : APBBaseViewController {
    APBVisitsRootView *_rootView;
    id<APBNSURLSessionProtocol> _urlSession;
}

- (id)initWithUrlSession:(nonnull id<APBNSURLSessionProtocol>)urlSession;

@property (nonatomic) APBVisitsRootView *rootView;

@end

NS_ASSUME_NONNULL_END
