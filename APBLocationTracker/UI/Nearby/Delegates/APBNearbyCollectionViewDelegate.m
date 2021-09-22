//
//  APBLocationsCollectionViewDelegate.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 15/09/2021
//

#import "APBNearbyCollectionViewDelegate.h"
#import <APBFoundation/APBFoundation.h>
#import "APBLocationMO+CoreDataClass.h"

@implementation APBNearbyCollectionViewDelegate

#pragma mark - Constants

CGFloat const kNearbyCellMargin = 8;
CGFloat const kNearbyCellHeight = 150;

#pragma mark - Init methods

- (instancetype)initWithClass:(Class)class resuseIdentifier:(NSString *)identifier {
    self = [super init];

    if (self) {
        _cellClass = class;
        _reuseIdentifier = identifier;
    }

    return self;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APBBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier
                                                                                forIndexPath:indexPath];

    APBLocationMO *location = [self.data objectAtIndex:indexPath.item];
    cell.data = location;

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data != nil && self.data.count > 0 ? self.data.count : 0;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.data != nil && self.data.count > 0){
        CGFloat spacing = kNearbyCellMargin * 2;
        CGFloat width = [UIApplication sharedApplication].windows.firstObject.bounds.size.width - spacing;
        CGFloat height = kNearbyCellHeight;
        return CGSizeMake(width, height);
    } else {
        return CGSizeZero;
    }
}

@end
