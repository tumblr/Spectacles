#import <Foundation/Foundation.h>

@class TMLibraryVersion;

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
 *  @see http://guides.cocoapods.org/syntax/podspec.html#version
 */
@property (nonatomic, readonly) TMLibraryVersion *libraryVersion;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#authors
 */
@property (nonatomic, readonly) NSArray/*<TMAuthor>*/ *authors;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#social_media_url
 */
@property (nonatomic, readonly) NSURL *socialMediaURL;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#docset_url
 */
@property (nonatomic, readonly) NSURL *docsetURL;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#homepage
 */
@property (nonatomic, readonly) NSURL *homepageURL;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#summary
 */
@property (nonatomic, readonly) NSString *summary;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#description
 */
@property (nonatomic, readonly) NSString *descriptionString;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#screenshots
 */
@property (nonatomic, readonly) NSArray/*<NSURL>*/ *screenshotURLs;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#documentation_url
 */
@property (nonatomic, readonly) NSURL *documentationURL;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#prepare_command
 */
@property (nonatomic, readonly) NSString *prepareCommand;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#deprecated
 */
@property (nonatomic, readonly, getter=isDeprecated) BOOL deprecated;

/**
 *  @see http://guides.cocoapods.org/syntax/podspec.html#deprecated_in_favor_of
 */
@property (nonatomic, readonly) NSString *podNameDeprecatedInFavorOf;

/**
 *  Create a model object representation of a podspec file.
 *
 *  @param fileURL Local JSON podspec file URL.
 *
 *  @return Model object representation of a podspec file, or `nil` if either 1) `fileURL` is `nil` 2) a file does not
 *  exist at `fileURL` 3) the file at `fileURL` cannot be parsed as JSON 4) the JSON is not a dictionary type.
 */
- (instancetype)initWithFileURL:(NSURL *)fileURL;

/**
 *  Create a model object representation of a podspec file.
 *
 *  @param data JSON Data of the Podspec.
 *
 *  @return Model object representation of a podspec file, or `nil` if either 1) `data` is `nil` 2) the `data` cannot be parsed as JSON 3) the JSON is not a dictionary type.
 */
- (instancetype)initWithData:(NSData *)data NS_DESIGNATED_INITIALIZER;

@end
