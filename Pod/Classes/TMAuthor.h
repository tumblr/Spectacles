//
//  TMAuthor.h
//  Pods
//
//  Created by Matthew Bischoff on 1/10/15.
//
//

#import <Foundation/Foundation.h>

/**
 *  A TMAuthor is a model class describing an author or maintainer of a Pod.
 *
 *  @see http://guides.cocoapods.org/syntax/podspec.html#authors
 */
@interface TMAuthor : NSObject

/// The name of the author.
@property (nonatomic, readonly) NSString *name;

/// The email address of the author.
@property (nonatomic, readonly) NSString *emailAddress;

/// Returns an initialized TMAuthor with the given name and email address.
- (instancetype)initWithName:(NSString *)name emailAddress:(NSString *)emailAddress;

@end
