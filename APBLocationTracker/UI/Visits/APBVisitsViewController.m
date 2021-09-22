//
//  APBVisitsViewController.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 17/09/2021
//

#import "APBVisitsViewController.h"
#import "APBVisitsCollectionViewDelegate.h"
#import "APBVisitCollectionViewCell.h"
#import "Constants.h"
#import "APBVisitMO+CoreDataClass.h"
#import "APBLocationMO+CoreDataClass.h"


@interface APBVisitsViewController ()

@property (nonatomic) APBVisitsCollectionViewDelegate *visitsCollectionViewDelegate;

@end

@implementation APBVisitsViewController

@dynamic rootView;

#pragma mark - Properties

- (APBVisitsCollectionViewDelegate *)visitsCollectionViewDelegate {
    if (_visitsCollectionViewDelegate == nil) {
        _visitsCollectionViewDelegate = [[APBVisitsCollectionViewDelegate alloc]
                                         initWithClass:[APBVisitCollectionViewCell class]
                                         resuseIdentifier:@"visitCell"];
    }
    return _visitsCollectionViewDelegate;
}

- (APBVisitsRootView *)rootView {
    if (_rootView == nil) {
        _rootView = [[APBVisitsRootView alloc] init];
        _rootView.visitsCollectionView.dataSource = self.visitsCollectionViewDelegate;
        _rootView.visitsCollectionView.delegate = self.visitsCollectionViewDelegate;
        [_rootView.visitsCollectionView registerClass:self.visitsCollectionViewDelegate.cellClass
                              forCellWithReuseIdentifier:self.visitsCollectionViewDelegate.reuseIdentifier];
    }
    return _rootView;
}

#pragma mark - View load methods

- (instancetype)initWithUrlSession:(id<APBNSURLSessionProtocol>)urlSession {
    _urlSession = urlSession;
    self = [super init];
    return self;
}

- (void)loadView {
    [super loadView];

    [self setupNotifications];
}

- (void)loadData {

    [self.rootView.activityIndicatorView startAnimating];

    // check for coordinates
    NSArray *unsearchedVisits = [APBVisitMO unsearched];

    // find location for a visit
    if (unsearchedVisits != nil && unsearchedVisits.count > 0) {

        for (APBVisitMO *visit in unsearchedVisits) {
            int requestsFired = 0;
            __block int requestsCompleted = 0;
            if (!visit.searched) {
                requestsFired++;
                [visit searchForLocationWithURLSession:_urlSession
                                            completion:^(BOOL success) {
                    if (success) {
                        requestsCompleted++;
                        NSLog(@"%@", [NSString stringWithFormat:@"Visit load completed. Requests - %d, Completed - %d", requestsFired, requestsCompleted]);
                        if (requestsFired == requestsCompleted) {
                            [self displayVisits];
                        }
                    }
                }];
            }
        }
    } else {
        [self displayVisits];
    }
}

#pragma mark - Private methods

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNewVisit:)
                                                 name:kAPBVisitDetected
                                               object:nil];
}

- (void)handleNewVisit:(NSNotification *)notification {

}

- (void)displayVisits {
    NSArray *visits = [APBVisitMO all];
    self.visitsCollectionViewDelegate.data = visits;
    [self.rootView.activityIndicatorView stopAnimating];
    [self.rootView.visitsCollectionView reloadData];
}

@end
