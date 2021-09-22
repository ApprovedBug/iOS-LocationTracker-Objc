//
//  APBVisitsCollectionViewDelegate.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 20/09/2021
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface APBVisitsCollectionViewDelegate : NSObject<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (instancetype)initWithClass:(Class)class resuseIdentifier:(NSString *)identifier;

@property (nonatomic) NSArray *data;
@property (nonatomic) Class cellClass;
@property (nonatomic) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
