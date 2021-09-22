//
//  APBDashboardRootView.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 09/09/2021
//

#import "APBNearbyRootView.h"
#import "FLKAutoLayout.h"

@implementation APBNearbyRootView

#pragma mark - Subviews

- (UIActivityIndicatorView *)activityIndicatorView {
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        _activityIndicatorView.hidesWhenStopped = YES;
    }
    return _activityIndicatorView;
}

- (UICollectionView *)locationsCollectionView {
    if (_locationsCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _locationsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _locationsCollectionView.backgroundColor = [UIColor clearColor];
        _locationsCollectionView.contentInset = UIEdgeInsetsMake(12, 0, 12, 0);
    }
    return _locationsCollectionView;
}

#pragma mark - View setup

- (void)setupSubviews {
    [self addSubview:self.activityIndicatorView];
    [self addSubview:self.locationsCollectionView];
}

- (void)setupAutolayout {
    [self.activityIndicatorView alignCenterWithView:self];
    [self.locationsCollectionView alignToView:self];
}

@end
