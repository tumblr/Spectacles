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
 *  Create a model object representation of a Podspec file.
 *
 *  @param fileURL Local Podspec file URL.
 *
 *  @return Model object representation of a Podspec file.
 */
- (instancetype)initWithFileURL:(NSURL *)fileURL NS_DESIGNATED_INITIALIZER;

@end
