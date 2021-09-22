//
//  APBVisitsRootView.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//

#import <APBFoundation/APBFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APBVisitsRootView : APBBaseView

@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic) UICollectionView *visitsCollectionView;

@end

NS_ASSUME_NONNULL_END
