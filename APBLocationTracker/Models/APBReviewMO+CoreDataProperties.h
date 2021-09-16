//
//  APBReviewMO+CoreDataProperties.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//
//

#import "APBReviewMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface APBReviewMO (CoreDataProperties)

+ (NSFetchRequest<APBReviewMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *author;
@property (nullable, nonatomic, copy) NSUUID *id;
@property (nonatomic) int16_t rating;
@property (nullable, nonatomic, copy) NSString *relativeTimeDescription;
@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, retain) APBLocationMO *location;

@end

NS_ASSUME_NONNULL_END
