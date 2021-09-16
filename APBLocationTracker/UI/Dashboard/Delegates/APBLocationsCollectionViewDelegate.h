//
//  APBLocationsCollectionViewDelegate.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 15/09/2021
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface APBLocationsCollectionViewDelegate : NSObject<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (instancetype)initWithClass:(Class)class resuseIdentifier:(NSString *)identifier;

@property (nonatomic) NSArray *data;
@property (nonatomic) Class cellClass;
@property (nonatomic) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
