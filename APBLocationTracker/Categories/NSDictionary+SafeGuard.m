//
//  NSDictionary+SafeGuard.m
//  APBLocationTracker
//
//  Created by ApprovedBug on 14/09/2021
//

#import "NSDictionary+SafeGuard.h"

@implementation NSDictionary (SafeGuard)

- (id)valueForKey:(NSString *)key ifKindOf:(Class)class {
    id obj = [self objectForKey:key];
    return [obj isKindOfClass:class] ? obj : nil;
}

- (id)valueForKey:(NSString *)key ifKindOf:(Class)class defaultValue:(id)defaultValue {
    id obj = [self objectForKey:key];
    return [obj isKindOfClass:class] ? obj : defaultValue;
}

@end
