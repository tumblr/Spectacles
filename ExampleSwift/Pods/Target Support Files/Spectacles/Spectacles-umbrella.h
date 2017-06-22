#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TMAuthor.h"
#import "TMLibraryVersion.h"
#import "TMPodspec.h"

FOUNDATION_EXPORT double SpectaclesVersionNumber;
FOUNDATION_EXPORT const unsigned char SpectaclesVersionString[];

