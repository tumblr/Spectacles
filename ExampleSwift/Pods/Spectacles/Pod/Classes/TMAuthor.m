#import "TMAuthor.h"

@implementation TMAuthor

#pragma mark - NSObject

- (instancetype)init {
    return [self initWithName:nil emailAddress:nil];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[TMAuthor class]]) {
        return NO;
    }
    
    return [self isEqualToAuthor:(TMAuthor *)object];
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

- (BOOL)isEqualToAuthor:(TMAuthor *)author {
    if (!author) {
        return NO;
    }
    
    BOOL haveEqualNames = (!self.name && !author.name) || [self.name isEqualToString:author.name];
    BOOL haveEqualEmailAddresses = (!self.emailAddress && !author.emailAddress) || [self.emailAddress isEqualToString:author.emailAddress];
    
    return haveEqualNames && haveEqualEmailAddresses;
}

@end
