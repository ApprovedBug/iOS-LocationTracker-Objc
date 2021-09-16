//
//  NSDictionary+SafeGuard.h
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (SafeGuard)

- (id)valueForKey:(NSString *)key ifKindOf:(Class)class;
- (id)valueForKey:(NSString *)key ifKindOf:(Class)class defaultValue:(id)defaultValue;

@end

NS_ASSUME_NONNULL_END
