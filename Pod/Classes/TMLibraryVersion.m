//
//  TMLibraryVersion.m
//  Pods
//
//  Created by Matthew Bischoff on 1/10/15.
//
//

#import "TMLibraryVersion.h"

typedef NS_ENUM(NSInteger, TMLibraryVersionComponent) {
    TMLibraryVersionComponentMajor = 0,
    TMLibraryVersionComponentMinor,
    TMLibraryVersionComponentPatch,
};

static NSString * TMLibraryVersionComponentSeparator = @".";
static NSString * TMLibraryVersionPrereleaseSeparator = @"-";

@interface TMLibraryVersion ()

@property (nonatomic) NSInteger majorVersion;
@property (nonatomic) NSInteger minorVersion;
@property (nonatomic) NSInteger patchVersion;

@property (nonatomic) NSString *prereleaseVersionIdentifier;
@property (nonatomic) BOOL prereleaseVersion;

@property (nonatomic) NSString *versionString;
@property (nonatomic, readonly) NSArray *versionComponents;

@end

@implementation TMLibraryVersion

#pragma mark - NSObject

- (instancetype)init {
    return [self initWithString:nil];
}

#pragma mark - TMLibraryVersion

- (instancetype)initWithString:(NSString *)versionString {
    self = [super init];
    
    if (self) {
        _versionString = [versionString copy];
    }
    
    return self;
}

- (NSInteger)majorVersion {
    return [self versionIntegerAtIndex:TMLibraryVersionComponentMajor];
}

- (NSInteger)minorVersion {
    return [self versionIntegerAtIndex:TMLibraryVersionComponentMinor];
}

- (NSInteger)patchVersion {
    return [self versionIntegerAtIndex:TMLibraryVersionComponentPatch];
}

- (BOOL)isPrereleaseVersion {
    return [self.versionComponents.lastObject rangeOfString:TMLibraryVersionPrereleaseSeparator].location != NSNotFound;
}

- (NSString *)prereleaseVersionIdentifier {
    if (self.isPrereleaseVersion) {
        return [self.versionComponents.lastObject componentsSeparatedByString:TMLibraryVersionPrereleaseSeparator].lastObject;
    }
    
    return nil;
}

#pragma mark - Private

- (NSArray *)versionComponents {
    return [self.versionString componentsSeparatedByString:TMLibraryVersionComponentSeparator];
}

- (NSString *)componentAtIndex:(NSInteger)index {
    if (index < self.versionComponents.count) {
        return self.versionComponents[index];
    }
    
    return nil;
}

- (NSInteger)versionIntegerAtIndex:(NSInteger)index {
    NSString *componentString = [self componentAtIndex:index];
    NSString *versionNumberString = [componentString componentsSeparatedByString:TMLibraryVersionPrereleaseSeparator].firstObject;
    return versionNumberString.integerValue;
}

@end
