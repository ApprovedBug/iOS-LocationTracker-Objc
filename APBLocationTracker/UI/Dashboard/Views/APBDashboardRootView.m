//
//  APBDashboardRootView.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 09/09/2021
//

#import "APBDashboardRootView.h"
#import "FLKAutoLayout.h"

@implementation APBDashboardRootView

#pragma mark - Subviews

- (UICollectionView *)locationsCollectionView {
    if (_locationsCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _locationsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _locationsCollectionView.backgroundColor = [UIColor clearColor];
        _locationsCollectionView.contentInset = UIEdgeInsetsMake(64, 8, 0, 8);
    }
    return _locationsCollectionView;
}

#pragma mark - View setup

- (void)setupSubviews {
    [self addSubview:self.locationsCollectionView];
}

- (void)setupAutolayout {
    [self.locationsCollectionView alignToView:self];
}

@end
