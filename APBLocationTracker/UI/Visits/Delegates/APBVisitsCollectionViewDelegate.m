//
//  APBVisitsCollectionViewDelegate.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//

#import "APBVisitsCollectionViewDelegate.h"
#import "APBBaseCollectionViewCell.h"
#import "APBVisitMO+CoreDataClass.h"

@implementation APBVisitsCollectionViewDelegate

#pragma mark - Constants

CGFloat const kVisitsCellMargin = 8;
CGFloat const kVisitsCellHeight = 150;

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

    APBVisitMO *location = [self.data objectAtIndex:indexPath.item];
    cell.data = location;

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data != nil && self.data.count > 0 ? self.data.count : 0;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.data != nil && self.data.count > 0){
        CGFloat spacing = kVisitsCellMargin * 2;
        CGFloat width = [UIApplication sharedApplication].windows.firstObject.bounds.size.width - spacing;
        CGFloat height = kVisitsCellHeight;
        return CGSizeMake(width, height);
    } else {
        return CGSizeZero;
    }
}

@end
