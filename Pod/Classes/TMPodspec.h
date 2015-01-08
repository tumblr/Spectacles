#import <Foundation/Foundation.h>

/**
 *  Parses a CocoaPods “podspec” file and provides a model object representation.
 *
 *  @see http://guides.cocoapods.org/syntax/podspec.html
 */
@interface TMPodspec : NSObject

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#name
 */
@property (nonatomic, readonly) NSString *name;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#version
 */
@property (nonatomic, readonly) NSString *version;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#summary
 */
@property (nonatomic, readonly) NSString *summary;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#homepage
 */
@property (nonatomic, readonly) NSURL *homepageURL;

/**
 *  Create a model object representation of a podspec file.
 *
 *  @param fileURL Local JSON podspec file URL.
 *
 *  @return Model object representation of a podspec file, or `nil` if either 1) `fileURL` is `nil` 2) a file does not
 *  exist at `fileURL` 3) the file at `fileURL` cannot be parsed as JSON 4) the JSON is not a dictionary type.
 */
- (instancetype)initWithFileURL:(NSURL *)fileURL NS_DESIGNATED_INITIALIZER;

@end
