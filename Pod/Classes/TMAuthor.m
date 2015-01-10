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
    BOOL equal = NO;
    
    if ([object isKindOfClass:[self class]]) {
        TMAuthor *author = (TMAuthor *)object;

        BOOL haveEqualNames = (!self.name && !author.name) || [self.name isEqualToString:author.name];
        BOOL haveEqualEmailAddresses = (!self.emailAddress && !author.emailAddress) || [self.emailAddress isEqualToString:author.emailAddress];
        
        equal = haveEqualNames && haveEqualEmailAddresses;
    }
    
    return equal;
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
