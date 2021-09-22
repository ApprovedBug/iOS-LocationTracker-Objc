//
//  APBLocationMO+CoreDataProperties.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//
//

#import "APBLocationMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface APBLocationMO (CoreDataProperties)

+ (NSFetchRequest<APBLocationMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double rating;
@property (nullable, nonatomic, copy) NSString *thumbnailUrl;
@property (nullable, nonatomic, retain) NSArray *types;
@property (nullable, nonatomic, copy) NSString *vicinity;
@property (nonatomic) int16_t userRatingsTotal;
@property (nonatomic) int16_t priceLevel;
@property (nullable, nonatomic, retain) NSSet<APBPhotoMO *> *photos;
@property (nullable, nonatomic, retain) NSSet<APBReviewMO *> *reviews;

@end

@interface APBLocationMO (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(APBPhotoMO *)value;
- (void)removePhotosObject:(APBPhotoMO *)value;
- (void)addPhotos:(NSSet<APBPhotoMO *> *)values;
- (void)removePhotos:(NSSet<APBPhotoMO *> *)values;

- (void)addReviewsObject:(APBReviewMO *)value;
- (void)removeReviewsObject:(APBReviewMO *)value;
- (void)addReviews:(NSSet<APBReviewMO *> *)values;
- (void)removeReviews:(NSSet<APBReviewMO *> *)values;

@end

NS_ASSUME_NONNULL_END
