//
//  TMAuthor.m
//  Pods
//
//  Created by Matthew Bischoff on 1/10/15.
//
//

#import "TMAuthor.h"

@implementation TMAuthor

#pragma mark - NSObject

- (instancetype)init {
    return [self initWithName:nil emailAddress:nil];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        return [self.name isEqual:((TMAuthor *)object).name] && [self.emailAddress isEqual:((TMAuthor *)object).emailAddress];;
    }
    
    return NO;
}

- (NSUInteger)hash {
    return self.name.hash ^ self.emailAddress.hash;
}

#pragma mark - TMAuthor

- (instancetype)initWithName:(NSString *)name emailAddress:(NSString *)emailAddress {
    self = [super init];
    
    if (self) {
        _name = [name copy];
        _emailAddress = [emailAddress copy];
    }
    
    return self;
}

@end
