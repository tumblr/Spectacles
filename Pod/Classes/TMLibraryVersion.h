//
//  TMLibraryVersion.h
//  Pods
//
//  Created by Matthew Bischoff on 1/10/15.
//
//

#import <Foundation/Foundation.h>

@interface TMLibraryVersion : NSObject

@property (nonatomic, readonly) NSInteger majorVersion;
@property (nonatomic, readonly) NSInteger minorVersion;
@property (nonatomic, readonly) NSInteger patchVersion;

@property (nonatomic, readonly, getter=isPrereleaseVersion) BOOL prereleaseVersion;
@property (nonatomic, readonly) NSString *prereleaseVersionIdentifier;

- (instancetype)initWithString:(NSString *)versionString NS_DESIGNATED_INITIALIZER;

@end
