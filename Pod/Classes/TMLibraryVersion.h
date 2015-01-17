#import <Foundation/Foundation.h>

/**
 *  `TMLibraryVersion` is a model object describing the semantic version of a Cocoapod. It is designed to parse the "version" field of a Podspec.json file and provide access to the structured version information contained in the string.
 *
 *  @see http://guides.cocoapods.org/making/making-a-cocoapod.html#cocoapods-versioning-specifics
 */
@interface TMLibraryVersion : NSObject

/// The major version of the library. Incremented when the author makes incompatible API changes.
@property (nonatomic, readonly) NSInteger majorVersion;

/// The minor version of the library. Incremented when the authors adds functionality in a backwards-compatible manner.
@property (nonatomic, readonly) NSInteger minorVersion;

/// The patch version of the library. Incremented when the authors make backwards-compatible bug fixes.
@property (nonatomic, readonly) NSInteger patchVersion;

/// A boolean value indicating whether this version of the library is a prerelease.
@property (nonatomic, readonly, getter=isPrereleaseVersion) BOOL prereleaseVersion;

/// A string identifying the prerelease version. Often something like "beta3" but no official format is specified.
@property (nonatomic, readonly) NSString *prereleaseVersionIdentifier;

/**
 *  Returns a populated `TMLibraryVersion` from the given version string.
 *
 *  @param versionString A string in the format "1.3.7-beta4" with each segment being optional.
 *
 *  @return An instance of `TMLibraryVersion`.
 */
- (instancetype)initWithString:(NSString *)versionString NS_DESIGNATED_INITIALIZER;

@end
