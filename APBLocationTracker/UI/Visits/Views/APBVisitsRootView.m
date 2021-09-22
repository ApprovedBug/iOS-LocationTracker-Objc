//
//  APBVisitsRootView.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//

#import "APBVisitsRootView.h"
#import "FLKAutoLayout.h"

@implementation APBVisitsRootView

#pragma mark - Subviews

- (UIActivityIndicatorView *)activityIndicatorView {
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        _activityIndicatorView.hidesWhenStopped = YES;
    }
    return _activityIndicatorView;
}

- (UICollectionView *)visitsCollectionView {
    if (_visitsCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _visitsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _visitsCollectionView.backgroundColor = [UIColor clearColor];
        _visitsCollectionView.contentInset = UIEdgeInsetsMake(64, 8, 0, 8);
    }
    return _visitsCollectionView;
}

#pragma mark - View setup

- (void)setupSubviews {
    [self addSubview:self.activityIndicatorView];
    [self addSubview:self.visitsCollectionView];
}

- (void)setupAutolayout  {

    // activity indicator view
    [self.activityIndicatorView alignCenterWithView:self];

    // collection view
    [self.visitsCollectionView alignToView:self];
}

@end
